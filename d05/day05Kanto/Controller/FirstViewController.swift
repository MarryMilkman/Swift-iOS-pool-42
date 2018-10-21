//
//  FirstViewController.swift
//  day05Kanto
//
//  Created by Ivan SELETSKYI on 10/8/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubTitle: String, pinCoordinate: CLLocationCoordinate2D) {
        self.coordinate = pinCoordinate
        self.title = pinTitle
        self.subtitle = pinSubTitle
    }
}

class FirstViewController: UIViewController, MKMapViewDelegate {
    
    var index: Int? = 0
    
    var selectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var index = 0
        while (index < dataArr.count) {
            addPin(index: index)
            index += 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (checkTableChange) {
            relocateMap(index: indexInTable)
        }
        checkTableChange = false
    }

    // Segmented control bar
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl!) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    // Geolocalization
    
    @IBAction func geolocalizedButton(_ sender: Any) {
        if (selectIndex == nil){ return }
        relocateMap(index: selectIndex!)
    }

    @IBOutlet weak var mapView: MKMapView!
   
    // Did select Annotation(pin)
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var i = 0
        while (i < dataArr.count) {
            let titleStr: String = dataArr[i]["name"] as! String
            if ((view.annotation?.title)! == titleStr){
                selectIndex = i
                return
            }
            i += 1
        }
    }
    
    // helpful functions
    
    func addPin(index: Int) {
        let location = CLLocationCoordinate2D(latitude: dataArr[index]["coord1"] as! CLLocationDegrees, longitude: dataArr[index]["coord2"] as! CLLocationDegrees)
        let pin = customPin(pinTitle: dataArr[index]["name"] as! String, pinSubTitle: dataArr[index]["subTitle"] as! String, pinCoordinate: location)
        self.mapView.addAnnotation(pin)
    }
    
    func relocateMap(index: Int) {
        let coord1 = dataArr[index]["coord1"] as! CLLocationDegrees
        let coord2 =  dataArr[index]["coord2"] as! CLLocationDegrees
        let location = CLLocationCoordinate2D(latitude: coord1, longitude: coord2)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpanMake(0.005, 0.005))
        self.mapView.setRegion(region, animated: true)
    }

}

