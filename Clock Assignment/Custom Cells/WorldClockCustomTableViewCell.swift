//
//  WorldClockCustomTableViewCell.swift
//  Clock Assignment
//
//  Created by Muhammad Usman on 07/07/2021.
//

import UIKit

class WorldClockCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var amPmLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var differenceHoursLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        hoursLabel.isHidden = editing
        amPmLabel.isHidden = editing
    }
    
}
