//
//  DocumentViewController.swift
//  RtooshProvider
//
//  Created by Apple on 11/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import NVActivityIndicatorView

class DocumentViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate , NVActivityIndicatorViewable{
    let picker = UIImagePickerController()

    @IBOutlet weak var txtIdNumber: SimpleTextField!
    @IBOutlet weak var txtIDType: SimpleTextField!
    @IBOutlet weak var txtDate: SimpleTextField!
    var pickerView = UIPickerView()
    var pickOption = ["Driving Licence", "Utility Bill", "Voter Card", "Electricity Bill", "Government ID"]

    @IBOutlet weak var btnImageUpdate: UIButton!
    @IBOutlet weak var imgDoc: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        picker.delegate = self

        txtIDType.inputView = pickerView
        
        txtIdNumber.text = CurrentUserData.value(forKey: "id_number") as? String
        txtIDType.text = CurrentUserData.value(forKey: "id_type") as? String
        txtDate.text = CurrentUserData.value(forKey: "issue_date") as? String

        imgDoc.sd_setImage(with: URL.init(string: CurrentUserData.value(forKey: "id_image") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func IssueDate(_ sender: UITextField) {
    
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        
        datePickerView.maximumDate = Date()
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)
        
        
    }
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        
        
        txtDate.text = dateFormatter.string(from: sender.date)
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
        txtIDType.text = pickOption[row]
    }
    @IBAction func BAck(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Update(_ sender: Any) {
        
        if CheckTextField.Check_text(text: txtIdNumber.text!) && CheckTextField.Check_text(text: txtIDType.text!) && CheckTextField.Check_text(text: txtDate.text!) && imgDoc.image != #imageLiteral(resourceName: "nav_barHome") {
            UploadImage(image: imgDoc.image!)
        }
        
        
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imgDoc.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    func UploadImage(image : UIImage)  {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        
        // http://rotsys.com/api/apis/updateProfile?profile_pic&cover_image&work_image&id=97&lang=en&surname&bio
        
        let url1 = "http://rotsys.com/api/apis/updateProfile?"
//        issue_date
//        id_type
//        id_number ,id_image
        let params = ["issue_date" : txtDate.text!,
                    "id_type" : txtIDType.text!,
                    "id_number" : txtIdNumber.text!,
                    "id" : CurrentUserID,
                    "lang" : "en"
                    ]
        
        // self.stopAnimating()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                
                
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
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key )
                    print("*******  \(key) : \(value)")
                    //print("******* value = \(value)")
                }
                
                print( params)
                
                multipartFormData.append(UIImageJPEGRepresentation(image , 0.2)! , withName: "id_image", fileName: "id_image.jpeg", mimeType: "image/jpeg")
                
                
                
                
        },
            to: url1 ,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        //print(response)
                        debugPrint(response)
                        self.stopAnimating()
                        
                        if response.result.isSuccess
                        {
                            
                            let JSON = response.result.value as! NSDictionary
                            print("JSON: \(JSON)")
                            
                            
                            //        Register_ids.setValue("1", forKey: "id_image")
                            if JSON.value(forKey: "response") as! String == "1"{
                                 NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
                            }
                            else{
                                
                                
                            }
                            
                            
                        }
                        
                        
                        upload.uploadProgress(closure: { (Progress) in
                            print("Upload Progress: \(Progress.fractionCompleted)")
                          
                            
                        })
                        
                        
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                    self.stopAnimating()
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
