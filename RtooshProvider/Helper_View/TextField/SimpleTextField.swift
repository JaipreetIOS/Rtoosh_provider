//
//  SimpleTextField.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class SimpleTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var padding = UIEdgeInsets(top: 0, left: 12 , bottom: 0, right: 12);
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        //        titleLabel?.font = UIFont.init(name: "avenir-lt-65-medium-5969f31f07372", size: 15)!
        
       
            // Fallback on earlier versions
            backgroundColor = #colorLiteral(red: 0.951546371, green: 0.9255756736, blue: 0.9337655902, alpha: 1)
		font = UIFont.init(name: "AvenirLT-Medium", size: (font?.pointSize)!)

        
        layer.cornerRadius = 4
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.9010945431, green: 0.8813405367, blue: 0.8900866399, alpha: 1)
        layer.masksToBounds = true
        
    }

}
