//
//  RadioButtonTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 01/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class RadioButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btn: RadioButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
