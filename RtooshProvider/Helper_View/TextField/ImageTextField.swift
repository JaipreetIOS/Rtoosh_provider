//
//  ImageTextField.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ImageTextField: UITextField {
    @IBInspectable var Image: UIImage?
    var image_back = UIImageView()
    var image = UIImageView()
    var lbl = UILabel()

    var lbl_line = UILabel()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var padding = UIEdgeInsets(top: 0, left: 40 , bottom: 0, right: 5);
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func draw(_ rect: CGRect) {
        
        padding = UIEdgeInsets(top: 0, left: (frame.size.width * 14)/100 + 10  , bottom: 0, right: 5)
        
        image_back.frame =  CGRect.init(x: 0, y: 0, width: (frame.size.width * 14)/100 , height: frame.size.height)
        image_back.image = #imageLiteral(resourceName: "nav_barHome")
        image.frame =  CGRect.init(x: 16, y: 12, width: (frame.size.width * 14)/100 - 32 , height: (frame.size.width * 14)/100 - 32)
        image.image = Image
        
        addSubview(image_back)
        addSubview(image)
        
        if placeholder == "Phone Number"{
            
//             image.frame =  CGRect.init(x: 16, y: 12, width: (frame.size.width * 14)/100 - 32 , height: (frame.size.width * 14)/100 - 32)
            
                  lbl.frame =  CGRect.init(x: (frame.size.width * 14)/100, y: 0, width: (frame.size.width * 14)/100 , height: frame.size.height)
            lbl.text = "+966"
            lbl.textAlignment = .center
            addSubview(lbl)
            
            lbl_line.frame =  CGRect.init(x: ((frame.size.width * 14)/100)*2, y: 4, width: 1 , height: frame.size.height - 8)
            lbl_line.text = ""
            lbl_line.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            addSubview(lbl_line)
            padding = UIEdgeInsets(top: 0, left: (frame.size.width * 14)/100 + 10  + (frame.size.width * 14)/100, bottom: 0, right: 5)


        }
        
        
       
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        //        titleLabel?.font = UIFont.init(name: "avenir-lt-65-medium-5969f31f07372", size: 15)!
        layer.cornerRadius = 4
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.borderWidth = 1
        backgroundColor = #colorLiteral(red: 0.8913388325, green: 0.8913388325, blue: 0.8913388325, alpha: 1)
        layer.masksToBounds = true
    }

}
