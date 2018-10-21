//
//  ViewController.swift
//  Swift_Rush00
//
//  Created by Ivan SELETSKYI on 10/6/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var topicInfo: [Any]? = nil
    var dataTopicArr: [[String: String]] = []

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            while (requestStatus == 1){
            }
            self.getTopics(urlStr: "https://api.intra.42.fr/v2/topics.json")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func logOutButton(_ sender: Any) {
        do_alert()
    }
    
    func segueLogOut() {
        DispatchQueue.main.async {
            while (requestStatus == 1){
                
            }
            tokenObj = nil
            requestStatus = 0
            self.performSegue(withIdentifier: "SegueLogOut", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueFromTopicsToMessege") {
            if let cv = segue.destination as? MessegeViewController {
                cv.strUrl = dataTopicArr[sender as! Int]["messages_url"]
                cv.nameTopic = dataTopicArr[sender as! Int]["title"]
            }
        }
    }
    
    // Pars JSON
    
    func parsJSON() {
        var i = 0
        while (i < topicInfo!.count){
            var strArr = ["author": "", "title": "", "created_at": "", "messages_url": ""]
            if let arrProp: [String : Any] = (topicInfo![i]) as? [String: Any] {
                if let author: [String: Any] = arrProp["author"] as? [String: Any] {
                    if let login: String = author["login"] as? String {
                        strArr["author"] = login
                    }
                }
                strArr["created_at"] = (arrProp["created_at"] as! String)
                strArr["title"] = arrProp["name"] as? String
                strArr["messages_url"] = arrProp["messages_url"] as? String
            }
            dataTopicArr.append(strArr)
            i += 1
        }
    }
    
    // alert
    
    func do_alert() {
        let alert = UIAlertController(title: "log out", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.segueLogOut()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

// extension -->      UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTopicArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? FirstTableViewCell
        cell?.labelDate.text = (dataTopicArr[indexPath.row])["created_at"]
        cell?.labelName.text = (dataTopicArr[indexPath.row])["author"]
        cell?.textArea.text = (dataTopicArr[indexPath.row])["title"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueFromTopicsToMessege", sender: indexPath.row)
    }
}

// extension -->      GET request

extension ViewController {
    
    func getTopics(urlStr: String) {
        print("GET")
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
                let jsArr = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                self.topicInfo = jsArr as? [Any]
                if (self.topicInfo == nil){
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
    
    func getUser() {
        print("GET")
        guard let url = URL(string: "https://api.intra.42.fr/v2/me") else {
            print("Error: something wrong with url https://api.intra.42.fr/v2/me")
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
                let jsArr = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                userInfo = jsArr as? [Any]
                if (self.topicInfo == nil){
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
