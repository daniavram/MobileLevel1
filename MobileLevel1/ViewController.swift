//
//  ViewController.swift
//  MobileLevel1
//
//  Created by Daniel Avram on 24/11/2016.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import UIKit
import MapKit

private let reuseIdentifier = "EventCell"
private let sectionInsets = UIEdgeInsets(top: 4.0, left: 2.0, bottom: 4.0, right: 2.0)

class ViewController: UIViewController, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var eventPhotosCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.delegate = self
        Instance.instance.map = map
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
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

        if let annotation = view.annotation as? Event {
            getEventDetails(eventId: annotation.id, forView: eventPhotosCollectionView)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
            self.collectionView.isHidden = false
        })
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        Instance.instance.eventDetails = [EventDetails]()
        
        collectionView.isHidden = true
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotationParam: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotationParam as? Event {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }

            view.animatesDrop = true
            view.pinTintColor = annotation.getColor()
            return view
        } else {
            return nil
        }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Instance.instance.eventDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? EventCell {
            cell.imageView.image = UIImage(named: "codebehind square negative")
            if (Instance.instance.eventDetails.count > 0) {
                cell.imageView.af_setImage(withURL: URL(string: Instance.instance.eventDetails[indexPath.row].imageUrl)! )
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Instance.instance.eventDetailsIndex = indexPath.row
    }
    
}

