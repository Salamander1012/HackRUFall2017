//
//  EventTableViewCell.swift
//  HackRu2017Fall
//
//  Created by Salman Fakhri on 10/14/17.
//  Copyright © 2017 Salman Fakhri. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var checkedInLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    var isCheckedIn = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(eventName: String, eventLocation:String) {
        eventNameLabel.text = eventName
        eventLocationLabel.text = eventLocation
        if isCheckedIn == false {
            checkedInLabel.text = "Check In"
            checkedInLabel.textColor = UIColor.blue
            
        } else {
            checkedInLabel.text = "You are checked In"
            checkedInLabel.textColor = UIColor.green
        }
        
        
    }
    
    func changeCheckInStatus() {
        isCheckedIn = !isCheckedIn
        //print(isCheckedIn)
    }

}
