//
//  LocationDetailsTableViewCell.swift
//  DefineLabsAssignment
//
//  Created by Rishikesh Yadav on 3/14/21.
//

import UIKit

class LocationDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    let unselectedTint = UIColor.lightGray
    let selectedTint = UIColor.blue
    
    func setupCell(selectedVenue: Venue) {
        let location = selectedVenue.location.city + ", " + selectedVenue.location.country
        titleLabel.text = selectedVenue.name
        locationLabel.text = location
        accessoryType = .checkmark
        updateCellSelection(with: selectedVenue.isVenueSaved)
    }
    
    func updateCellSelection(with isVenueSelected: Bool) {
        tintColor = isVenueSelected ? selectedTint : unselectedTint
    }
    
}
