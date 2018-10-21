//
//  scrolImageViewController.swift
//  Pictures_pro
//
//  Created by Ivan SELETSKYI on 10/5/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit

class scrolImageViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView?
    var image: UIImage?
    var strUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        add_image(strUrl)
        print(strUrl)
    }

    func add_image(_ url_str: String){
        let url: URL = URL(string: url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async(execute: {
                if (data != nil){
                    let image = UIImage(data: data!)
                    if (image != nil)
                    {
                        self.image = UIImage(data: data!)
                        self.imageView = UIImageView(image: self.image)
                        self.scrollView.addSubview(self.imageView!)
                        self.scrollView.contentSize = (self.imageView?.frame.size)!
                        self.scrollView.maximumZoomScale = 100
                        self.scrollView.minimumZoomScale = 0.3
                        self.scrollView.zoomScale = 0.3
                    }
                }
            })
        })
        task.resume()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
