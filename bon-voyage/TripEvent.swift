//
//  TripEvent.swift
//  bon-voyage
//
//  Created by Harsil Patel on 14/6/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import Firebase
import Foundation

class TripEvent: NSObject {
    let title: String
    let start: Date
    let duration: Int
    let color: UIColor
    
    
    init(title: String, start: Date, duration: Int) {
        self.title = title
        self.start = start
        self.duration = duration
        self.color = [UIColor.blue,
                      UIColor.yellow,
                      UIColor.green,
                      UIColor.red].randomElement()!
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
        
        self.init(title: title, start: start, duration: duration)
    }
}

extension TripEvent: DatabaseRepresentation {
    
    var representation: [String : Any] {
        let rep: [String: Any] = [
            "title": self.title,
            "start": self.start,
            "duration": self.duration
        ]
        return rep
    }
    
}
