//
//  CustomLabel_bold.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CustomLabel_bold: UILabel {
    @IBInspectable var FontSize: CGFloat = 15.0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   
     */
//    override func draw(_ rect: CGRect) {
//        // Drawing code
////        font = UIFont.init(name: "Avenir-Black", size: CGFloat(FontSize))
//        print(FontSize)
////        font = UIFont.init(name: "Avenir-Black", size: CGFloat(FontSize))
//
//
//    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
       
//        font = UIFont.boldSystemFont(ofSize: 17)
        font = UIFont.init(name: "Avenir-Black", size: font.pointSize)

    }

}
