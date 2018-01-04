//
//  ProfileViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import NVActivityIndicatorView
import Alamofire

class ProfileViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , NVActivityIndicatorViewable, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let picker = UIImagePickerController()
    var imageFor : String = ""
    @IBOutlet weak var imgProfile: CircleImageView!
    @IBOutlet weak var txtBio: IQTextView!
    @IBOutlet weak var txtCurrentPwd: UITextField!
    @IBOutlet weak var txtNewPwd: UITextField!
    @IBOutlet weak var txtConfirmPwd: UITextField!
    @IBOutlet weak var lblStatus: CustomLabel_Medium!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnprofileImag: UIButton!
    @IBOutlet weak var btnBackImage: UIButton!
    @IBOutlet weak var txtSurName: SimpleTextField!
    @IBOutlet weak var btnProfileInfo: UIButton!
    @IBOutlet weak var btnDecoment: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var lblEmail: CustomLabel_bold!
    @IBOutlet weak var lblPhone: CustomLabel_bold!
    @IBOutlet weak var lblName: CustomLabel_bold!
    @IBOutlet weak var bgButton: UIButton!
    @IBOutlet weak var viewPassword: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtBio.layer.cornerRadius = 8
        txtBio.layer.borderColor = #colorLiteral(red: 0.951546371, green: 0.9255756736, blue: 0.9337655902, alpha: 1)
        txtBio.layer.borderWidth = 1
        imgBack.layer.cornerRadius = 8
        imgBack.layer.masksToBounds = true
        picker.delegate = self

        lblName.text = CurrentUserData.value(forKey: "full_name") as? String
        lblPhone.text = CurrentUserData.value(forKey: "phone") as? String
        lblEmail.text = CurrentUserData.value(forKey: "email") as? String
        txtSurName.text = CurrentUserData.value(forKey: "surname") as? String
        txtBio.text = CurrentUserData.value(forKey: "bio") as? String
        imgBack.sd_setImage(with: URL.init(string: CurrentUserData.value(forKey: "cover_image") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))
        imgProfile.sd_setImage(with: URL.init(string: CurrentUserData.value(forKey: "profile_pic") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))
        
        let status : Int = Int((CurrentUserData.value(forKey: "status") as? String)!)!
        switch status {
        case 1:
            lblStatus.text = "Active"
        case 2:
            lblStatus.text = "Not active"
        case 3:
            lblStatus.text = "Reviewing by admin"
        case 4:
            lblStatus.text = "Suspended"
       
        default:
            lblStatus.text = ""

        }
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }

    @IBAction func Back(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        self.present(vc , animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if CurrentUserProviderImages.count == 0{
            return 1

        }
        else if CurrentUserProviderImages.count == 1{
            return 2

        }
        else{
            return 3

        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath)
        
        
        let bgImage = cell.viewWithTag(1) as! UIImageView
        let lbl = cell.viewWithTag(2) as! UILabel
        let nextImage = cell.viewWithTag(3) as! UIImageView
        lbl.isHidden = false
        nextImage.isHidden = false
        bgImage.image = #imageLiteral(resourceName: "nav_barHome")
        
        
        if CurrentUserProviderImages.count == 0{
            
            
        }
        else if CurrentUserProviderImages.count == 1{
            if indexPath.row == 0{
                let dict = CurrentUserProviderImages[indexPath.row] as! NSDictionary

                lbl.isHidden = true
                nextImage.isHidden = true
//                bgImage.sd_setImage(with: URL.init(string: dict.value(forKey: "image") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))
            }
            else {
                
            }
        }
        else{
            if indexPath.row == 0{
                let dict = CurrentUserProviderImages[indexPath.row] as! NSDictionary

                lbl.isHidden = true
                nextImage.isHidden = true
                bgImage.sd_setImage(with: URL.init(string: dict.value(forKey: "image") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))

            }
            else if indexPath.row == 1{
                let dict = CurrentUserProviderImages[indexPath.row] as! NSDictionary

                lbl.isHidden = true
                nextImage.isHidden = true
				bgImage.sd_setImage(with: URL.init(string: dict.value(forKey: "image") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))


                
            }
            else {
                
            }
         }
        

        cell.layer.cornerRadius = 8
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize.init(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if CurrentUserProviderImages.count == 0{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileImagesViewController") as! ProfileImagesViewController
            present(vc, animated: true, completion: nil)
        }
        else if CurrentUserProviderImages.count == 1{
            if indexPath.row == 0{
            }
            else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileImagesViewController") as! ProfileImagesViewController
                present(vc, animated: true, completion: nil)
                
            }
        }
        else{
            if indexPath.row == 0{
               
                
            }
            else if indexPath.row == 1{
               
                
                
            }
            else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileImagesViewController") as! ProfileImagesViewController
                present(vc, animated: true, completion: nil)
            }
        }
        
        
        
       
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSize.init(width: 100, height: 100)
    }
    
    
    @IBAction func UpdatePassword(_ sender: Any) {
   
        
        if CheckTextField.Check_Password(text: txtCurrentPwd.text!) && CheckTextField.Check_Password(text: txtNewPwd.text!){
            if txtNewPwd.text! != txtConfirmPwd.text!{
                dataModel.ToastAlertController(Message: "Password not match", alertMsg: "")
            }
            else{
                
            
            self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
            
                let Dict = ["user_id" : CurrentUserID, "oldPass" : txtCurrentPwd.text! ,"newPass": txtNewPwd.text! , "lang" : "en"]
            print(Dict)
            //           apis/updatePassword?user_id=97&oldPass=1234567&newPass=123456&lang=en
            
            dataModel.PostApi(Url: "apis/updatePassword", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
                self.stopAnimating()
                
                if error == "Error"{
                    dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                    
                }
                else{
                    if Data.value(forKey: "response") as! String == "1"{
                        dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                        self.viewPassword.isHidden = true
                        self.bgButton.isHidden = true
                    }
                    else{
                        dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                        
                    }
                }
            })
            
            }
        
        }
    }
    

    @IBAction func BGButton(_ sender: Any) {
        viewPassword.isHidden = true
            bgButton.isHidden = true
    }
    @IBAction func ChangePassword(_ sender: Any) {
        viewPassword.isHidden = false
        bgButton.isHidden = false
    }
    @IBOutlet weak var ChangeDecoment: UIButton!
    @IBAction func ChangeDocument(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func ProfileInfo(_ sender: UIButton) {
        if sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "ic_action_mode_edit"){
            sender.setBackgroundImage(#imageLiteral(resourceName: "ic_action_check_red"), for: .normal)
            txtBio.isUserInteractionEnabled = true
            txtSurName.isUserInteractionEnabled = true
            btnBackImage.isUserInteractionEnabled = true
            btnprofileImag.isUserInteractionEnabled = true
            
        }
        else{
            Update()
        }
        
    }
    @IBOutlet weak var ProfilePic: UIButton!
    @IBAction func ProfilePic(_ sender: Any) {
        picker.allowsEditing = false
        imageFor = "profile"
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)

    }
    @IBAction func BackImage(_ sender: Any) {
        picker.allowsEditing = false
        imageFor = "Back"

        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)

    }
    
    
    func Update()  {
        
        
        
        
        // http://rotsys.com/api/apis/updateProfile?profile_pic&cover_image&work_image&id=97&lang=en&surname&bio
        
        let url1 = "http://rotsys.com/api/apis/updateProfile?"
        //        issue_date
        //        id_type
        //        id_number ,id_image
        let params = ["surname" : txtSurName.text!,
                      "bio" : txtBio.text!,
                      "id" : CurrentUserID,
                      "lang" : "en"
        ]
		self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)

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
                
                multipartFormData.append(UIImageJPEGRepresentation(self.imgProfile.image! , 0.2)! , withName: "profile_pic", fileName: "profile_pic.jpeg", mimeType: "image/jpeg")
                   multipartFormData.append(UIImageJPEGRepresentation(self.imgBack.image! , 0.2)! , withName: "cover_image", fileName: "cover_image.jpeg", mimeType: "image/jpeg")
                
                
                
                
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

								self.btnProfileInfo.setBackgroundImage(#imageLiteral(resourceName: "ic_action_mode_edit"), for: .normal)
                                self.txtBio.isUserInteractionEnabled = false
                                self.txtSurName.isUserInteractionEnabled = false
								self.btnBackImage.isUserInteractionEnabled = false
								self.btnprofileImag.isUserInteractionEnabled = false
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
        if imageFor == "profile"{
            imgProfile.image = chosenImage
        }
        else{
            imgBack.image = chosenImage
        }
        
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
