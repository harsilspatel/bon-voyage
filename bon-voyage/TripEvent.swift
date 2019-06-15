//
//  TripEvent.swift
//  bon-voyage
//
//  Created by Harsil Patel on 14/6/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import Firebase
import Foundation
import GooglePlaces

class TripEvent: NSObject {
    let title: String
    let start: Date
    let duration: Int
    let color: UIColor
    let databaseId: String?
    
    let placeID: String
    let placeName: String
    let placeLat: Double
    let placeLon: Double
    
    
    init(title: String, start: Date, duration: Int, placeID: String, placeLat: Double, placeLon: Double, placeName: String, databaseId: String?) {
        self.title = title
        self.start = start
        self.duration = duration
        self.color = [UIColor.blue,
                      UIColor.yellow,
                      UIColor.green,
                      UIColor.red].randomElement()!
        self.databaseId = databaseId
        
        self.placeID = placeID
        self.placeLat = placeLat
        self.placeLon = placeLon
        self.placeName = placeName
    }
    
    convenience init(title: String, start: Date, duration: Int, place: GMSPlace, databaseId: String?) {
        
        let placeName = place.name!
        let placeID = place.placeID!
        let placeLat = place.coordinate.latitude
        let placeLon = place.coordinate.longitude
        
        self.init(title: title, start: start, duration: duration, placeID: placeID, placeLat: placeLat, placeLon: placeLon, placeName: placeName, databaseId: nil)
    }
    
    convenience init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let title = data["title"] as? String else {
            return nil
        }
        
        guard let timestamp = (data as AnyObject).value(forKey: "start") as? Timestamp else {
            return nil
        }
        let start = timestamp.dateValue()
        
        guard let duration = data["duration"] as? Int else {
            return nil
        }
        
        guard let placeName = data["placeName"] as? String else {
            return nil
        }
        
        guard let placeID = data["placeID"] as? String else {
            return nil
        }
        
        guard let placeLat = data["placeLat"] as? Double else {
            return nil
        }
        
        guard let placeLon = data["placeLon"] as? Double else {
            return nil
        }
        
        self.init(title: title, start: start, duration: duration, placeID: placeID, placeLat: placeLat, placeLon: placeLon, placeName: placeName, databaseId: document.documentID)
    }
    
    // to get the index
    
    // lesson learnt: if the class is inheriting from NSObject,
    // you have to have isEqual method as opposed to conforming to Equatable
    // as NSObject by default conforms to that.
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? TripEvent {
            return self.databaseId == object.databaseId
        }
        return false
    }
}

extension TripEvent: DatabaseRepresentation {
    
    var representation: [String : Any] {
        let rep: [String: Any] = [
            "title": self.title,
            "start": self.start,
            "duration": self.duration,
            
            "placeID": self.placeID,
            "placeName": self.placeName,
            "placeLat": self.placeLat,
            "placeLon": self.placeLon
        ]
        return rep
    }
}
