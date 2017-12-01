//
//  ScheduleTimeTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 01/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ScheduleTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var time: SimpleTextField!
    
    @IBOutlet weak var name: CustomLabel_Medium!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
