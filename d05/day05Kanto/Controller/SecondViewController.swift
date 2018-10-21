//
//  SecondViewController.swift
//  day05Kanto
//
//  Created by Ivan SELETSKYI on 10/8/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var tableVeiw: UITableView!
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "SegueFromTableToMap") {
//            let cv = segue.destination as! FirstViewController
//            cv.index = sender as? Int
//        }
//    }

}

extension SecondViewController:  UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPlace", for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexInTable = indexPath.row
        checkTableChange = true
        performSegue(withIdentifier: "SegueFromTableToMap", sender: nil)
    }
}

