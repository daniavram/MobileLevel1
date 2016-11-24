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
    
    static let instance = Instance()
    
    init() {
        eventsArray = [Event]()
        map = MKMapView()
    }
    
    func printEventsArray() {
        for iterator in eventsArray {
            iterator.printEvent()
        }
    }
}
