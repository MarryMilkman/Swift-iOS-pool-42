//
//  ViewController.swift
//  day02
//
//  Created by Ivan SELETSKYI on 10/3/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrNameAndDesc: [(String, String)] = [
        ("Valerka", "Spid"),
        ("Snijana", "Spid"),
        ("Oleja", "Spidozik")
    ]
    
    var arrDate: [String] = ["10/5/18", "20/10/28", "11/01/01"]
    
    var receivedData: (String, String) = ("","")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var i = 0
    
    override func viewWillAppear(_ animated: Bool) {
        i = 0
        tableView.reloadData();
    }
    
    @IBAction func didLiaveFromAddPersonVC(_ sender: UIStoryboardSegue) {
        guard let addPersonVC = sender.source as? addPersonViewController else {return}
        
        let n1 = addPersonVC.fildName.text
        let n2 = addPersonVC.fildDescription.text
        let strDate = getDate(addPersonVC.fildDate)
        
        print("Name: ", addPersonVC.fildName.text ?? "nil")
        print("Date: ", strDate)
        print("Discription: ", addPersonVC.fildDescription.text ?? "nil")
        
        if (n1 == nil || n1 == ""){
            return
        }
        
        if (n2 == nil){
            receivedData.1 = ""
        }
        else {
            receivedData.1 = addPersonVC.fildDescription.text!
        }
        receivedData.0 = addPersonVC.fildName.text!
      
        self.arrNameAndDesc.append(receivedData)
        self.arrDate.append(strDate)
    }
    
    func getDate(_ getDate: UIDatePicker!) -> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let strDate: String = dateFormatter.string(from: getDate.date)
        return strDate
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // UITableViewDataSource
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrNameAndDesc.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithFilm", for: indexPath)
        if ((indexPath.section) % 2 == 0) {
            cell.backgroundColor = UIColor.gray
        }
        if ((indexPath.row) % 2 != 0) {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = arrNameAndDesc[indexPath.section].1
        }
        else{
            cell.textLabel?.text = arrNameAndDesc[indexPath.section].0
            cell.detailTextLabel?.text = arrDate[indexPath.section]
        }
        i += 1
        if (i == 4){
            i = 0
        }
        return cell
    }
}

