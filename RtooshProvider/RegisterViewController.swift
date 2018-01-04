//
//  RegisterViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

var RegisterData : NSMutableDictionary! = [:]

class RegisterViewController: UIViewController , NVActivityIndicatorViewable , UIPickerViewDelegate, UIPickerViewDataSource  , UITextFieldDelegate{

    @IBOutlet weak var txtSelect: ImageTextField!
    @IBOutlet weak var txtPassword: ImageTextField!
    @IBOutlet weak var txtEmail: ImageTextField!
    @IBOutlet weak var txtFullname: ImageTextField!
    
    var pickerView = UIPickerView()
    var pickOption = ["Salon Owne", "Provider"]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        
        
        
        
        
        txtSelect.inputView = pickerView

        // Do any additional setup after loading the view.
    }
    @IBAction func SelectDate(_ sender: UITextField) {
        
//        let datePickerView = UIDatePicker()
//        datePickerView.datePickerMode = .date
//        sender.inputView = datePickerView
//        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)
//
        
    }
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        
        
        
        txtSelect.text = dateFormatter.string(from: sender.date)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtSelect.text = pickOption[row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Done(_ sender: Any) {
        
        if CheckTextField.Check_text(text: txtFullname.text!) && CheckTextField.Check_text(text: txtSelect.text!) && CheckTextField.Check_Email(text: txtEmail.text!) && CheckTextField.Check_Password(text: txtPassword.text!){
//http://rotsys.com/api/apis/Register?&user_role=Salon%20Owne
            
           

            Register()



            
  
            
        }
        
        
       
        
    }
    func Register()  {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
//        apis/Register?full_name=abc&email=abc@gmail.com&country_code=%2B966&phone=1234567890&password=123456&user_type=2&user_role=Salon%20Owner&deviceToken=e-W2ymuKz1Q:APA91bFoKPaveB09IOhbxIOcrV_ukEQSXM9_gmu3EL3CbqkglPk7p9gj8kVuyZ88-i-aw0F9nJLF6c_BiuLrEEG6xNMqO3LnYC9Qk5DTAOOHFvD5HXtWoVk1bgrQiLAjNAJd_IxgWqNq&deviceType=Android&lang=en
        let Dict = ["deviceToken" : CurrentDeviceToken,
                    "deviceType" : "ios" ,
                    "lang" : "en" ,
                    "user_type" : "2" ,
                    "country_code" : "+91" ,

                    "full_name" : txtFullname.text! ,
                    "phone" : PhoneNumber,
                    "email" : txtEmail.text! ,
                    "user_role" : txtSelect.text! ,

                    "password": txtPassword.text!]
        
        print(Dict)
        //            name=Himanshu kumar&email=himanshukumar@gmail.com&password=123456
        
        dataModel.PostApi(Url: "apis/Register?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    print(Data)
                    let dict = Data.value(forKey: "data") as! NSDictionary
                    let userData = dict.value(forKey: "User") as! NSDictionary

                    RegisterData.setValue(CurrentDeviceToken, forKey: "deviceToken")
                    RegisterData.setValue("ios", forKey: "deviceType")
                    RegisterData.setValue("en", forKey: "lang")
                    RegisterData.setValue(userData.value(forKey: "id") as! String , forKey: "user_id")
                    
                    CurrentUserID = userData.value(forKey: "id") as! String
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountStatusViewController") as! AccountStatusViewController
                    self.present(vc, animated: true, completion: nil)
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
