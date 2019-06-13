//
//  AppDelegate.swift
//  bon-voyage
//
//  Created by Harsil Patel on 21/4/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var ref: DatabaseReference!
    
    var user = "test"
    var trip = "New York"
    
    let data = [["description": ["Breakfast at Tiffany's", "New York, 5th avenue"],
                 "start": "2019-05-30 14:00:00",
                 "duration": 60],
                
                ["description": ["Workout", "Tufteparken"],
                 "start": "2019-05-30 8:00:00",
                 "duration": 90],
                
                ["description": ["Meeting with Alex",
                                 "Home",
                                 "Oslo, Tjuvholmen"],
                 "start": "2019-05-31 18:30:00",
                 "duration": 60],
                
                ["description": ["Beach Volleyball",
                                 "Ipanema Beach",
                                 "Rio De Janeiro"],
                 "start": "2019-05-29 13:30:00",
                 "duration": 120],
                
                ["description": ["WWDC",
                                 "Moscone West Convention Center",
                                 "747 Howard St"],
                 "start": "2019-05-30 17:00:00",
                 "duration": 90],
                
                ["description": ["Google I/O",
                                 "Shoreline Amphitheatre",
                                 "One Amphitheatre Parkway"],
                 "start": "2019-05-29 12:00:00",
                 "duration": 120],
                
                ["description": ["Software Development Lecture",
                                 "Mikpoli MB310",
                                 "Craig Federighi"],
                 "start": "2019-05-31 14:00:00",
                 "duration": 60],
    ]


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GMSServices.provideAPIKey(googleMapsKey)
        GMSPlacesClient.provideAPIKey(googleMapsKey)
        
        AppSettings.displayName = "testuser"
        
//        self.ref.child("users/\(user)/trips\(trip)/\(date)").setValue([
//            ["Breakfast at Tiffany's", "New York, 5th avenue"],
//            ["Workout", "Tufteparken"]
//        ])
//        self.ref.child("users").child(user).child("trips").child(trip).updateChildValues(["events": data])
        
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = UINavigationController(rootViewController: BasicExampleViewController())
//        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

