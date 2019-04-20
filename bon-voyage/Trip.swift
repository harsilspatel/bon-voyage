//
//  Trip.swift
//  bon-voyage
//
//  Created by Harsil Patel on 21/4/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit

class Trip: NSObject {
    var title: String
    var subtitle: String
    var thumbnail: UIImage

    
    init(title: String, thumbnail: UIImage, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
    }
    
    
}
