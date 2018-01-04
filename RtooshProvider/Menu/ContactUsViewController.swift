//
//  ContactUsViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView

class ContactUsViewController: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var txtComment: IQTextView!
    @IBOutlet weak var txtName: ImageTextField!
    @IBOutlet weak var txtEmail: ImageTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtComment.layer.cornerRadius = 8
        txtComment.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        txtComment.layer.borderWidth = 0.5
        txtName.text = CurrentUserData.value(forKey: "full_name") as? String
        txtEmail.text = CurrentUserData.value(forKey: "email") as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BAck(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        self.present(vc , animated: true, completion: nil)
    }
    func PostRequest()  {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        //     apis/contactUs?user_id=59&description=dfdafdsfdsfdasfdasfdsfas&lang=en
        let Dict = ["user_id" : CurrentUserID, "description": txtComment.text! , "lang" : "en", "name" : txtName.text!]
        print(Dict)
        
        
        dataModel.PostApi(Url: "apis/addProblem?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    self.txtComment.text = ""
                    //                  self.dismiss(animated: true, completion: nil)
                    
					dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }

    @IBAction func Save(_ sender: Any) {
      if  CheckTextField.Check_text(text: txtComment.text!) {
          PostRequest()
        }
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
