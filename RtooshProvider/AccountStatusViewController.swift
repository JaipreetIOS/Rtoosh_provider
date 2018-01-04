//
//  AccountStatusViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

var IdsServiceRegister : NSMutableDictionary! = [:]
var ScheduleRegister : NSMutableDictionary! = [:]
var ScrviceRegister : NSMutableDictionary! = [:]
var PublicInfoRegister : NSMutableDictionary! = [:]
var ScRegisteheduleTimeRegister : NSMutableArray = []


class AccountStatusViewController: UIViewController , NVActivityIndicatorViewable{

    @IBOutlet weak var lbl_Title: CustomLabel_Medium!
    @IBOutlet weak var lbl_4: CircleLabel!
    @IBOutlet weak var lbl_3: CircleLabel!
    @IBOutlet weak var lbl_2: CircleLabel!
    @IBOutlet weak var lbl_1: CircleLabel!
    @IBOutlet weak var ChildView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ID_sViewController") as! ID_sViewController
        
        // Add View Controller as Child View Controller
        lbl_1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl_1.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        addChildViewController(viewController)
        
        // Add Child View as Subview
        ChildView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = ChildView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Next(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "Save"
        {
            if Register_PublicInfo.value(forKey: "surname") is String && Register_PublicInfo.value(forKey: "bio") is String{
                RegisterData.setValue(Register_PublicInfo, forKey: "register_info")
                print(RegisterData)
            RegisterUser()
            }
//            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            present(vc, animated: true, completion: nil)
        }
        
        else{
        switch sender.tag {
        case 0:
            // Instantiate View Controller
            
                self.NextView(tag: sender.tag)
                
                sender.tag = 1
            
            
            
          
            
            
            
            
        case 1:
            
            
            if Register_ids.value(forKey: "id_number") is String && Register_ids.value(forKey: "id_type") is String && Register_ids.value(forKey: "issue_date") is String && Register_ids.value(forKey: "work_online") is String && Register_ids.value(forKey: "work_shedule") is String && isProofImageUploaded == true{
                
                RegisterData.setValue(Register_ids, forKey: "register_id")

                
                
                print("Register_ids == \(Register_ids)")
            self.NextView(tag: sender.tag)

            sender.tag = 2
            }
            if Register_ids.value(forKey: "work_shedule") as! String == "1"{
                RegisterData.setValue(ScRegisteheduleTimeRegister, forKey: "register_schedule_hours")

            }
            

       
        case 2:
            // Instantiate View Controller
              if Register_Schedule.value(forKey: "max_services") is String && Register_Schedule.value(forKey: "max_persons") is String && Register_Schedule.value(forKey: "min_order") is String {
                print("Register_Schedule == \(Register_Schedule)")
                RegisterData.setValue(Register_Schedule, forKey: "register_order")

            self.NextView(tag: sender.tag)

            sender.tag = 3
            }
            
            
        default:
            if Main_ServiceArray.count != 0{
            
                RegisterData.setValue(["services" : Main_ServiceArray], forKey: "register_service")

            sender.setTitle("Save", for: .normal)

            self.NextView(tag: sender.tag)

            }
        }
        
        }
    }
    
    func NextView(tag : Int)  {
        switch tag {
        case 0:
            // Instantiate View Controller
            
            
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ID_sViewController") as! ID_sViewController
            lbl_1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            lbl_1.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            // Add View Controller as Child View Controller
            
            addChildViewController(viewController)
            
            // Add Child View as Subview
            ChildView.addSubview(viewController.view)
            
            // Configure Child View
            viewController.view.frame = ChildView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Notify Child View Controller
            viewController.didMove(toParentViewController: self)
            
            
        case 1:
            
            lbl_2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            lbl_2.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            
            // Instantiate View Controller
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
            
            // Add View Controller as Child View Controller
            // Add View Controller as Child View Controller
            
            addChildViewController(viewController)
            
            // Add Child View as Subview
            ChildView.addSubview(viewController.view)
            
            // Configure Child View
            viewController.view.frame = ChildView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Notify Child View Controller
            viewController.didMove(toParentViewController: self)
        case 2:
            // Instantiate View Controller
            lbl_3.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            lbl_3.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ServiceViewController") as! ServiceViewController
            
            // Add View Controller as Child View Controller
            // Add View Controller as Child View Controller
            
            addChildViewController(viewController)
            
            // Add Child View as Subview
            ChildView.addSubview(viewController.view)
            
            // Configure Child View
            viewController.view.frame = ChildView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Notify Child View Controller
            viewController.didMove(toParentViewController: self)
            
            
        default:
            
            lbl_4.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            lbl_4.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PublicInfoViewController") as! PublicInfoViewController
            
            // Add View Controller as Child View Controller
            // Add View Controller as Child View Controller
            
            addChildViewController(viewController)
            
            // Add Child View as Subview
            ChildView.addSubview(viewController.view)
            
            // Configure Child View
            viewController.view.frame = ChildView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Notify Child View Controller
            viewController.didMove(toParentViewController: self)
        }
        
    }
    
    func RegisterUser()  {
        
        

        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)

                    
                    let url1 = "http://rotsys.com/api/apis/Register?"
        
                    
                    let params = NSDictionary.init(dictionary: RegisterData)
                    
                    // self.stopAnimating()
                    Alamofire.upload(
                        multipartFormData: { multipartFormData in
                          
                            
                            if backGroundImage != nil{
                                multipartFormData.append(UIImageJPEGRepresentation(backGroundImage , 0.2)! , withName: "cover_image", fileName: "image1.jpeg", mimeType: "image/jpeg")
                            }
                            for i in 0..<Image_arr.count - 1{
                                multipartFormData.append(UIImageJPEGRepresentation(Image_arr[i] as! UIImage , 0.2)! , withName: "work_image\(i)", fileName: "work_image\(i).jpeg", mimeType: "image/jpeg")
                            }
                                    
//                                    multipartFormData.append(UIImageJPEGRepresentation(self.UploadCardImageArray[0] as! UIImage , 0.2)! , withName: "img1", fileName: "image1", mimeType: "image/jpeg")
                            
                            
                            
                            for  (key, value)in params
                            {
                                
                                var val : String = ""
                                if value is String{
                                
                                 val = value as! String
                                }
                                else{
                                    
                                    if let objectData = try? JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions(rawValue: 0)) {
                                        let objectString = String(data: objectData, encoding: .utf8)
                                        val = objectString!
                                    }
                                }
                                multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key as! String)
                                print("*******  \(key) : \(value)")
                                //print("******* value = \(value)")
                            }
                       
                            print( params)
                            
                    },
                        to: url1 ,
                        encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    //print(response)
                                    debugPrint(response)
                                    
                                    self.stopAnimating()
                                    
                                    self.stopAnimating()
                                    if response.result.isSuccess
                                    {
                                        
                                        let JSON = response.result.value as! NSDictionary
                                        print("JSON: \(JSON)")
                                        
                                        if JSON.value(forKey: "response") as! String == "1"{
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                                            self.present(vc, animated: true, completion: nil)
                                        }
                                        else{
                                            dataModel.ToastAlertController(Message: JSON.value(forKey: "mesg") as! String, alertMsg: "")
                                        }
                                        
                                       
                                    }
                                }
                            case .failure(let encodingError):
                                //print(encodingError)
                                self.stopAnimating()
                            }
                    })
        
        
        }
    
    
    
    
    
    @IBAction func Back(_ sender: Any) {
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
