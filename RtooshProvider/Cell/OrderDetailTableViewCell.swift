//
//  OrderDetailTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 04/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var count: CustomLabel_Light!
    
    @IBOutlet weak var cost: CustomLabel_bold!
    @IBOutlet weak var namr: CustomLabel_Light!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
