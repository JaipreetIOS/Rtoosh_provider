//
//  RatingTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 11/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Cosmos

class RatingTableViewCell: UITableViewCell {
    @IBOutlet weak var viewLOC: CosmosView!
    @IBOutlet weak var viewQOS: CosmosView!
    @IBOutlet weak var viewAT: CosmosView!
    @IBOutlet weak var viewCF: CosmosView!
    @IBOutlet weak var lblFeedback: CustomLabel_Medium!
    @IBOutlet weak var lblDate: CustomLabel_Light!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
