//
//  ViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var view1: UIView!
    
    var imag_arr : NSArray = [#imageLiteral(resourceName: "event_collection") ,#imageLiteral(resourceName: "connect_follow"), #imageLiteral(resourceName: "book_now")]
    var imag_Title : NSArray = ["E V E N T S  C O L L E C T I O N", "C N N E C T  & F O L L O W" , "B O O K   &  S H A R E"]
    var imag_Detail : NSArray = ["Discover the best things to do this week in your city", "Connect with your friends, follow tastemakers and people who share your interests", "Book events so easy in two step and share it with your friends."]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        
        let img = cell.viewWithTag(1) as! UIImageView
        let title = cell.viewWithTag(2) as! UILabel
        let detail = cell.viewWithTag(3) as! UILabel
        
        img.image = imag_arr[indexPath.row] as? UIImage
        title.text = imag_Title[indexPath.row] as? String
        detail.text = imag_Detail[indexPath.row] as? String

        
        
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
        
        print(visibleIndexPath)
        switch visibleIndexPath.row {
        case 0:
            view1.backgroundColor = #colorLiteral(red: 0.7502288222, green: 0.2968788147, blue: 0.191162765, alpha: 1)
            View2.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            view3.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            
            
            
        case 1:
            view1.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            View2.backgroundColor = #colorLiteral(red: 0.7502288222, green: 0.2968788147, blue: 0.191162765, alpha: 1)
            view3.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            
        default:
            view1.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            View2.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            view3.backgroundColor = #colorLiteral(red: 0.7502288222, green: 0.2968788147, blue: 0.191162765, alpha: 1)
            
        }
    }

    @IBAction func Skip(_ sender: Any) {
        
        let vc =  storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(vc, animated: true, completion: nil)
        
        
    }
}

