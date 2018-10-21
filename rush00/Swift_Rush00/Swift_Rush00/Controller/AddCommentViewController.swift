//
//  AddCommentViewController.swift
//  Swift_Rush00
//
//  Created by Ivan SELETSKYI on 10/7/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {

    var urlStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    @IBAction func addComment(_ sender: Any) {
//        sendMessage(urlStr: self.urlStr!)
    }

}

extension AddCommentViewController {
    
    func sendMessage(urlStr: String) {
        let parameters: [String: [String: String]] = [
            "message": [
            "author_id": "33651",
            "content": "Hello world",
            ]
        ]
        
        guard let url = URL(string: urlStr) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer " + (tokenObj!["access_token"] as! String), forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.api+json", forHTTPHeaderField: "ContentType")
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
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
                let newObj = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(newObj)
            }
            requestStatus = 0
        }
        task.resume()
    }
}
