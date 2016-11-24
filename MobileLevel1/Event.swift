//
//  Event.swift
//  MobileLevel1
//
//  Created by Daniel Avram on 24/11/2016.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import Foundation
import MapKit

class Event: NSObject, MKAnnotation {
    
    private var _name: String!
    private var _coordinates: CLLocationCoordinate2D!
    private var _isTrending: Bool!
    private var _startsAt: String!
    private var _endsAt: String!
    private var _tags: [String]!
    private var _id: Int!
    
    init (name: String, coordinates: CLLocationCoordinate2D, isTrending: Bool, startsAt: String, endsAt: String, tags: [String], id: Int) {
        self._name = name
        self._coordinates = coordinates
        self._isTrending = isTrending
        self._startsAt = startsAt
        self._endsAt = endsAt
        self._tags = tags
        self._id = id
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    // mandatory in order to conform to MKAnnotation protocol
    var coordinate: CLLocationCoordinate2D {
        get {
            return _coordinates
        }
    }
    
    var isTrending: Bool {
        get {
            return _isTrending
        }
    }
    
    var startsAt: String {
        get {
            return _startsAt
        }
    }
    
    var endsAt: String {
        get {
            return _endsAt
        }
    }
    
    var tags: [String] {
        get {
            return _tags
        }
    }
    
    var id: Int {
        get {
            return _id
        }
    }
    
    // optional in order to conform to the MKAnnotation protocol
    var title: String? {
        get {
            return _name
        }
    }
    var subtitle: String? {
        get {
            return "Tags: \(tagsToString())"
        }
    }
    
    func tagsToString() -> String {
        var tagsString = ""
        for iterator in self.tags {
            if (tagsString != "") {
                tagsString = "\(tagsString), \(iterator)"
            } else {
                tagsString = "\(iterator)"
            }
        }
        return tagsString
    }
    
    func printEvent() {        
        print("\(self.name) | \(self.coordinate.latitude) | \(self.coordinate.longitude) | \(self.isTrending) | \(self.startsAt) | \(self.endsAt) || \(tagsToString()) || \(self.id) ***")
    }
    
    func getColor() -> UIColor {
        if (isTrending) {
            // custom yellow
            return UIColor(red: 248/255.0, green: 231/255.0, blue: 27/255.0, alpha: 1.0)
        } else {
            // custom green
            return UIColor(red: 126/255.0, green: 211/255.0, blue: 32/255.0, alpha: 1.0)
        }
    }
    
}
