//
//  WebViewController.swift
//  Swift_Rush00
//
//  Created by Ivan SELETSKYI on 10/7/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: REDIRECT_URL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }


    
    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    func getUserToken(code: String) {
        
        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/vnd.api+json", forHTTPHeaderField: "ContentType")
        request.httpBody = "grant_type=authorization_code&client_id=\(MY_AWESOME_UID)&client_secret=\(MY_AWESOME_SECRET)&code=\(code)&redirect_uri=\(REDIRECT_URL)".data(using: .utf8)
        requestStatus = 1
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                requestStatus = 0
                return
            }
            if let response = response {
                print("Response:")
                print(response)
            }
            
            if let data = data {
                print("Data:")
                print(data)
                tokenObj = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(tokenObj!)
            }
            requestStatus = 0
        }
        task.resume()
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(webView.url!)
        if webView.url!.absoluteString.hasPrefix("app") {
            let str = webView.url!.absoluteString
            let splitArr = str.split(separator: "=", maxSplits: 3, omittingEmptySubsequences: true)
            if (splitArr.count != 2) {
                self.performSegue(withIdentifier: "SegueFromLoginIntraToStart", sender: nil)
                return
            }
            let code = splitArr[1]
            print(code)
            getUserToken(code: String(code))
            self.performSegue(withIdentifier: "fromWebCVToIntraTopicCVSegue", sender:self)
        }
    }
}
