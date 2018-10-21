//
//  ViewController.swift
//  d07
//
//  Created by Ivan SELETSKYI on 10/11/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit
import RecastAI

class ViewController: UIViewController {

    var bot: RecastAIClient?
    
    let token = "6b011635dfe977b9cbcc6494dca0bce3"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bot = RecastAIClient(token : token, language: "en")
    }


    func makeRequest(_ strRequest: String)
    {
        self.bot?.textRequest(strRequest, successHandler: successHandle, failureHandle: failureHandle)
    }

    func successHandle(resp: Response) {
        print("Success")
        if let result = resp.raw["intents"] {
            print(result)
            if let text = result["description"] {
                lableOutput.text! = text as! String
            }
            else {
                lableOutput.text! = "Sorry, I don't know about what you talkin me"
            }
        }
        
    }
    
    @objc func failureHandle(err: Error) {
        print("Error")
        print(err)
    }
    
    @IBOutlet weak var Request: UIButton!
    
    @IBOutlet weak var lableOutput: UILabel!
    
    @IBOutlet weak var textField: UITextField!

    
    @IBAction func requestButton(_ sender: UIButton) {
        if (self.textField.text! == ""){
            lableOutput.text! = "Request is empty"
            return
        }
        let request = self.textField.text!
        self.textField.text! = ""
        makeRequest(request)
    }
    
}

