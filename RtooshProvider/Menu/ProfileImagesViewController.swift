//
//  ProfileImagesViewController.swift
//  RtooshProvider
//
//  Created by Apple on 22/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire
import SDWebImage

class ProfileImagesViewController: UIViewController , NVActivityIndicatorViewable , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let picker = UIImagePickerController()

    let collectionImages : NSMutableArray = []

    let collectionImagesSelected : NSMutableArray = []
    let collectionImagesRemove : NSMutableArray = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self

        
        for i in CurrentUserProviderImages{
            let dict = i as! NSDictionary
            let temp = [
                "image" : dict.value(forKey: "image") as! String,
                "id" : dict.value(forKey: "id") as! String

            ]
            collectionImages.add(temp)
        }





        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func update(_ sender: Any) {
        uploadImages() 
    }
    @IBAction func RemoveSelected(_ sender: Any) {
        
        collectionImagesRemove.removeAllObjects()
        for i in collectionImagesSelected{

			print(collectionImagesSelected.count)
			print(collectionImages.count)


			let dict = collectionImages[i as! Int] as! NSDictionary
            
            if dict.value(forKey: "id") as! String == "0"{
				collectionImages.removeObject(at: i as! Int)
            }
            else{
                collectionImagesRemove.add(dict.value(forKey: "id") as! String)
				collectionImages.removeObject(at: i as! Int)
            }
            
        }
		if collectionImagesRemove.count != 0 {

				Remove()

		}
		else{
			if collectionImagesSelected.count != 0{
				collectionImagesSelected.removeAllObjects()
				collectionView.reloadData()
			}
		}

        

    }
    @IBAction func AddPhotos(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
//        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func Remove()  {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
//        id=249&lang=en&remove_images[1]=85&remove_images[0]=88
        
        let Dict : NSMutableDictionary = ["id" : CurrentUserID,  "lang" : "en"]
        
        for i in 0..<collectionImagesRemove.count{
            Dict.setValue(collectionImagesRemove[i], forKey: "remove_images[\(i)]")
        }
        
        print(Dict)
        
        dataModel.PostApi(Url: "apis/updateProfile?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
					self.collectionImagesSelected.removeAllObjects()
					self.collectionView.reloadData()
                  NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }
    
    func uploadImages()  {
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)

        
        
        
        // http://rotsys.com/api/apis/updateProfile?profile_pic&cover_image&work_image&id=97&lang=en&surname&bio
        
        let url1 = "http://rotsys.com/api/apis/updateProfile?"
        //        issue_date
        //        id_type
        //        id_number ,id_image
        let params = [
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
                
                var x = 0
                for i in 0..<self.collectionImages.count{
                    let dict = self.collectionImages[i] as! NSDictionary
                    if dict.value(forKey: "id") as! String == "0"{
                        print(dict)
                    let img = dict.value(forKey: "image") as! UIImage
                    multipartFormData.append(UIImageJPEGRepresentation(img , 0.2)! , withName: "work_image[\(x)]", fileName: "\(NSDate().timeIntervalSince1970 * 1000)work_image[\(x)].jpeg", mimeType: "image/jpeg")
                        x = x + 1

                    }
                }
                
                
                
                
                
                
                
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
							self.collectionImagesSelected.removeAllObjects()
							self.collectionView.reloadData()
                            
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath)

        let img_user = cell.viewWithTag(1) as! UIImageView
        let img_select = cell.viewWithTag(2) as! UIImageView

        let dict = collectionImages[indexPath.row] as! NSDictionary
        
        if dict.value(forKey: "image") is UIImage{
        
        img_user.image =  dict.value(forKey: "image") as? UIImage
        
        }
        else{
            img_user.sd_setImage(with: URL.init(string: dict.value(forKey: "image") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))
			print(dict.value(forKey: "image") as! String)
        }
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        if collectionImagesSelected.contains(indexPath.row){
            img_select.image = #imageLiteral(resourceName: "selection")
        }
        else{
            img_select.image = nil

        }
        
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (view.frame.size.width - 50)/3, height: (view.frame.size.width - 50)/3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionImagesSelected.contains(indexPath.row){
            collectionImagesSelected.remove(indexPath.row)
            collectionView.reloadData()
            return
        }
        
        collectionImagesSelected.add(indexPath.row)
        collectionView.reloadData()

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
//        collectionImages.add(chosenImage)
        let temp = [
            "image" : chosenImage,
            "id" : "0"
            
            ] as [String : Any]
        collectionImages.add(temp)
        
        
        collectionView.reloadData()
        
        
        
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
