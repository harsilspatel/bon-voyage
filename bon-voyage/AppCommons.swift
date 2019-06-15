//
//  AppCommons.swift
//  bon-voyage
//
//  Created by Harsil Patel on 15/6/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import Firebase
import Foundation
import GooglePlaces

class AppCommons {
    static let sharedInstance = AppCommons()
    
    let database = Firestore.firestore()
    let placesClient = GMSPlacesClient.shared()
    var userName: String?
    
    private init() {
//        database =
//        placesClient = GMSPlacesClient.shared()
    }
}
