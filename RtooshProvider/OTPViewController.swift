//
//  OTPViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class OTPViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var txt_OTP_4: UITextField!
    @IBOutlet weak var txt_OTP_3: UITextField!
    @IBOutlet weak var txt_OTP_2: UITextField!
    @IBOutlet weak var txt_OTP_1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_OTP_1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txt_OTP_2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txt_OTP_3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txt_OTP_4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Text1(_ sender: UITextField) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = ""
//        txt_OTP_4.text = ""
//        txt_OTP_3.text = ""
//        txt_OTP_2.text = ""
//        txt_OTP_1.text = ""
//        txt_OTP_1.becomeFirstResponder()
    }
    
    
    
    @objc  func textFieldDidChange(_ textField: UITextField) {
//        if textField == txt_OTP_1 {
//            if txt_OTP_1.text?.characters.count == 1{
//                IQKeyboardManager.sharedManager().goNext()
//            }
//        }
//
//        if textField == txt_OTP_2 {
//            if txt_OTP_2.text?.characters.count == 1{
//                IQKeyboardManager.sharedManager().goNext()
//
//            }
//        }
//
//        if textField == txt_OTP_2 {
//            if txt_OTP_2.text?.characters.count == 1{
//                IQKeyboardManager.sharedManager().goNext()
//
//            }
//        }
//
        
     
        
        let  char = textField.text?.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            print("Backspace was pressed")
//            IQKeyboardManager.sharedManager().goPrevious()

        }
        else{
            
                let str = textField.text!
                let lastChar = str.characters.last!
                textField.text = ""
                textField.text = "\(lastChar)"
                        if textField == txt_OTP_4 {

                txt_OTP_4.resignFirstResponder()
            }
            
            
            
            IQKeyboardManager.sharedManager().goNext()

        }
        
    }
    
    @IBAction func Done(_ sender: Any) {
        let vc =  storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
