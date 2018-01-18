//
//  ViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , NVActivityIndicatorViewable{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var view3: UIView!
	@IBOutlet weak var btnSkip: CustomButton_Light!

    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var view1: UIView!

	@IBOutlet weak var btnNext: SelectButton!
	var imag_arr : NSArray = [#imageLiteral(resourceName: "event_collection") ,#imageLiteral(resourceName: "connect_follow"), #imageLiteral(resourceName: "book_now")]
    var imag_Title : NSArray = ["E V E N T S  C O L L E C T I O N", "C N N E C T  & F O L L O W" , "B O O K   &  S H A R E"]
    var imag_Detail : NSArray = ["Discover the best things to do this week in your city", "Connect with your friends, follow tastemakers and people who share your interests", "Book events so easy in two step and share it with your friends."]

    override func viewDidLoad() {
        super.viewDidLoad()
		btnNext.setTitle("Next", for: .normal)

        btnSkip.layer.cornerRadius = 15
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(NotificationUserOnline), object: nil)

		if UserDefaults.standard.value(forKey: "CurrentUserData") is NSDictionary
		{


   self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
		}
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func methodOfReceivedNotification(notification: Notification){
        
        self.stopAnimating()
        let vc =  storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        present(vc, animated: true, completion: nil)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath)
        
        
        let view1 = cell.viewWithTag(1)
        let view2 = cell.viewWithTag(2)
        let view3 = cell.viewWithTag(3)


		if indexPath.row == 0{
			view1?.isHidden = false
			view2?.isHidden = true
			view3?.isHidden = true

		}
		else 	if indexPath.row == 1{
			view1?.isHidden = true
			view2?.isHidden = false
			view3?.isHidden = true


		} else{
			view1?.isHidden = true
			view2?.isHidden = true
			view3?.isHidden = false


		}


        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
  
        
//        c_page_leading.constant = CGFloat(indexPath.row * 73)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        switch visibleIndexPath.row {
        case 0:
            view1.backgroundColor = #colorLiteral(red: 0.7502288222, green: 0.2968788147, blue: 0.191162765, alpha: 1)
            View2.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            view3.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            btnNext.setTitle("Next", for: .normal)
            
            
        case 1:
            view1.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            View2.backgroundColor = #colorLiteral(red: 0.7502288222, green: 0.2968788147, blue: 0.191162765, alpha: 1)
            view3.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
			btnNext.setTitle("Next", for: .normal)

            
        default:
            view1.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            View2.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            view3.backgroundColor = #colorLiteral(red: 0.7502288222, green: 0.2968788147, blue: 0.191162765, alpha: 1)
			btnNext.setTitle("Register Now", for: .normal)

            
        }
    }

    @IBAction func Skip(_ sender: Any) {
        
        let vc =  storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(vc, animated: true, completion: nil)
        
        
    }
	@IBAction func NEXT(_ sender: Any) {

		var visibleRect = CGRect()

		visibleRect.origin = collectionView.contentOffset
		visibleRect.size = collectionView.bounds.size

		let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

		let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!

		switch visibleIndexPath.row {
		case 0:
			collectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .right, animated: true)


		case 1:
			collectionView.scrollToItem(at: IndexPath.init(row: 2, section: 0), at: .right, animated: true)



		default:

			let vc =  storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
			present(vc, animated: true, completion: nil)

		}

	}
}

