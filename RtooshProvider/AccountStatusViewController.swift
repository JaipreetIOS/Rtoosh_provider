//
//  AccountStatusViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class AccountStatusViewController: UIViewController {

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
        switch sender.tag {
        case 0:
            // Instantiate View Controller
            sender.tag = 1
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
            sender.tag = 2

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
            sender.tag = 3
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

            sender.setTitle("Save", for: .normal)
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
