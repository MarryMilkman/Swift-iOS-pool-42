//
//  addPersonViewController.swift
//  day02
//
//  Created by Ivan SELETSKYI on 10/4/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class addPersonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var fildName: UITextField!
    
    @IBOutlet weak var fildDate: UIDatePicker!
    
    @IBOutlet weak var fildDescription: UITextView!
    
}
