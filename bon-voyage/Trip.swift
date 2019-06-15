//
//  Trip.swift
//  bon-voyage
//
//  Created by Harsil Patel on 21/4/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit
import Firebase

class Trip: NSObject {
    let title: String
    let thumbnail: UIImage
    let databaseId: String?
    
    let tripLat: Double?
    let tripLon: Double?
    let tripID: String
    
    init(title: String, thumbnail: UIImage, tripID: String, lat: Double, lon: Double, databaseId: String?) {
        self.title = title
        self.thumbnail = thumbnail
        self.databaseId = databaseId
        
        self.tripID = tripID
        self.tripLat = lat
        self.tripLon = lon
    }
    
    convenience init?(document: QueryDocumentSnapshot, thumbnail: UIImage) {
        let data = document.data()
        
        guard let title = data["title"] as? String else {
            return nil
        }
        
        guard let tripID = data["tripID"] as? String else {
            return nil
        }
        
        guard let tripLat = data["tripLat"] as? Double else {
            return nil
        }
        
        guard let tripLon = data["tripLon"] as? Double else {
            return nil
        }
        
        self.init(title: title, thumbnail: thumbnail, tripID: tripID, lat: tripLat, lon: tripLon, databaseId: document.documentID)
    }
}

extension Trip: DatabaseRepresentation {
    
    var representation: [String : Any] {
        let rep: [String: Any] = [
            "title": self.title,
            
            "tripID": self.tripID,
            "tripLat": self.tripLat,
            "tripLon": self.tripLon,
        ]
        return rep
    }
}

