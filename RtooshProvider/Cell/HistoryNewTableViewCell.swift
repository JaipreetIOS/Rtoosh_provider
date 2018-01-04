//
//  HistoryNewTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 20/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class HistoryNewTableViewCell: UITableViewCell {

    
	@IBOutlet weak var bgView: BackView!
	@IBOutlet weak var lblChTime: CustomLabel_Light!
    @IBOutlet weak var lblDay: CustomLabel_Light!
    
    @IBOutlet weak var lblTime: CustomLabel_Light!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var viewTimeDate: UIView!
    @IBOutlet weak var btnDetail: CustomButton_Light!
    @IBOutlet weak var btnDecline: CustomButton_Light!
    @IBOutlet weak var btnAccept: CustomButton_Light!
    @IBOutlet weak var lblNumberService: CustomLabel_Medium!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 12
        btnDecline.layer.cornerRadius = 15
        btnDecline.layer.masksToBounds = true
        
        btnAccept.layer.cornerRadius = 15
        btnAccept.layer.masksToBounds = true
        
        btnDetail.layer.cornerRadius = 12
        btnDetail.layer.masksToBounds = true
        
        viewTimeDate.layer.cornerRadius = 12
        lblCount.layer.cornerRadius = 12
        lblTime.layer.cornerRadius = 12
        lblCount.layer.masksToBounds = true
        lblTime.layer.masksToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
