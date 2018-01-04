//
//  ID'sViewController.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Alamofire

var Register_ids : NSMutableDictionary! = [:]
var Register_Schedule_Time : NSMutableArray = []
var isProofImageUploaded : Bool = false

class ID_sViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    @IBOutlet weak var lblloading: CustomLabel_Light!
    let picker = UIImagePickerController()
    @IBOutlet weak var btnOnline: RadioButton!
    @IBOutlet weak var btnAddSchedule: SelectButton!
    @IBOutlet weak var txtIdNumber: SimpleTextField!
    @IBOutlet weak var TxtIdType: SimpleTextField!
    @IBOutlet weak var txtIssueDate: SimpleTextField!
    var pickerView = UIPickerView()
    var pickOption = ["Driving Licence", "Utility Bill", "Voter Card", "Electricity Bill", "Government ID"]

    @IBOutlet weak var btnUploadImage: SelectButton!
    @IBOutlet weak var btnSchedule: RadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddSchedule.isHidden = true

        pickerView.delegate = self
        picker.delegate = self

        self.lblloading.isHidden = true
		Register_ids.setValue("0", forKey: "work_online")
		Register_ids.setValue("0", forKey: "work_shedule")

//        txtIssueDate.inputView = UIDatePicker()
        

        TxtIdType.inputView = pickerView
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
        
        
        
        txtIssueDate.text = dateFormatter.string(from: sender.date)
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
        TxtIdType.text = pickOption[row]
    }
    @IBAction func ScheduleTime(_ sender: Any) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScheduleTimeViewController") as! ScheduleTimeViewController
        present(vc, animated: true, completion: nil)
        
 
        
    }
    @IBAction func Online(_ sender: Any) {

		if Register_ids.value(forKey: "work_online") as! String == "0"{
        btnOnline.Selected_Image = #imageLiteral(resourceName: "ic_check_service")
//        btnSchedule.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")
        btnAddSchedule.isHidden = true
        Register_ids.setValue("1", forKey: "work_online")
		}
		else{
			btnOnline.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")
			//        btnSchedule.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")
			btnAddSchedule.isHidden = true
			Register_ids.setValue("0", forKey: "work_online")
		}
//        Register_ids.setValue("0", forKey: "work_shedule")


    }
    @IBAction func Schedule(_ sender: Any) {

		if Register_ids.value(forKey: "work_shedule") as! String == "0"{

//        btnOnline.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")
        btnSchedule.Selected_Image = #imageLiteral(resourceName: "ic_check_service-1")
        
        btnAddSchedule.isHidden = false
//        Register_ids.setValue("0", forKey: "work_online")
        Register_ids.setValue("1", forKey: "work_shedule")

		}
		else{
			//        btnOnline.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")
			btnSchedule.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")

			btnAddSchedule.isHidden = true
			//        Register_ids.setValue("0", forKey: "work_online")
			Register_ids.setValue("0", forKey: "work_shedule")
		}
    }
    
    @IBAction func upload(_ sender: Any) {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtIdNumber{
            Register_ids.setValue(txtIdNumber.text!, forKey: "id_number")
        }
        else  if textField == TxtIdType{
            Register_ids.setValue(TxtIdType.text!, forKey: "id_type")

        }
        else  if textField == txtIssueDate{
            Register_ids.setValue(txtIssueDate.text!, forKey: "issue_date")

        }
        
        
    }
    func UploadImage(image : UIImage)  {
        
     
    
    
//
    
    let url1 = "http://rotsys.com/api/apis/copyidimage?"
    
    
    
    // self.stopAnimating()
    Alamofire.upload(
    multipartFormData: { multipartFormData in
    
    
        multipartFormData.append(CurrentUserID.data(using: String.Encoding.utf8)!, withName: "user_id" )
        multipartFormData.append("en".data(using: String.Encoding.utf8)!, withName: "lang" )

            multipartFormData.append(UIImageJPEGRepresentation(image , 0.2)! , withName: "id_image", fileName: "id_image.jpeg", mimeType: "image/jpeg")
    
    
  
    
    },
    to: url1 ,
    encodingCompletion: { encodingResult in
    switch encodingResult {
    case .success(let upload, _, _):
    upload.responseJSON { response in
    //print(response)
    debugPrint(response)
    
   
    if response.result.isSuccess
    {
    
    let JSON = response.result.value as! NSDictionary
    print("JSON: \(JSON)")
        
        
//        Register_ids.setValue("1", forKey: "id_image")
        if JSON.value(forKey: "response") as! String == "1"{
        self.lblloading.text = "Uploaded"
        self.lblloading.isHidden = false
            isProofImageUploaded = true
        }
        else{
            self.lblloading.isHidden = true
            isProofImageUploaded = false


        }

    
    }
        
      
        upload.uploadProgress(closure: { (Progress) in
            print("Upload Progress: \(Progress.fractionCompleted)")
            self.lblloading.isHidden = false
            self.lblloading.text = "Uploading \(Progress.fractionCompleted)"
            
        })
        

    }
        
    case .failure(let encodingError):
    print(encodingError)
    self.lblloading.isHidden = true
    isProofImageUploaded = false

    }
    })
    
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
        UploadImage(image: chosenImage)
        dismiss(animated:true, completion: nil)
    }
 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
