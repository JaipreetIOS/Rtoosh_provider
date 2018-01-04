//
//  CustomButton_Bold.swift
//  RtooshProvider
//
//  Created by Apple on 06/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CustomButton_Bold: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        self.titleLabel?.font = UIFont.init(name: "Avenir-Black", size: (titleLabel?.font.pointSize)!)!
        
        
    }

}
