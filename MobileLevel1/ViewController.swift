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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var eventPhotosCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.delegate = self
        Instance.instance.map = map
    
        let eventsCollectionViewController = EventImagesCollectionViewController()
//        collectionView.delegate = eventsCollectionViewController
        
//        eventsCollectionViewController.collectionView = collectionView
//        eventsCollectionViewController.collectionView?.delegate = eventsCollectionViewController
//        eventsCollectionViewController.collectionView?.dataSource = eventsCollectionViewController
//        Instance.instance.eventPhotosViewController = eventsCollectionViewController
        
        getEvents();
        
        setMapRegion(location: Instance.instance.belgradeLocation, zoomLevel: 0.2)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMapRegion(location: CLLocationCoordinate2D, zoomLevel: Double) {
        let locationDelta = CLLocationDegrees(zoomLevel)
        let coordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: locationDelta, longitudeDelta: locationDelta))
        Instance.instance.map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        setMapRegion(location: (view.annotation?.coordinate)!, zoomLevel: 0.03)
//        Instance.instance.eventPhotosViewController.collectionView?.isHidden = false
        collectionView.isHidden = false
        if let annotation = view.annotation as? Event {
            getEventDetails(eventId: annotation.id, forView: eventPhotosCollectionView)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        Instance.instance.eventPhotosViewController.collectionView?.isHidden = true
        collectionView.isHidden = true
        Instance.instance.photosForEvent = 0
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotationParam: MKAnnotation) -> MKAnnotationView? {
        // this gets called for each annotation
        // the same dequeueing mechanism as for tableviews or collectionviews is applied; i think
        if let annotation = annotationParam as? Event {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                // this gets executed in case a view is dequeued aka reused
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // this gets executed for a new view; brand new; no dequeueing
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            // after either dequeueing or creating a new view, the view (aka pin) gets animated and gets its color changed
            view.animatesDrop = true
            view.pinTintColor = annotation.getColor()
            return view
        } else {
            return nil
        }
        
    }


}

