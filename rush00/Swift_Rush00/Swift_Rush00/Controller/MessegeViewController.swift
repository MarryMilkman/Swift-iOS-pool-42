//
//  MessegeViewController.swift
//  Swift_Rush00
//
//  Created by Ivan SELETSKYI on 10/6/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class MessegeViewController: UIViewController {

    var strUrl: String?                 // reload through Segue from "Intra Topic"
    var nameTopic: String?              // reload through Segue from "Intra Topic"
    var getInfo: [Any]? = nil           // add in GET
    var messageArr: [[String: String]] = []
    var messageMain: [String: String] = [:]
    
    @IBOutlet weak var nameTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.nameTopic != nil){
            nameTitle.text = self.nameTopic!
        }
        if ((strUrl) != nil){
            getMessage(urlStr: strUrl!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueFromMassegeToComment") {
            if let cv = segue.destination as? AddCommentViewController {
                cv.urlStr = strUrl
            }
        }
    }

    // Pars JSON
    
    func parsJSON() {
        var i = 0
        while (i < getInfo!.count){
            var strArr = ["author": "", "content": "", "created_at": ""]
            if let arrProp: [String : Any] = (getInfo![i]) as? [String: Any] {
                if let author: [String: Any] = arrProp["author"] as? [String: Any] {
                    if let login: String = author["login"] as? String {
                        strArr["author"] = login
                    }
                }
                strArr["created_at"] = (arrProp["created_at"] as! String)
                strArr["content"] = arrProp["content"] as? String
            }
            self.messageArr.append(strArr)
            i += 1
        }
        print(self.messageMain)
    }
}

// extension -->      UITableViewDataSource, UITableViewDelegate

extension MessegeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArr.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? MessageTableViewCell
        cell?.dateComment.text = (messageArr[indexPath.row])["created_at"]
        cell?.nicknameComment.text = (messageArr[indexPath.row])["author"]
        cell?.massegeComment.text = (messageArr[indexPath.row])["content"]
        return cell!
    }

}

// extension -->     Get

extension MessegeViewController {
    
    func getMessage(urlStr: String) {
        print("GET from MassegeVC")
        guard let url = URL(string: urlStr) else {
            print("Error: something wrong with url \(urlStr)")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + (tokenObj!["access_token"] as! String), forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("Response:")
                print(response)
            } else {
                print (error!)
                return
            }
            
            if let data = data {
                let sjArr = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                self.getInfo = sjArr as? [Any]
                if (self.getInfo == nil){
                    print("Error")
                    return
                }
                self.parsJSON()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
}
