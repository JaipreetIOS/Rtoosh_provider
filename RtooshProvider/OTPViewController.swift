//
//  OTPViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView

class OTPViewController: UIViewController , UITextFieldDelegate , NVActivityIndicatorViewable{

	@IBOutlet weak var btnResendOTP: CustomButton_Bold!
	@IBOutlet weak var c_top_C: NSLayoutConstraint!
    @IBOutlet weak var txt_OTP_4: UITextField!
    @IBOutlet weak var txt_OTP_3: UITextField!
    @IBOutlet weak var txt_OTP_2: UITextField!
    @IBOutlet weak var txt_OTP_1: UITextField!
    var OTP : String = ""
	var timer = Timer()
	var time : Int = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_OTP_1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txt_OTP_2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txt_OTP_3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txt_OTP_4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotificationopen(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotificationHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

			btnResendOTP.isEnabled = false

		timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Waiting), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
	 @objc func Waiting() {
		time = time - 1
		if time == 0 {
			timer.invalidate()
			btnResendOTP.isEnabled = true


		}
		//    self.tblWaiting.reloadData()
	}

    @objc func keyboardNotificationopen(notification: NSNotification) {
        c_top_C.constant = -200
    
    }
    @objc func keyboardNotificationHide(notification: NSNotification) {
        
        c_top_C.constant = 0

    }
    override func viewDidAppear(_ animated: Bool) {
        dataModel.ToastAlertController(Message: "", alertMsg: OTP)
        IQKeyboardManager.sharedManager().enable = false
        

    }
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Post_OTP()  {
        
        
        let otp = "\(txt_OTP_1.text!)\(txt_OTP_2.text!)\(txt_OTP_3.text!)\(txt_OTP_4.text!)"
        let Dict = ["phone": PhoneNumber,
                    "lang" : "en",
                    "deviceToken" : CurrentDeviceToken,
                    "deviceType" : "ios",
                    "userType" : "2",
                    "otp" : otp]
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        //      verifyOtp?phone=01230123&otp=1020&deviceToken=&deviceType=Android&lang=en&userType=2
        dataModel.GEtApi(Url: "customers/verifyOtp?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String != "0"{
                    
                    let dict = Data.value(forKey: "register") as!  String
                    if dict == "1"{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                    else{
                        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                    
                    
                    
                    
                    
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
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
            
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                // Not found, so remove keyboard.
//                textField.resignFirstResponder()
            }
            
//            IQKeyboardManager.sharedManager().goNext()

        }
        
    }
    
    @IBAction func Done(_ sender: Any) {
        let otp = "\(txt_OTP_1.text!)\(txt_OTP_2.text!)\(txt_OTP_3.text!)\(txt_OTP_4.text!)"

        if otp.characters.count != 4{
            dataModel.ToastAlertController(Message: "Enter Valid OTP", alertMsg: "")
        }
        else{
            Post_OTP()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

	func Resend_OTP()  {
		let Dict = ["phone": PhoneNumber,
		            "lang" : "en",
		            "deviceToken" : CurrentDeviceToken,
		            "deviceType" : "ios",
		            "country_code" : "+91",
		            "userType" : "2"]
		self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
		print(Dict)
		//        /sentOtp?phone=8284986466&lang=en&deviceToken&devicetype&country_code=+91
		dataModel.GEtApi(Url: "apis/sentOtp", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
			self.stopAnimating()

			if error == "Error"{
				dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")

			}
			else{
				if Data.value(forKey: "response") as! String != "0"{
					print(Data)
					let dict = Data.value(forKey: "data") as!  NSDictionary


					self.time = 120

                   self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Waiting), userInfo: nil, repeats: true)
					self.btnResendOTP.isEnabled = false

				}
				else{
					dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

				}
			}
		})


	}


	@IBAction func ResendOtp(_ sender: Any) {
		Resend_OTP()
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
