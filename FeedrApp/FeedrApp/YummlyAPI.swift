//
//  YummlyAPI.swift
//  Feedr
//
//  Created by chad hoang on 10/12/17.
//  Copyright © 2017 Chad Hoang. All rights reserved.
//

/*
     Example of how to use the global yummlyAPI search function.
 
     Call anywhere with: YummlyAPI.GetSearch(_Parameters_
https://api.yummly.com/v1/api/recipes?_app_id=51013d4c&_app_key=0549dc2605e77741e0feb12736c65087&q=egg&requirePictures=true&allowedCourse[]=course^course-Appetizers&maxResult=50
https://api.yummly.com/v1/api/recipes?_app_id=51013d4c&_app_key=0549dc2605e77741e0feb12736c65087&q=egg&requirePictures=true&allowedCourse[]=course^course-Appetizers&maxResult=50     Parameters to fill are:
 
         search: String                         //  General string to search with. Examples: "Soup", "Garlic", "Chocolate Cake" etc. USE SINGLE SPACE ONLY.
         requirePictures: Bool                  //  should the search only return results with pictures? (Most likey will be using True all the time)
         allowedIngredients: [String]           //  Array of strings containing names of ingredients to allow in the search. Ex. ["garlic", "onion", "apple"]
         allowedAllergies: [Allergy]            //  Array of Allergy to be allowed in search. Ex. [Allergy.Diary, Allergy.Gluten]. See YummlyAPI.swift for all types
         allowedDiet: [Diet]                    //  Array of Diet to be allowed in search. Ex. [Diet.Vegan, Diet.Pescetarian]. See YummlyAPI.swift for all types
         allowedCuisines: []                    //  Array of Cuisine to be allowed in search. Ex. [Cuisine.Asian, Cuisine.Mexican]. See YummlyAPI.swift for all types
         excludedCuisines: []                   //  Array of Cuisine to be excluded in search. Ex. [Cuisine.Asian, Cuisine.Mexican]. See YummlyAPI.swift for all types
         allowedCourses: []                     //  Array of Courses to be allowed in search. Ex. [Course.Breakfest, Course.Brunch]. See YummlyAPI.swift for all types
         excludeCourses: []                     //  Array of Course to be excluded in search. Ex. [Course.Breakfest, Course.Brunch]. See YummlyAPI.swift for all types
         allowedHoliday: []                     //  Array of Holiday to be allowed in search. Ex. [Holiday.Christmas, Holiday.Summer]. See YummlyAPI.swift for all types
         excludeHoliday: []                     //  Array of Holiday to be excluded in search. Ex. [Holiday.Christmas, Holiday.Summer]. See YummlyAPI.swift for all types
         maxTotalTimeInSeconds: Int             //  Allowed recipes in search only under this cooking time in seconds. Ex. 5000 = 83 minutes or 5000(seconds)
         maxResults: Int                        //  Max number of results allowed to be returned by the search (There might be a bug? Looking into it)
 
     Due to how JSON has to wait for the data to be parsed. To use the result, the function must have {} at the end with "result in" to acccess the data. Exmaple below:
 
     YummlyAPI.GetSearch(....)
     { result in
         // Do stuff with result
     }
 */

/*  Exmaple search with general search only
 
    YummlyAPI.GetSearch(
        search: "soup",
        requirePictures: true,
        allowedIngredients: [],
        allowedAllergies: [],
        allowedDiet: [],
        allowedCuisines: [],
        excludedCuisines: [],
        allowedCourses: [],
        excludeCourses: [],
        allowedHoliday: [],
        excludeHoliday: [],
        maxTotalTimeInSeconds: -1,
        maxResults: -1)
     { result in
 
         print (result.matches)
 
     }
*/

/*
     The Structure of the Result:
 
     -Result
         -attribution
             -html
             -url
             -text
             -logo
         -totalMatchCount
         -facetCounts
         -matches
             -attributes
                 -course
                 -cuisine
             -flavors
                 -salty
                 -sour
                 -sweet
                 -bitter
                 -meaty
                 -piquant
             -rating
             -id
             -smallImageUrls
             -sourceDisplayName
             -totalTimeInSeconds
             -ingredients
             -recipeName
         -criteria
             -maxResults
             -excludedIngredients
             -excludedAttributes
             -allowedIngredients
             -attributeRanges
                 -flavorPiquant
                     -min
                     -max
             -nutritionRestrictions
                 -nutrition
                     -min
                     -max
             -allowedDiets
             -resultsToSkip
             -requirePictures
             -facetFields
             -terms
             -allowedAttributes
 */

/*
	To get an array of all the ingredients that exists on Yummly, use YummlyAPI.GetIngredientsMetadata() to return a array of Ingredient

	Example:

		let ingredients = YummlyAPI.GetIngredientsMetadata()

		print(ingredients)	//	This will print all the ingredient and structs. THIS WILL LAG CAUSE ITS A BIG LIST!!!
*/

import Foundation

/*
	 Search Enums
 */
public enum Cuisine
{
    case American
    case Italian
    case Asian
    case Mexican
    case Southern
    case French
    case Southwestern
    case Barbecue
    case Indian
    case Chinese
    case Cajun
    case English
    case Mediterranean
    case Greek
    case Spanish
    case German
    case Thai
    case Moroccan
    case Irish
    case Japanese
    case Cuban
    case Hawaiin
    case Swedish
    case Hungarian
    case Portugese
}

public enum Allergy
{
    case Diary
    case Gluten
    case Peanut
    case Seafood
    case Sesame
    case Soy
    case Sulfite
    case TreeNut
    case Wheat
    case Egg
}

public enum Diet
{
    case LactoVegetarian
    case OvoVegetarian
    case Pescetarian
    case Vegen
    case Vegetarian
}

public enum Course
{
    case Main
    case Desserts
    case Sides
    case Lunch
    case Appetizers
    case Salads
    case Breads
    case Breakfast
    case Soups
    case Beverages
    case Condiments
    case Cocktails
}

public enum Holiday
{
    case Christmas
    case Summer
    case Thanksgiving
    case NewYear
    case SuperBowl
    case Halloween
    case Hanukkah
    case FourthOfJuly
}

/*
	 Search JSON structure
*/

struct Result: Codable
{
    let attribution : Attribution?
    let totalMatchCount : Int?
    let facetCounts : [String: String]?
    let matches : [Match]?
    let criteria : Criteria?
    
    //  "Blank" constructor
    init()
    {
        attribution = Attribution(html: "", url: "", text: "", logo: "")
        totalMatchCount = -1
        facetCounts = ["":""]
        matches = []
        criteria = Criteria(maxResults: -1,
                            excludedAttributes : [],
                            allowedIngredients : [],
							excludedIngredients: [],
                            attributeRanges : AttributeRanges(flavorPiquant: FlavorPiquant(min: 0.0, max: 0.0)),
                            nutritionRestrictions : NutritionRestrictions(nutrition: []),
                            allowedDiets : [],
                            resultsToSkip : -1,
                            requirePictures : false,
                            facetFields : [],
                            terms : [],
                            allowedAttributes : [])
    }
}
struct Attribution: Codable
{
    let html : String?
    let url : String?
    let text : String?
    let logo : String?
}
struct Match: Codable
{
    let attributes : Attributes?
	//let flavors : [String : String]?
	let flavors : Flavors?
    let rating : Float?
    let id : String?
    let smallImageUrls : [String]?
    let sourceDisplayName : String?
    let totalTimeInSeconds : Int?
    let ingredients : [String]?
    let recipeName : String?
    
    init()
    {
		attributes = Attributes(course: [], cuisine: [], holiday: [])
		flavors = Flavors(Piquant: -1, Meaty: -1, Bitter: -1, Sweet: -1, Sour: -1, Salty: -1)
		//flavors =
        rating = -1
        id = ""
        smallImageUrls = []
        sourceDisplayName = ""
        totalTimeInSeconds = -1
        ingredients = []
        recipeName = ""
    }
    
    func GetCookingTime() -> String
    {
		//	Error handling
		if totalTimeInSeconds == nil || totalTimeInSeconds! <= -1
		{
			return "-1"
		}
		
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: TimeInterval(totalTimeInSeconds!))!
    }
}
struct Attributes: Codable
{
    let course : [String]?
    let cuisine : [String]?
    let holiday : [String]?
}
struct Flavors: Codable
{
	let Piquant : Float?
	let Meaty : Float?
	let Bitter : Float?
	let Sweet : Float?
	let Sour : Float?
    let Salty : Float?
}
struct Criteria: Codable
{
    let maxResults : Int?
    let excludedAttributes : [String]?
    let allowedIngredients : [String]?
	let excludedIngredients : [String]?
    let attributeRanges : AttributeRanges?
    let nutritionRestrictions : NutritionRestrictions?
    let allowedDiets : [String]?
    let resultsToSkip : Int?
    let requirePictures : Bool?
    let facetFields : [String]?
    let terms : [String]?
    let allowedAttributes : [String]?
}
struct AttributeRanges: Codable
{
    let flavorPiquant : FlavorPiquant?
}
struct FlavorPiquant: Codable
{
    let min : Float
    let max : Float
}
struct NutritionRestrictions: Codable
{
    let nutrition : [Nutrition]?
}
struct Nutrition: Codable
{
    let min : Int
    let max : Int
}

/*
 Recipe JSON structure
 */

struct Recipe : Codable
{
	let yield: String?
	let nutritionEstimates: [NutritionEstimate]?
	let prepTimeInSeconds: Int?
	var totalTime: String?
	let images: [ImageURL]?
	let name: String?
	let source: Source?
	let id : String?
	let ingredientLines: [String]?
	let cookTime: String?
	let attribution: Attribution?
	let numberOfServings: Int?
	let totalTimeInSeconds: Int?
	let attributes: Attributes
	let cookTimeInSeconds: Int?
	let flavors: Flavors?
	let rating: Float?
	
	//  "Blank" constructor
	init()
	{
		attribution = Attribution(html: "", url: "", text: "", logo: "")
		ingredientLines = []
		flavors = Flavors(Piquant: -1, Meaty: -1, Bitter: -1, Sweet: -1, Sour: -1, Salty: -1)
		nutritionEstimates = []
		images = []
		name = ""
		yield = ""
		totalTime = ""
		cookTime = ""
		cookTimeInSeconds = -1
		prepTimeInSeconds = -1
		totalTime = ""
		attributes = Attributes(course : [], cuisine : [], holiday : [])
		totalTimeInSeconds = -1
		rating = -1
		numberOfServings = -1
		source = Source(sourceDisplayName: "", sourceSiteUrl: "", sourceRecipeUrl: "")
		id = ""
	}
	
	func GetCookingTime() -> String
	{
		//	Error handling
		if totalTimeInSeconds == nil || totalTimeInSeconds! <= -1
		{
			return "-1"
		}
		
		let formatter = DateComponentsFormatter()
		formatter.unitsStyle = .abbreviated
		return formatter.string(from: TimeInterval(totalTimeInSeconds!))!
	}
}
struct NutritionEstimate: Codable
{
    let attribute: String?
    let description: String?
    let value: Float?
    let unit: Unit?
}
struct Unit: Codable
{
	let id: String?
    let name: String?
    let abbreviation: String?
    let plural: String?
    let pluralAbbreviation: String?
	let decimal: Bool?
}
struct ImageURL: Codable
{
    let hostedLargeUrl: String?
    let hostedMediumUrl: String?
    let hostedSmallUrl: String?
}
struct Source: Codable
{
	let sourceDisplayName: String?
    let sourceSiteUrl: String?
	let sourceRecipeUrl: String?
}


/*
	Integredients Metadata JSON Structure
*/

struct Ingredient: Codable
{
	let searchValue: String?
	let description: String?
	let term: String?
}

class YummlyAPI
{
    //  GLOBAL VARIABLES
	static let IngredientsMetadata = GetIngredientsMetadata()				//	Cache entire ingredients metadata into a array
    static var RecipeDetailHistory = [Recipe]()                             //  Contains the history of all recipes that were viewed
    static var ResultsSearchHistory = [Match]()                             //  Contains the history of all search results that were searched.
    
	//  yummly API variables
	private static let yummlyID = "51013d4c"
	private static let yummlyKey = "0549dc2605e77741e0feb12736c65087"
    
    //	Function that returns a search result enum that contains all the data
    static func GetSearch(search: String?,
                         requirePictures: Bool?,
                         allowedIngredients: [String]?,
                         excludedIngredients: [String]?,
                         allowedAllergies: [Allergy]?,
                         allowedDiet: [Diet]?,
                         allowedCuisines: [Cuisine]?,
                         excludedCuisines: [Cuisine]?,
                         allowedCourses: [Course]?,
                         excludeCourses: [Course]?,
                         allowedHoliday: [Holiday]?,
                         excludeHoliday: [Holiday]?,
                         maxTotalTimeInSeconds: Int?,
                         maxResults: Int?,
                         completion: @escaping (Result) -> ())
    {
        //  Replace spaces with '+'
        let search = search!.replacingOccurrences(of: " ", with: "+")

        //  Check check parameter errors
        if search.isEmpty
        {
            print("Search parameter is empty!")
        }
        
        //  Create the base query string that will request from yummly
        var query = "https://api.yummly.com/v1/api/recipes?_app_id=" + self.yummlyID + "&_app_key=" + self.yummlyKey
        
        //  Append to query with parameters
        if !search.isEmpty
        {
            query += "&q=" + search
        }
        //  Does search require pictures?
        if  requirePictures == true
        {
            query += "&requirePictures=true"
        }
		
        //  Allowed Ingredients
        if allowedIngredients != nil && allowedIngredients!.count > 0
        {
            for ingredient in allowedIngredients!
            {
                query += "&allowedIngredient[]=" + ingredient
            }
        }

		//  Excluded Ingredients
		if excludedIngredients != nil && excludedIngredients!.count > 0
		{
			for ingredient in excludedIngredients!
			{
				query += "&excludedIngredient[]=" + ingredient
			}
		}
		
        //  Allowed Allergies
        if allowedAllergies != nil && allowedAllergies!.count > 0
        {
            for allergy in allowedAllergies!
            {
                query += "&allowedAllergy[]="
                
                switch allergy
                {
                    case Allergy.Diary:
                        query += "396^Dairy-Free"
                    case Allergy.Gluten:
                        query += "393^Gluten-Free"
                    case Allergy.Peanut:
                        query += "394^Peanut-Free"
                    case Allergy.Seafood:
                        query += "398^Seafood-Free"
                    case Allergy.Sesame:
                        query += "399^Sesame-Free"
                    case Allergy.Soy:
                        query += "400^Soy-Free"
                    case Allergy.Sulfite:
                        query += "401^Sulfite-Free"
                    case Allergy.TreeNut:
                        query += "395^Tree Nut-Free"
                    case Allergy.Wheat:
                        query += "392^Wheat-Free"
                    case Allergy.Egg:
                        query += "397^Egg-Free"
                }
            }
        }
        //  Allowed Diets
        if allowedDiet != nil && allowedDiet!.count > 0
        {
            for diet in allowedDiet!
            {
                query += "&allowedDiet[]="
                
                switch diet
                {
                case Diet.LactoVegetarian:
                    query += "388^Lacto vegetarian"
                case Diet.OvoVegetarian:
                    query += "389^Ovo vegetarian"
                case Diet.Pescetarian:
                    query += "390^Pescetarian"
                case Diet.Vegen:
                    query += "386^Vegan"
                case Diet.Vegetarian:
                    query += "387^Lacto-ovo vegetarian"
                }
            }
        }
        //  Allowed Cuisines
        if allowedCuisines != nil && allowedCuisines!.count > 0
        {
            for cuisine in allowedCuisines!
            {
                query += "&allowedCuisine[]="
                
                switch cuisine
                {
                case Cuisine.American:
                    query += "cuisine^cuisine-american"
                case Cuisine.Asian:
                    query += "cuisine^cuisine-asian"
                case Cuisine.Barbecue:
                    query += "cuisine^cuisine-barbecue-bbq"
                case Cuisine.Cajun:
                    query += "cuisine^cuisine-cajun"
                case Cuisine.Chinese:
                    query += "cuisine^cuisine-chinese"
                case Cuisine.Cuban:
                    query += "cuisine^cuisine-cuban"
                case Cuisine.English:
                    query += "cuisine^cuisine-english"
                case Cuisine.French:
                    query += "cuisine^cuisine-french"
                case Cuisine.German:
                    query += "cuisine^cuisine-german"
                case Cuisine.Greek:
                    query += "cuisine^cuisine-greek"
                case Cuisine.Hawaiin:
                    query += "cuisine^cuisine-hawaiian"
                case Cuisine.Hungarian:
                    query += "cuisine^cuisine-hungarian"
                case Cuisine.Indian:
                    query += "cuisine^cuisine-indian"
                case Cuisine.Irish:
                    query += "cuisine^cuisine-irish"
                case Cuisine.Italian:
                    query += "cuisine^cuisine-italian"
                case Cuisine.Japanese:
                    query += "cuisine^cuisine-japanese"
                case Cuisine.Mediterranean:
                    query += "cuisine^cuisine-mediterranean"
                case Cuisine.Mexican:
                    query += "cuisine^cuisine-mexican"
                case Cuisine.Moroccan:
                    query += "cuisine^cuisine-moroccan"
                case Cuisine.Portugese:
                    query += "cuisine^cuisine-portuguese"
                case Cuisine.Southern:
                    query += "cuisine^cuisine-southern"
                case Cuisine.Southwestern:
                    query += "cuisine^cuisine-southwestern"
                case Cuisine.Spanish:
                    query += "cuisine^cuisine-spanish"
                case Cuisine.Swedish:
                    query += "cuisine^cuisine-swedish"
                case Cuisine.Thai:
                    query += "cuisine^cuisine-thai"
                }
            }
        }
        //  Excluded Cuisines
        if excludedCuisines != nil && excludedCuisines!.count > 0
        {
            for cuisine in excludedCuisines!
            {
                query += "&excludedCuisine[]="
                
                switch cuisine
                {
                case Cuisine.American:
                    query += "cuisine^cuisine-american"
                case Cuisine.Asian:
                    query += "cuisine^cuisine-asian"
                case Cuisine.Barbecue:
                    query += "cuisine^cuisine-barbecue-bbq"
                case Cuisine.Cajun:
                    query += "cuisine^cuisine-cajun"
                case Cuisine.Chinese:
                    query += "cuisine^cuisine-chinese"
                case Cuisine.Cuban:
                    query += "cuisine^cuisine-cuban"
                case Cuisine.English:
                    query += "cuisine^cuisine-english"
                case Cuisine.French:
                    query += "cuisine^cuisine-french"
                case Cuisine.German:
                    query += "cuisine^cuisine-german"
                case Cuisine.Greek:
                    query += "cuisine^cuisine-greek"
                case Cuisine.Hawaiin:
                    query += "cuisine^cuisine-hawaiian"
                case Cuisine.Hungarian:
                    query += "cuisine^cuisine-hungarian"
                case Cuisine.Indian:
                    query += "cuisine^cuisine-indian"
                case Cuisine.Irish:
                    query += "cuisine^cuisine-irish"
                case Cuisine.Italian:
                    query += "cuisine^cuisine-italian"
                case Cuisine.Japanese:
                    query += "cuisine^cuisine-japanese"
                case Cuisine.Mediterranean:
                    query += "cuisine^cuisine-mediterranean"
                case Cuisine.Mexican:
                    query += "cuisine^cuisine-mexican"
                case Cuisine.Moroccan:
                    query += "cuisine^cuisine-moroccan"
                case Cuisine.Portugese:
                    query += "cuisine^cuisine-portuguese"
                case Cuisine.Southern:
                    query += "cuisine^cuisine-southern"
                case Cuisine.Southwestern:
                    query += "cuisine^cuisine-southwestern"
                case Cuisine.Spanish:
                    query += "cuisine^cuisine-spanish"
                case Cuisine.Swedish:
                    query += "cuisine^cuisine-swedish"
                case Cuisine.Thai:
                    query += "cuisine^cuisine-thai"
                }
            }
        }
        //  Allowed Courses
        if allowedCourses != nil && allowedCourses!.count > 0
        {
            for course in allowedCourses!
            {
                query += "&allowedCourse[]="
                
                switch course
                {
                case Course.Appetizers:
                    query += "course^course-Appetizers"
                case Course.Beverages:
                    query += "course^course-Beverages"
                case Course.Breads:
                    query += "course^course-Breads"
                case Course.Breakfast:
                    query += "course^course-Breakfast%20and%20Brunch"
                case Course.Cocktails:
                    query += "course^course-Cocktails"
                case Course.Condiments:
                    query += "course^course-Condiments%20and%20Sauces"
                case Course.Desserts:
                    query += "course^course-Desserts"
                case Course.Lunch:
                    query += "course^course-Lunch"
                case Course.Main:
                    query += "course^course-Main Dishes"
                case Course.Salads:
                    query += "course^course-Salads"
                case Course.Sides:
                    query += "course^course-Side Dishes"
                case Course.Soups:
                    query += "course^course-Soups"
                }
            }
        }
        //  Excluded Courses
        if excludeCourses != nil && excludeCourses!.count > 0
        {
            for course in excludeCourses!
            {
                query += "&excludedCourse[]="
                
                switch course
                {
                case Course.Appetizers:
                    query += "course^course-Appetizers"
                case Course.Beverages:
                    query += "course^course-Beverages"
                case Course.Breads:
                    query += "course^course-Breads"
                case Course.Breakfast:
                    query += "course^course-Breakfast%20an%20Brunch"
                case Course.Cocktails:
                    query += "course^course-Cocktails"
                case Course.Condiments:
                    query += "course^course-Condiments%20and%20Sauces"
                case Course.Desserts:
                    query += "course^course-Desserts"
                case Course.Lunch:
                    query += "course^course-Lunch"
                case Course.Main:
                    query += "course^course-Main Dishes"
                case Course.Salads:
                    query += "course^course-Salads"
                case Course.Sides:
                    query += "course^course-Side Dishes"
                case Course.Soups:
                    query += "course^course-Soups"
                }
            }
        }
        //  Allowed Holiday
        if allowedHoliday != nil && allowedHoliday!.count > 0
        {
            for holiday in allowedHoliday!
            {
                query += "&excludedCourse[]="
                switch holiday
                {
                case Holiday.Christmas:
                    query += "holiday^holiday-christmas"
                case Holiday.FourthOfJuly:
                    query += "holiday^holiday-4th-of-july"
                case Holiday.Halloween:
                    query += "holiday^holiday-halloween"
                case Holiday.Hanukkah:
                    query += "holiday^holiday-hanukkah"
                case Holiday.NewYear:
                    query += "holiday^holiday-new-year"
                case Holiday.Summer:
                    query += "holiday^holiday-summer"
                case Holiday.SuperBowl:
                    query += "holiday^holiday-super-bowl"
                case Holiday.Thanksgiving:
                    query += "holiday^holiday-thanksgiving"
                }
            }
        }
        //  Excluded Holiday
        if excludeHoliday != nil && excludeHoliday!.count > 0
        {
            for holiday in excludeHoliday!
            {
                query += "&excludedHoliday[]="
                
                switch holiday
                {
                case Holiday.Christmas:
                    query += "holiday^holiday-christmas"
                case Holiday.FourthOfJuly:
                    query += "holiday^holiday-4th-of-july"
                case Holiday.Halloween:
                    query += "holiday^holiday-halloween"
                case Holiday.Hanukkah:
                    query += "holiday^holiday-hanukkah"
                case Holiday.NewYear:
                    query += "holiday^holiday-new-year"
                case Holiday.Summer:
                    query += "holiday^holiday-summer"
                case Holiday.SuperBowl:
                    query += "holiday^holiday-super-bowl"
                case Holiday.Thanksgiving:
                    query += "holiday^holiday-thanksgiving"
                }
            }
        }
        //  total seconds to cook recipes
        if maxTotalTimeInSeconds! > 0
        {
            query += "&maxTotalTimeInSeconds=" + String(maxTotalTimeInSeconds!)
        }
        //  max results to return per page
        if maxResults! > 0
        {
            query += "&maxResult=" + String(maxResults!) //+ "0&start=0"
        }
		
		//print("Attempting query search: \(query)")
		
		let url = URL(string: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
		
        URLSession.shared.dataTask(with: url!)
		{ (data, response, error) in
            
            //  Check error
            //  Check status code
            
            //  Ensure data is not null
            guard let data = data else {    return  }
            
            //  Try to serialize the JSON data.
            do
            {
				print("Attempting to fetch recipe search data from:", query)
				
                let result = try JSONDecoder().decode(Result.self, from: data)
                
                //print("Total matches:", result.totalMatchCount!)
                completion(result)
            }
            catch let jsonErr
            {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
	
	//	Function that returns a recipe result. Pass the id of the recipe to search
	static func GetRecipe(recipeID: String?, completion: @escaping (Recipe) -> ())
	{
		//  Check check parameter errors
		if recipeID!.isEmpty
		{
			print("Empty recipe id!")
			return
		}
		
		//  Create the base query string that will request from yummly
		let query = "http://api.yummly.com/v1/api/recipe/" + recipeID! + "?_app_id=" + self.yummlyID + "&_app_key=" + self.yummlyKey
		
		let url = URL(string: query)
		
		print("URL REQUEST: "+query)
		
		URLSession.shared.dataTask(with: url!)
		{ (data, response, error) in
			//  Check error
			//  Check status code
			
			//  Ensure data is not null
			guard let data = data else {    return  }
			
			//  Try to serialize the JSON data.
			do
			{
				//print("PRINTING DATA")
				//print (data)
				print("Attempting to fetch recipe data from:", query)
				
				let recipe = try JSONDecoder().decode(Recipe.self, from: data)
				//print("PRINTING RECIPE")
				//print(recipe)
				
				completion(recipe)
			}
			catch let jsonErr
			{
				print("Error serializing json:", jsonErr)
			}
		}.resume()
	}
	
	//	Function that returns an array of all the ingredients that exist on YummlyAPI
	static func GetIngredientsMetadata() -> [Ingredient]
	{
		//	Create path to JSON file
		let JSONpath = Bundle.main.path(forResource: "ingredients", ofType: "json")
		
		//	Create url var from JSON path
		let url = URL(fileURLWithPath: JSONpath!)
		
		//  Try to serialize the JSON data.
		//URLSession.shared.dataTask(with: url)
		//{ (data, response, error) in
			//  Check error
			//  Check status code
			
		//  Ensure data is not null
			//guard let data = data else {    return  }
			
		//  Try to serialize the JSON data.
		do
		{
			
			//print("PRINTING DATA")
			//print (data)
			print("Attempting to fetch ingredients metadata from:", JSONpath)
			
			let data = try Data(contentsOf: url)
			let ingredients = try JSONDecoder().decode([Ingredient].self, from: data)
			//print("PRINTING INGREDIENTS")
			//print(ingredients)
			
			//completion(ingredients)
			return ingredients
		}
		catch let jsonErr
		{
			print("Error serializing json:", jsonErr)
		}
		//}.resume()
		
		return []
	}
	
	//	Given a ingredient string, returns true if it exists in the yummlyAPI database.
	static func IsIngredientValid(ingredientName: String) -> Bool
	{
		if self.IngredientsMetadata.contains(where: {$0.searchValue?.lowercased() == ingredientName.lowercased()})
		{
			return true
		}
		return false
	}
    
    //  Try add recipe to recipe history
    static func AddRecipeToHistory(recipe: Recipe)
    {
        // found
        if RecipeDetailHistory.contains(where: { $0.id == recipe.id })
        {
            print("Recipe \(recipe.name) already in history. Doing nothing.")
            return
        }
        // not found
        else
        {
            RecipeDetailHistory.append(recipe)
            
            print("Recipe \(recipe.name) added to history.")
        }
    }
    
    //  Returns array of recipes recommended
    static func GetRecommendedRecipes() -> [Recipe]
    {
        var recommendations = [Recipe]()
        //  Test
        recommendations.append(contentsOf: RecipeDetailHistory)
        recommendations.append(contentsOf: FavoritesVC.favRecipes)
        return recommendations
    }
}
