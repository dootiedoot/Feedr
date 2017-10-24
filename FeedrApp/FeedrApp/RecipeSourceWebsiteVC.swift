//
//  RecipeSourceWebsiteVC.swift
//  FeedrApp
//
//  Created by chad hoang on 10/24/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit
import WebKit

class RecipeSourceWebsiteVC: UIViewController, WKUIDelegate
{
    var webView: WKWebView!
    var url: String!
    
    override func loadView()
    {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let myURL = URL(string: self.url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
