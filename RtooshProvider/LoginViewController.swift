//
//  LoginViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

var PhoneNumber : String = ""

class LoginViewController: UIViewController , NVActivityIndicatorViewable{

    @IBOutlet weak var txtPhoneNumber: ImageTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Send(_ sender: Any) {
        
        let i : Int = (txtPhoneNumber.text?.characters.count)!

		if txtPhoneNumber.text?.characters.first == "0"{
			if i != 10{
				dataModel.ToastAlertController(Message: "Enter valid phone number", alertMsg: "")
			}
			else{
				Login()
			}
		}
		else{
			if i != 10{
				dataModel.ToastAlertController(Message: "Enter valid phone number", alertMsg: "")
			}
			else{
				Login()
			}
		}


    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func Login()  {
        let Dict = ["phone": txtPhoneNumber.text!,
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

                    if dict.value(forKey: "id") is String  {

                        CurrentUserID = dict.value(forKey: "id") as! String
//                        CurrentUserData = NSMutableDictionary.init(dictionary: dict)
                        CurrentPhoneNumber = dict.value(forKey: "phone") as! String
//                        UserDefaults.standard.set(CurrentPhoneNumber, forKey: "CurrentPhoneNumber")
//
//                        UserDefaults.standard.set(CurrentUserData, forKey: "CurrentUserData")
//                        UserDefaults.standard.synchronize()
                        PhoneNumber = self.txtPhoneNumber.text!

                        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                        vc.OTP = "\(Data.value(forKey: "otp") as Any)"

                        self.present(vc, animated: true, completion: nil)
                    }
                    else{
                        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                        PhoneNumber = self.txtPhoneNumber.text!
                        vc.OTP = "\(Data.value(forKey: "otp") as Any)"
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                    
                    
                    
                    
                }
                else{
                                        dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
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
