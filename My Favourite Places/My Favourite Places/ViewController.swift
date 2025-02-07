//
//  ViewController.swift
//  My Favourite Places
//
//  Created by Ben Hawley on 01/11/2018.
//  Copyright © 2018 Ben Hawley. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the long press to add a new location
        let uilpgr = UILongPressGestureRecognizer(target: self, action:
        #selector(ViewController.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
        // Do any additional setup after loading the view, typically from a nib.
        guard currentPlace != -1 else {
            // Lets pretend we are getting this lat and long data from the GPS
            let latitude = Double("53.406566")
            let longitude = Double("-2.966531")
            let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
            let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.map.setRegion(region, animated: true)
            return
        }

        guard places.count > currentPlace else { return }
        guard let name = places[currentPlace]["name"] else { return }
        guard let lat = places[currentPlace]["lat"] else { return }
        guard let lon = places[currentPlace]["lon"] else { return }
        guard let latitude = Double(lat) else { return }
        guard let longitude = Double(lon) else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        self.map.addAnnotation(annotation)
        
        print(currentPlace)
    }
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            print("===\nLong Press\n===")
            let touchPoint = gestureRecognizer.location(in: self.map)
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            print(newCoordinate)
            
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            var title = ""
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let placemark = placemarks?[0] {
                        if placemark.subThoroughfare != nil {
                            title += placemark.subThoroughfare! + " "
                        }
                        if placemark.thoroughfare != nil {
                            title += placemark.thoroughfare!
                        }
                    }
                }
                if title == "" {
                    title = "Added \(NSDate())"
                }
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                self.map.addAnnotation(annotation)
                places.append(["name":title, "lat": String(newCoordinate.latitude), "lon":
                    String(newCoordinate.longitude)])
                
                let defaults = UserDefaults.standard
                defaults.set(places, forKey: "places")
//                let result = defaults.array(forKey: "places")

            } )
        }
    }

    @IBOutlet weak var map: MKMapView!
    
}

