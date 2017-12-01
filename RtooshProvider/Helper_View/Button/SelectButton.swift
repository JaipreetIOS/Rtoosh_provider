//
//  SelectButton.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class SelectButton: UIButton {

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
//        titleLabel?.font = UIFont.init(name: "avenir-lt-65-medium-5969f31f07372", size: 15)!
        
        setBackgroundImage(#imageLiteral(resourceName: "nav_barHome"), for: .normal)
        layer.cornerRadius = frame.size.height/2
        layer.masksToBounds = true
    }

}
