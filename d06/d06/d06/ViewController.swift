//
//  ViewController.swift
//  d06
//
//  Created by Ivan SELETSKYI on 10/9/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var i = 0;
    
    @IBOutlet var tapingView: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGasturesAction))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tapingView.animation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tapingView.animation = false
    }
    
    @IBAction func tapGasturesAction(_ sender: UITapGestureRecognizer) {
        if (arc4random() % 2 == 0) {
            tapingView.createSquare(x: sender.location(in: tapingView).x, y: sender.location(in: tapingView).y)
        } else {
            tapingView.createCircle(x: sender.location(in: tapingView).x, y: sender.location(in: tapingView).y)
        }
        i += 1
        print("TAP")
    }
    
}

