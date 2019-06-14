//
//  AddEventDelegate.swift
//  bon-voyage
//
//  Created by Harsil Patel on 30/5/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import Foundation
protocol AddEventDelegate {
    func addEvent(newEvent: TripEvent) -> Bool
}
