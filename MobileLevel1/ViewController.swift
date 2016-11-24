//
//  ViewController.swift
//  MobileLevel1
//
//  Created by Daniel Avram on 24/11/2016.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
//    let codebehindLocation = CLLocation(latitude: 44.8210, longitude: 20.4194)
    let codebehindLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(floatLiteral: 44.8210), longitude: CLLocationDegrees(floatLiteral: 20.4194))
    let belgradeLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(44.8071), longitude: CLLocationDegrees(20.4768))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.delegate = self
        getEvents();
        Instance.instance.map = map
        let locationDelta = CLLocationDegrees(0.2)
        let coordinateRegion = MKCoordinateRegion(center: belgradeLocation, span: MKCoordinateSpan(latitudeDelta: locationDelta, longitudeDelta: locationDelta))
        map.setRegion(coordinateRegion, animated: true)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Event {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButtonType
//                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            view.animatesDrop = true
            view.pinTintColor = annotation.getColor()
            return view
        } else {
            return nil
        }
        
    }


}

