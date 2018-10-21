//
//  StartViewController.swift
//  Swift_Rush00
//
//  Created by Ivan SELETSKYI on 10/7/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        performSegue(withIdentifier: "SerueToLogin", sender: nil)
    }

}
