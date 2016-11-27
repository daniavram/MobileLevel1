//
//  EventDetails.swift
//  MobileLevel1
//
//  Created by Daniel Avram on 27/11/2016.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import Foundation
import UIKit

class EventDetails {
    
    private var _image: UIImage!
    private var _imageUrl: String!
    private var _description: String!
    
    init(image: UIImage, desc: String) {
        self._image = image
        self._description = desc
    }
    
    init(imageUrl: String, desc: String) {
        self._imageUrl = imageUrl
        self._description = desc
    }
    
    var image: UIImage {
        get {
            return _image
        }
    }
    
    var description: String {
        get {
            return _description
        }
    }
    
    var imageUrl: String {
        get {
            return _imageUrl
        }
    }
}
