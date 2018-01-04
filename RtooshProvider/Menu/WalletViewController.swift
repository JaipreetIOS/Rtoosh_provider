//
//  WalletViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class WalletViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var lblBalance: CustomLabel_bold!
    @IBOutlet weak var lblEarning: CustomLabel_Medium!
    
    @IBOutlet weak var txtName: SimpleTextField!
    @IBOutlet weak var txtNumber: SimpleTextField!
    @IBOutlet weak var btnUpdateAccount: UIButton!
    @IBOutlet weak var lblYourEarning: CustomLabel_Medium!
    @IBOutlet weak var lblYourBalance: CustomLabel_bold!
   
    @IBOutlet weak var lblDue: CustomLabel_Medium!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetWallet()
        // Do any additional setup after loading the view.
    }
    @IBAction func BAck(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        self.present(vc , animated: true, completion: nil)
    }
    
    func GetWallet()  {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["user_id" : CurrentUserID,"lang": "en"]
        print(Dict)
        //         http://rotsys.com/api/customers/wallet?lang=en&user_id=97
        
        dataModel.PostApi(Url: "customers/wallet?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    print(Data)
                    let Bal_dict = Data.value(forKey: "wallet") as! NSDictionary
					let Account_dict = Data.value(forKey: "account") as! NSDictionary
					let Acc_dict = Account_dict.value(forKey: "Account") as! NSDictionary
					self.txtName.text = Acc_dict.value(forKey: "name") as? String
					self.txtNumber.text = Acc_dict.value(forKey: "iban_no") as? String

                    self.lblDue.text = "\(Bal_dict.value(forKey: "due") as! String) SAR"
                    self.lblBalance.text = "\(Bal_dict.value(forKey: "balance") as! String) SAR"
                    self.lblYourBalance.text = "\(Bal_dict.value(forKey: "balance") as! String) SAR"
                    self.lblYourEarning.text = "\(Bal_dict.value(forKey: "earning") as! String) SAR"

                    var reqPoint : CGFloat = 0
                    if let n = NumberFormatter().number(from:  Bal_dict.value(forKey: "balance") as! String) {
                        let f = CGFloat( n)
                        reqPoint =  f
                        
                    }
                    
                    var reqPoint1 : CGFloat = 0
                    if let n = NumberFormatter().number(from:  Bal_dict.value(forKey: "earning") as! String) {
                        let f = CGFloat(n)
                        reqPoint1 =  f
                        
                    }
                    
                    self.lblEarning.text = "\(reqPoint + reqPoint1) SAR"

                    if let n = NumberFormatter().number(from: Bal_dict.value(forKey: "earning") as! String) {
                        let f = CGFloat(n)
                        print(f)
                    }
                    
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ContactUs(_ sender: Any) {

		let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
		present(vc, animated: true, completion: nil)
    }
    @IBAction func UpdateAccount(_ sender: UIButton) {
        if sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "ic_action_mode_edit"){
            sender.setBackgroundImage(#imageLiteral(resourceName: "ic_action_check_red"), for: .normal)
          
            txtNumber.isUserInteractionEnabled = true
            txtName.isUserInteractionEnabled = true

        }
        else{
            if CheckTextField.Check_text(text: txtName.text!) && CheckTextField.Check_text(text: txtNumber.text!) {
            Update()
            }
        }
    }
    func Update()  {
        
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["name" : txtName.text!, "user_id" : CurrentUserID ,"iban_no": txtNumber.text! , "lang" : "en"]
        print(Dict)
        //         customers/updateAccount?user_id=249&name=Rishav&iban_no=1234&lang=en
        
        dataModel.PostApi(Url: "customers/updateAccount", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
					print(Data)
                    self.btnUpdateAccount.setBackgroundImage(#imageLiteral(resourceName: "ic_action_mode_edit"), for: .normal)
                    self.txtNumber.isUserInteractionEnabled = false
                    self.txtName.isUserInteractionEnabled = false
					dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)


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
