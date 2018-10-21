//
//  ViewController.swift
//  GPS
//
//  Created by Ivan SELETSKYI on 10/13/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import MapKit

enum Location {
    case startLocation
    case destinationLocation
}

class ViewController: UIViewController, GMSMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var firstLocation: UITextField!
    @IBOutlet weak var secondLocation: UITextField!
    
    var googleAPIKey = "AIzaSyCngQ_pachaZaFa5N0Fdn8yyOT9d_E_JMI"
    
    var polyline: GMSPolyline?
    
    var saveTextField: UITextField!
    
    var locationStart: CLLocationCoordinate2D?
    var locationEnd: CLLocationCoordinate2D?
    
    var currentLocation: CLLocation!
    var rememberLocation: CLLocation!
    
    
    var markerArr: [GMSMarker] = [
        GMSMarker(),
        GMSMarker()
    ]
    
    var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 50
        locationManager.startMonitoringSignificantLocationChanges()
        
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        googleMaps.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: 50.4688257, longitude: 30.4599648, zoom: 15.0)
        googleMaps.camera = camera
        if let theLocation = locationManager.location {
            let theCamera = GMSCameraPosition.camera(withTarget: theLocation.coordinate, zoom: 15.0)
            if googleMaps.isHidden {
                googleMaps.isHidden = false
                googleMaps.camera = theCamera
            } else {
                googleMaps.animate(to: theCamera)
            }
        }
    }

    // MARK: function for create a marker pin on map
    
    func createMarker(titleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, indexMarker: Int) {
        self.polyline?.map = nil
        let marker = markerArr[indexMarker]
        marker.map = googleMaps
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
    }

    //MARK: - GMSMapViewDelegate

    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
       
        firstLocation.text = ""
        secondLocation.text = ""
        locationStart = nil
        locationEnd = nil
        
        createMarker(titleMarker: "Your point", latitude: coordinate.latitude, longitude: coordinate.longitude, indexMarker: 1)
        rememberLocation = currentLocation
        let theCamera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 16.0)
        googleMaps.animate(to: theCamera)
        let theAlertController = UIAlertController(title: "Route to this point?", message: "Do you want to start trip to this point?", preferredStyle: .alert)
        let theFirstAction = UIAlertAction(title: "No", style: .cancel, handler: { [weak self] (theAlertAction) in
            guard let theMarker = self?.markerArr[1] else { return }
            theMarker.map = nil
            guard let theCoordinate = self?.rememberLocation.coordinate else { return }
            let theGoBackCamera = GMSCameraPosition.camera(withTarget: theCoordinate, zoom: 15.0)
            self?.googleMaps.animate(to: theGoBackCamera)
        })
        let theSecondAction = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (theAlertAction) in
            guard let theStartPoint = self?.markerArr[0] else { return }
            guard let theCoordinate = self?.rememberLocation.coordinate else { return }
            let theStartCoordinate = theCoordinate
            theStartPoint.map = nil
            self?.createMarker(titleMarker: "Your place", latitude: theCoordinate.latitude, longitude: theCoordinate.longitude, indexMarker: 0)
            let theBounds = GMSCoordinateBounds(coordinate: theStartCoordinate, coordinate: coordinate)
            let theCameraUpdate = GMSCameraUpdate.fit(theBounds, withPadding: 100.0)
            self?.googleMaps.animate(with: theCameraUpdate)
            self?.drawPath(coordStartLocation: theStartCoordinate, coordEndLocation: coordinate)
        })
        theAlertController.addAction(theFirstAction)
        theAlertController.addAction(theSecondAction)
        present(theAlertController, animated: true, completion: nil)
    }
    
    //MARK: - serch button(demo)
    
    @IBAction func serchButton(_ sender: UIButton) {
        drawPath(coordStartLocation: locationStart, coordEndLocation: locationEnd)
    }
    
    //MARK: - text fild Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveTextField = textField
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    //MARK: - function for create direction path
    
    func drawPath(coordStartLocation: CLLocationCoordinate2D?, coordEndLocation: CLLocationCoordinate2D?)
    {
        self.polyline?.map = nil
        if (coordEndLocation == nil || coordStartLocation == nil) {
            return
        }
        let origin = "\((coordStartLocation?.latitude)!),\((coordStartLocation?.longitude)!)"
        let destination = "\((coordEndLocation?.latitude)!),\((coordEndLocation?.longitude)!)"
        
        print(origin)
        print(destination)
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(googleAPIKey)"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = try? JSON(data: response.data!)
            print(json)
            let routes = json!["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                self.polyline = GMSPolyline.init(path: path)
                self.polyline?.strokeWidth = 4
                self.polyline?.strokeColor = UIColor.red
                self.polyline?.map = self.googleMaps
            }
            
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            googleMaps.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            googleMaps.isMyLocationEnabled = true
            googleMaps.settings.myLocationButton = true
            googleMaps.settings.compassButton = true
            googleMaps.settings.zoomGestures = true
            print("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        currentLocation = location
        print("Location: \(location)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print(place)
        let thePlaceCamera = GMSCameraPosition(target: place.coordinate, zoom: 16.8, bearing: 1.0, viewingAngle: 0.0)
        saveTextField.text = place.name
        if saveTextField.tag == 0 {
            locationStart = place.coordinate
        } else {
            locationEnd = place.coordinate
        }
        self.dismiss(animated: true, completion: { [weak self] in
            self?.googleMaps.animate(to: thePlaceCamera)
            guard let theTextFieldTag = self?.saveTextField.tag else { return }
            self?.createMarker(titleMarker: place.name, latitude: place.coordinate.latitude, longitude: place.coordinate.longitude, indexMarker: theTextFieldTag)
        })
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension ViewController {
    
}








