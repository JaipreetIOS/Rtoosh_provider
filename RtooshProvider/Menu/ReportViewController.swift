//
//  ReportViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView
import IQKeyboardManagerSwift

class ReportViewController: UIViewController , NVActivityIndicatorViewable {

    @IBOutlet weak var txtDis: IQTextView!
    @IBOutlet weak var txtname: SimpleTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDis.layer.cornerRadius = 8
        txtDis.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        txtDis.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func PostRequest()  {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
//        apis/addProblem?name=gsgdfsgdfs&user_id=59&description=ggggdsgdfgsfg&lang=en
        let Dict = ["user_id" : CurrentUserID, "name" : txtname.text! ,"description": txtDis.text! , "lang" : "en"]
        print(Dict)
      
        
        dataModel.PostApi(Url: "apis/addProblem?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    self.txtname.text = ""
                    self.txtDis.text = ""
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
        if CheckTextField.Check_text(text: txtDis.text!) && CheckTextField.Check_text(text: txtname.text!){
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
