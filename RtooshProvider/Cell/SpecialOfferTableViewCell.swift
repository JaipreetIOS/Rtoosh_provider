//
//  SpecialOfferTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 27/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class SpecialOfferTableViewCell: UITableViewCell {
	@IBOutlet weak var img: UIImageView!

	@IBOutlet weak var bgView: BackView!
	@IBOutlet weak var CatName: CustomLabel_Medium!
	@IBOutlet weak var cost: CustomLabel_Medium!
	@IBOutlet weak var duration: CustomLabel_Medium!
	@IBOutlet weak var liteName: CustomLabel_Light!
	@IBOutlet weak var NAME: CustomLabel_Medium!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
