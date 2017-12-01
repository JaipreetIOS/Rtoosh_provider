//
//  RadioButton.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    @IBInspectable var SelectedImage: UIImage?
    @IBInspectable var UnselectedImage: UIImage?
    @IBInspectable var Title_string : String?

    var image = UIImageView()
    var title_lbl = UILabel()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 
    */
    open var Selected_Image : UIImage = #imageLiteral(resourceName: "ic_register_uncheck_service") {
        didSet {
           
       image.image = Selected_Image
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        image.frame =  CGRect.init(x: 16, y: 12, width: (frame.size.width * 14)/100 - 32 , height: (frame.size.width * 14)/100 - 32)
        
         title_lbl.frame =  CGRect.init(x: (frame.size.width * 14)/100 + 12, y: 12, width: frame.size.width - (frame.size.width * 14)/100 + 12 , height: frame.size.height - 12 )
        image.image = #imageLiteral(resourceName: "ic_uncheck_service")
        setTitle("", for: .normal)
        title_lbl.text = Title_string
        title_lbl.textAlignment = .left
        addSubview(image)
        addSubview(title_lbl)
        
        
        
    }

}
