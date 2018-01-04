//
//  OTPTextField.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class OTPTextField: UITextField {

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
		font = UIFont.init(name: "AvenirLT-Medium", size: (font?.pointSize)!)

       
        layer.cornerRadius = 4
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.942486465, green: 0.3576512337, blue: 0.2606952488, alpha: 1)
        layer.masksToBounds = true
    }

}
