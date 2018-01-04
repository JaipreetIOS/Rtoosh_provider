//
//  PublicInfoViewController.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

var Register_PublicInfo : NSMutableDictionary = [:]
var Image_arr : NSMutableArray  = [#imageLiteral(resourceName: "ic_add")]
var backGroundImage : UIImage!


class PublicInfoViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate , UITextViewDelegate , UIGestureRecognizerDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let picker = UIImagePickerController()
    
    
    
    var isBackgroundImage : Bool = false
    var tapGesture = UITapGestureRecognizer()
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var TxtBio: IQTextView!
    @IBOutlet weak var txtSurName: SimpleTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSurName.layer.cornerRadius = 8
        imgBackground.layer.cornerRadius = 8
        imgBackground.layer.masksToBounds = true

        txtSurName.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        txtSurName.layer.borderWidth = 1
        txtSurName.clipsToBounds = true
        
        TxtBio.layer.cornerRadius = 8
        TxtBio.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        TxtBio.layer.borderWidth = 1
        TxtBio.layer.masksToBounds = true
        
        picker.delegate = self

            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.myviewTapped(_:)))
        tapGesture.delegate = self
        imgBackground.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        // handling code
      
    }
    @IBAction func uploadBgImage(_ sender: Any) {
        
        isBackgroundImage = true
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Image_arr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath)
        
        cell.layer.cornerRadius = 8
        
        let img_bg = cell.viewWithTag(1) as! UIImageView
        img_bg.image = Image_arr[indexPath.row] as? UIImage
        
        let img_add = cell.viewWithTag(2) as! UIImageView
        img_add.isHidden = true
        if indexPath.row == Image_arr.count - 1{
            img_add.isHidden = false
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize.init(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == Image_arr.count - 1{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(picker, animated: true, completion: nil)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSize.init(width: 80, height: 80)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtSurName{
            Register_PublicInfo.setValue(txtSurName.text!, forKey: "surname")
        }
        else  if textField == TxtBio{
            
        }
   
        
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        Register_PublicInfo.setValue(TxtBio.text!, forKey: "bio")

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2

        
        if isBackgroundImage == true
        {
            imgBackground.image = chosenImage
            backGroundImage = chosenImage
        }
        else{
            Image_arr.insert(chosenImage, at: 0)
            collectionView.reloadData()
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
