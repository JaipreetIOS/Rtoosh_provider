//
//  SceduleTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class SceduleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPerson: CustomLabel_bold!
    @IBOutlet weak var btnSub: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblDetail: CustomLabel_Light!
    @IBOutlet weak var lblTitle: CustomLabel_bold!
    @IBOutlet weak var lblPersonCount: CustomLabel_bold!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
