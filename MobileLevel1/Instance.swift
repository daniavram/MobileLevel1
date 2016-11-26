//
//  Instance.swift
//  MobileLevel1
//
//  Created by Daniel Avram on 24/11/2016.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import Foundation
import MapKit

class Instance {
    
    var eventsArray: [Event]!
    var map: MKMapView!
    
    let belgradeLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(44.8071), longitude: CLLocationDegrees(20.4768))
    let codebehindLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(44.8210), longitude: CLLocationDegrees(20.4194))
    
    var photosForEvent: Int!
    private var _eventPhotosViewController: EventImagesCollectionViewController!
    
    static let instance = Instance()
    
    init() {
        eventsArray = [Event]()
        map = MKMapView()
        photosForEvent = 0
        _eventPhotosViewController = EventImagesCollectionViewController()
    }
    
    func printEventsArray() {
        for iterator in eventsArray {
            iterator.printEvent()
        }
    }
    
    var eventPhotosViewController: EventImagesCollectionViewController {
        get {
            return _eventPhotosViewController
        } set {
            _eventPhotosViewController = newValue
        }
    }
}
