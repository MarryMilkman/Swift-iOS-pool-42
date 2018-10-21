//
//  ViewController.swift
//  Hello_World
//
//  Created by Ivan SELETSKYI on 10/1/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Button_click(_ sender: Any) {
        print("Hello World");
    }
    
}

