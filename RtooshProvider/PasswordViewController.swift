//
//  PasswordViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PasswordViewController: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var txtPassword: ImageTextField!
    @IBOutlet weak var bgButton: UIButton!
    
    @IBOutlet weak var btnSend: CustomButton_Bold!
    @IBOutlet weak var txtForgotNumber: ImageTextField!
    @IBOutlet weak var viewForgotpassword: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgButton.isHidden = true
        viewForgotpassword.isHidden = true
        viewForgotpassword.layer.shadowColor = UIColor.black.cgColor
        viewForgotpassword.layer.shadowOpacity = 1
        viewForgotpassword.layer.shadowRadius = 8
        viewForgotpassword.layer.shadowOffset = CGSize.zero
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Send(_ sender: Any) {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        let Dict = [
                    "lang" : "en" ,
                    "userType" : "2" ,
                    "country_code" : "+91" ,
                    
                    "phone" : PhoneNumber,
   
                    
                    "password": txtPassword.text!]
        
        print(Dict)
        //            name=Himanshu kumar&email=himanshukumar@gmail.com&password=123456
//        customers/validatePassword?phone=1212121&password=1234566&lang=en&userType=2
        dataModel.PostApi(Url: "customers/validatePassword?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    print(Data)
                    let dict = Data.value(forKey: "data") as!  NSDictionary
                    let data  = dict.value(forKey: "User") as!  NSDictionary
                    CurrentUserID = data.value(forKey: "id") as! String
                    CurrentUserData = NSMutableDictionary.init(dictionary: data)
                    CurrentPhoneNumber = data.value(forKey: "phone") as! String
                    UserDefaults.standard.set(CurrentPhoneNumber, forKey: "CurrentPhoneNumber")
                    UserDefaults.standard.set(CurrentUserData, forKey: "CurrentUserData")
                    UserDefaults.standard.synchronize()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
                    self.present(vc , animated: true, completion: nil)
//                    let vc =  self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                    
//                    self.present(vc, animated: true, completion: nil)
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }
    @IBAction func ForgotPassword(_ sender: Any) {
        
        bgButton.isHidden = false
        viewForgotpassword.isHidden = false

        
    }
    @IBAction func SendForgot(_ sender: Any) {



		let i : Int = (txtForgotNumber.text?.characters.count)!

		if txtForgotNumber.text?.characters.first == "0"{
			if i != 10{
				dataModel.ToastAlertController(Message: "Enter valid phone number", alertMsg: "")
			}
			else{
				SendForgot()
			}
		}
		else{
			if i != 9{
				dataModel.ToastAlertController(Message: "Enter valid phone number", alertMsg: "")
			}
			else{
				SendForgot()
			}
		}
	}
	func SendForgot()  {




        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        let Dict = [
                    "lang" : "en" ,
                    "userType" : "2" ,
                    "country_code" : "+91" ,
                    
                    "phone" : txtForgotNumber.text!,
                    
                    
                   ]
        
        print(Dict)
        //           api/apis/forgetPassword?phone=12121212&country_code=+966&lang=en&userType=2
        
        dataModel.PostApi(Url: "apis/forgetPassword?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    print(Data)
                    self.bgButton.isHidden = true
                    self.viewForgotpassword.isHidden = true
					dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    
        
    }
    
    @IBAction func BGBUtton(_ sender: Any) {
        self.bgButton.isHidden = true
        self.viewForgotpassword.isHidden = true
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
