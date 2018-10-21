//
//  ViewController.swift
//  Supersize_me
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

    @IBOutlet weak var Lable: UILabel!
    
    var i = 0;
    
    
    @IBAction func Button(_ sender: Any) {
        if (i == 0){
            Lable.text! = "O.o";
            i = 1;
            return ;
        }
        Lable.text! = "o.O";
        i = 0;
    }
}

