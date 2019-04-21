//
//  TripTableViewCell.swift
//  bon-voyage
//
//  Created by Harsil Patel on 21/4/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cityThumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func inflate(trip: Trip) {
        titleLabel.text = trip.title
        subtitleLabel.text = trip.subtitle
        cityThumbnail.image = trip.thumbnail
        
        cityThumbnail.clipsToBounds = true
        cityThumbnail.layer.cornerRadius = 7
        cityThumbnail.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
