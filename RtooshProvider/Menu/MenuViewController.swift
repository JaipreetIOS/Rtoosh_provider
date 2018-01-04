
//
//  MenuViewController.swift
//  Kishk
//
//  Created by OSX on 13/02/17.
//  Copyright © 2017 OSX. All rights reserved.
//

import UIKit

var G_DataSubCat : NSArray = []
var G_selectedCat : NSDictionary!
var G_IsMenu : Bool = false




class MenuViewController: UIViewController    {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblLogin: UILabel!
    
    var isTableViewOpen : Bool = false
    
//    var DataCategories : NSArray = []

    
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//     img.layer.cornerRadius = 16
        
        img.sd_setImage(with: URL.init(string: CurrentUserData.value(forKey: "profile_pic") as! String), placeholderImage: #imageLiteral(resourceName: "logo"))
        lblLogin.text = CurrentUserData.value(forKey: "full_name") as? String
           NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(NotificationUserDataUpdated), object: nil)
    }
    @objc func methodOfReceivedNotification(notification: Notification){
        
        
        img.sd_setImage(with: URL.init(string: CurrentUserData.value(forKey: "profile_pic") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))
        lblLogin.text = CurrentUserData.value(forKey: "full_name") as? String
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.bool(forKey: "isLogged_Consumber") == false{
//            lblLogin.text = "LOGIN"
//        }
//        else{
        
//        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ProFile(_ sender: Any) {
        
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                    var destViewController : UIViewController
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier:"ProfileViewController") as! ProfileViewController
        
                    sideMenuController()?.setContentViewController(destViewController)
        //            navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func Wallet(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"WalletViewController") as! WalletViewController
        
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    @IBAction func History(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"HistoryViewController") as! HistoryViewController
        
        sideMenuController()?.setContentViewController(destViewController)
    }
    @IBAction func Reviews(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"ReviewsViewController") as! ReviewsViewController
        
        sideMenuController()?.setContentViewController(destViewController)
        
    }
    @IBAction func Report(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"ReportViewController") as! ReportViewController
        
        sideMenuController()?.setContentViewController(destViewController)
    }
    @IBAction func Calender(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"CalenderViewController") as! CalenderViewController
        
        sideMenuController()?.setContentViewController(destViewController)
    }
    @IBAction func Setting(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"SettingsViewController") as! SettingsViewController
        
        sideMenuController()?.setContentViewController(destViewController)
    }
    @IBAction func ContactUs(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"ContactUsViewController") as! ContactUsViewController
        
        sideMenuController()?.setContentViewController(destViewController)
    }
    @IBAction func Logout(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: "CurrentUserData")
        UserDefaults.standard.synchronize()
        IsLocationUpdate = "0"
		CurrentUserID = ""
		CurrentUserData.removeAllObjects()
		CurrentUserServices.removeAllObjects()
		CurrentUserHours.removeAllObjects()
		CurrentUserProviderImages.removeAllObjects()


		CurrentPhoneNumber = ""



        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier:"ViewController") as! ViewController
        
        sideMenuController()?.setContentViewController(destViewController)
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
