//
//  SreviceListTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 30/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class SreviceListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDuration: CustomLabel_Light!
    @IBOutlet weak var lbltitle: CustomLabel_bold!
    @IBOutlet weak var lblDetail: CustomLabel_Light!
    
    @IBOutlet weak var lblCost: CustomLabel_bold!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
