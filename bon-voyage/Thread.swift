//
//  Thread.swift
//  bon-voyage
//
//  Created by Harsil Patel on 15/6/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Thread {
    let id: String?
    let name: String
    
    init(name: String, id: String) {
        self.id = id
        self.name = name
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.name = name
    }
    
}

extension Thread: DatabaseRepresentation {
    var representation: [String : Any] {
        var rep = ["name": name]
        
        if let id = id {
            rep["id"] = id
        }
        
        return rep
    }
}

extension Thread: Comparable {
    static func == (lhs: Thread, rhs: Thread) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Thread, rhs: Thread) -> Bool {
        return lhs.name < rhs.name
    }
}
