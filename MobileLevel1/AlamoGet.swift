//
//  AlamoGet.swift
//  MobileLevel1
//
//  Created by Daniel Avram on 24/11/2016.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit
import AlamofireImage

func getEvents() {
    Alamofire.request("http://private-60f2d-eventer2.apiary-mock.com/api/v1/events").responseJSON { response in
        if let resp = response.result.value {
            let respJson = JSON(resp)
            for (_, json) in respJson {

                let tempCoordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(json["location"]["lat"].doubleValue), longitude: CLLocationDegrees(json["location"]["lng"].doubleValue))
                
                var tagsArray = [String]()
                let tagsArrayGet = json["tags"].arrayValue
                for iterator in tagsArrayGet {
                    let temp = iterator.stringValue
                    tagsArray.append(temp)
                }
                
                let tempEvent = Event(name: json["name"].stringValue, coordinates: tempCoordinates, isTrending: json["is_trending"].boolValue, startsAt: json["starting_at"].stringValue, endsAt: json["ending_at"].stringValue, tags: tagsArray, id: json["id"].intValue)
                Instance.instance.eventsArray.append(tempEvent)
            }
            Instance.instance.map.addAnnotations(Instance.instance.eventsArray)
        }
        
    }
}

func getEventDetails(eventId: Int, forView: UICollectionView) {
    Alamofire.request("http://private-60f2d-eventer2.apiary-mock.com/api/v1/events/\(eventId)").responseJSON { response in
        if let resp = response.result.value {
            let respJson = JSON(resp)
            for (_, json) in respJson {
//                let tempEventDetails = EventDetails(image: getPhoto(urlString: json["image"].stringValue, forView: forView)!, desc: json["description"].stringValue)
                let tempEventDetails = EventDetails(imageUrl: json["image"].stringValue, desc: json["description"].stringValue)
                Instance.instance.eventDetails.append(tempEventDetails)
            }
            forView.reloadData()
        }
    }
}

func getPhoto(urlString: String, forView: UICollectionView) -> UIImage? {
    var imgReturnValue = UIImage(named: "codebehind square negative")
    
    Alamofire.request(urlString).responseImage { response in
        if let respImg = response.result.value {
            imgReturnValue = respImg
            forView.reloadData()
        }        
    }
    
    return imgReturnValue
}
