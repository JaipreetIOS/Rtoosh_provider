//
//  MyNavigationController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 30.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit



class MyNavigationController: ENSideMenuNavigationController, ENSideMenuDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        let menuView = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController")

          sideMenu = ENSideMenu(sourceView: self.view, menuViewController: menuView!, menuPosition:.left)
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 270.0 // optional, default is 160
        sideMenu?.bouncingEnabled = false
        sideMenu?.allowPanGesture = false
        // make navigation bar showing over side menu
        self.sideMenuController()?.sideMenu?.delegate = self

        view.bringSubview(toFront: navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
