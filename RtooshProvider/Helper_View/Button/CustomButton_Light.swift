//
//  CustomButton_Light.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CustomButton_Light: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//
//
//    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        self.titleLabel?.font = UIFont.init(name: "AvenirLTStd-Light", size: (titleLabel?.font.pointSize)!)!

        
    }

}
