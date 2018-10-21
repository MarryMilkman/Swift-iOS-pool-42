//
//  ViewController.swift
//  Pictures_pro
//
//  Created by Ivan SELETSKYI on 10/5/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func do_alert(nameImage: String) {
        let alert = UIAlertController(title: "Sorry", message: "Cannot assert to " + nameImage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "=(", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func get_image(_ url_str: String, _ imageView: UIImageView, _ loadAct: UIActivityIndicatorView, index: Int){
        let url: URL = URL(string: url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async(execute: {
                if (data != nil){
                    let image = UIImage(data: data!)
                    if (image != nil){
                        imageView.image = image
                    }
                }
                else{
                    arrUrl[index] = ""
                    self.do_alert(nameImage: String(describing: url))
                    imageView.backgroundColor = UIColor.gray
                }
                loadAct.isHidden = true
            })
        })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToViewController") {
            if let cv = segue.destination as? scrolImageViewController {
                cv.strUrl = (sender as? String)!
            }
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? CollectionViewCell{
            get_image(arrUrl[indexPath.row], itemCell.imageView, itemCell.loadAct, index: indexPath.row)
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (arrUrl[indexPath.row] == ""){
            return
        }
        self.performSegue(withIdentifier: "segueToViewController", sender: arrUrl[indexPath.row])
    }
}
