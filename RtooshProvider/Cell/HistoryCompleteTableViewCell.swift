//
//  HistoryCompleteTableViewCell.swift
//  RtooshProvider
//
//  Created by Apple on 20/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class HistoryCompleteTableViewCell: UITableViewCell {

	@IBOutlet weak var bgView: BackView!
	@IBOutlet weak var lblChTime: CustomLabel_Light!
    @IBOutlet weak var lblDay: CustomLabel_Light!
    @IBOutlet weak var lblTotal: CustomLabel_bold!
    @IBOutlet weak var item3: CustomLabel_Light!
    @IBOutlet weak var item2: CustomLabel_Light!
    @IBOutlet weak var item1: CustomLabel_Light!
    @IBOutlet weak var viewItem3: UIView!
    @IBOutlet weak var viewItem2: UIView!
    @IBOutlet weak var viewItem1: UIView!
    @IBOutlet weak var lblTag: CustomLabel_Light!
    @IBOutlet weak var viewTag: UIView!
    @IBOutlet weak var lblTime: CustomLabel_Light!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var viewTimeDate: UIView!
    @IBOutlet weak var btnDetail: CustomButton_Light!
    override func awakeFromNib() {
        super.awakeFromNib()
		bgView.layer.cornerRadius = 12

        btnDetail.layer.cornerRadius = 12
        btnDetail.layer.masksToBounds = true

        viewTimeDate.layer.cornerRadius = 12
        viewTag.layer.cornerRadius = 12
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
