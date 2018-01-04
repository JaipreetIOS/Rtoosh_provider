//
//  CircleLabel.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CircleLabel: UILabel {

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
        self.font = UIFont.init(name: "AvenirLT-Medium", size: font.pointSize)

        layer.cornerRadius = frame.size.height/2
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.borderWidth = 2
        layer.masksToBounds = true
        
    }
}
