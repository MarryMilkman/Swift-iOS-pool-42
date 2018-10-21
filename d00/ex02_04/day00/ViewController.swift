//
//  ViewController.swift
//  day00
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

    @IBOutlet weak var Name: UILabel!

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    var castyl = 0;
    var exec = 0;
    var op: String? = nil;
    var res: Double? = 0;
    var inter_res: Int? = nil;
    
    func param_add(val: String) {
        let a: Int? = Int(Name.text!);
        if (a == nil && Name.text! != "error"){
            inter_res = nil;
            Name.text = "error";
            return ;
        }
        if (exec == 1){
            inter_res = Int(Name.text!);
        }
        Name.text! = Name.text! == "0" || Name.text! == "error" || exec != 0 ? val : Name.text! + val;
        castyl = 0;
        exec == 2 ? op = nil : nil;
        exec = 0;
    }

    func error(){
        inter_res = nil;
        res = 0;
        exec = 0;
        op = nil;
        Name.text = "error";
    }
    
    func calc() {
        if (inter_res != nil && op != nil){
            let num1: Double? = Double(inter_res!);
            let num2: Double? = Double(Name.text!);
            if (num1 == nil || num2 == nil){
                error();
                return ;
            }
            let x: Double!;
            let y: Double!;
            if (castyl == 0){
                x = num1;
                y = num2;
            }
            else{
                x = num2;
                y = num1;
            }
            if (op == "+"){
                res = x + y;
            }
            if (op == "-"){
                res = x - y;
            }
            if (op == "*"){
                res = x * y;
            }
            if (op == "/"){
                if (y == 0){
                    error();
                    return ;
                }
                res = x / y;
            }
            // check for res
            if (res == nil){
                error();
                return ;
            }
            if (res! >= 2147483648 || res! < -2147483648){
                error();
                return ;
            }
            castyl == 0 ? inter_res = Int(num2!) : nil;
            castyl = 1;
            Name.text! = String(describing: Int(res!));
        }
    }
    
   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    @IBAction func Button_1(_ sender: Any) {
        param_add(val: "1")
        print("Button 1")
    }

    @IBAction func Button_2(_ sender: Any) {
        param_add(val: "2")
        print("Button 2")
    }
    
    @IBAction func Button_3(_ sender: Any) {
        param_add(val: "3")
        print("Button 3")
    }
    
    @IBAction func Button_4(_ sender: Any) {
        param_add(val: "4")
        print("Button 4")
    }
    
    @IBAction func Button_5(_ sender: Any) {
        param_add(val: "5")
        print("Button 5")
    }
    
    @IBAction func Button_6(_ sender: Any) {
        param_add(val: "6")
        print("Button 6")
    }
    
    @IBAction func Button_7(_ sender: Any) {
        param_add(val: "7")
        print("Button 7")
    }
    
    @IBAction func Button_8(_ sender: Any) {
        param_add(val: "8")
        print("Button 8")
    }
    
    @IBAction func Button_9(_ sender: Any) {
        param_add(val: "9")
        print("Button 9")
    }
    
    @IBAction func Button_0(_ sender: Any) {
        param_add(val: "0");
        print("Button 0");
    }
    
    @IBAction func Button_AC(_ sender: Any) {
        inter_res = nil;
        Name.text! = "0";
        res = 0;
        exec = 0;
        op = nil;
        print("Button AC")
    }
    
    @IBAction func Button_NEG(_ sender: Any) {
        if (Int(Name.text!)! > 0){
            Name.text! = "-" + Name.text!
        }
        else{
            let num = Int(Name.text!);
            Name.text! = String(describing: (-num!));
        }
        print("Button NEG")
    }
    
    @IBAction func Button_add(_ sender: Any) {
        if (exec != 2 && op == "+"){
            calc();
        }
        op = "+";
        exec = 1;
        print("Button +");
    }
    
    @IBAction func Button_mul(_ sender: Any) {
        if (exec != 2 && op == "*"){
            calc();
        }
        op = "*";
        exec = 1;
        print("Button *");
    }
    
    @IBAction func Button_sub(_ sender: Any) {
        if (exec != 2 && op == "-"){
            calc();
        }
        op = "-";
        exec = 1;
        print("Button -");
    }
    
    @IBAction func Button_div(_ sender: Any) {
        if (exec != 2 && op == "/"){
            calc();
        }
        op = "/";
        exec = 1;
        print("Button /");
    }
    
    @IBAction func Button_equal(_ sender: Any) {
        calc();
        exec = 2;
        res = 0;
        print("Button =");
    }
}
