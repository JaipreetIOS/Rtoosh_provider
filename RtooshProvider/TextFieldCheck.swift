//
//  TextFieldCheck.swift
//  RtooshProvider
//
//  Created by Apple on 06/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class TextFieldCheck: NSObject {
    
    
    func Check_Username(text : String) -> Bool {
        if text.contains(" "){
            dataModel.ToastAlertController(Message: "Username not contain 'Space'", alertMsg: "")
            return false
        }
        if text.characters.count <= 4{
            dataModel.ToastAlertController(Message: "Username required atlest 4 character", alertMsg: "")

            return false
        }
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if text.rangeOfCharacter(from: characterset.inverted) != nil {
            dataModel.ToastAlertController(Message: "Username not contain special character", alertMsg: "")

            return false
        }
        return true
    }
    func Check_Email(text : String) -> Bool {
        if text.contains(" "){
            dataModel.ToastAlertController(Message: "Enter valid email", alertMsg: "")

            return false
        }
        if !(text.contains("@")){
            dataModel.ToastAlertController(Message: "Enter valid email", alertMsg: "")

            return false
        }
        return true
    }
    func Check_Password(text : String) -> Bool {
        if text.characters.count < 6{
            dataModel.ToastAlertController(Message: "Password required atlest 6 character", alertMsg: "")

            return false
        }
        if text.contains(" "){
            dataModel.ToastAlertController(Message: "Password not contain 'Space'", alertMsg: "")

            return false
        }
        return true
    }
    func Check_text(text : String) -> Bool {
        if text.characters.count == 0{
            dataModel.ToastAlertController(Message: "Enter valid text", alertMsg: "")

            return false
        }
        if text.first == " "{
            dataModel.ToastAlertController(Message: "Enter valid text", alertMsg: "")

            return false
        }
        return true
    }
    

}
