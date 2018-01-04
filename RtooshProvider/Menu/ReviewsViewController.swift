//
//  ReviewsViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class ReviewsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , NVActivityIndicatorViewable{

    @IBOutlet weak var tableView: UITableView!
    
    
    var CollectionReview : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        GetReviews()
        // Do any additional setup after loading the view.
    }
    @IBAction func BAck(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        self.present(vc , animated: true, completion: nil)
    }
    func GetReviews()  {
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["provider_id" : CurrentUserID ,"lang": "en"]
        print(Dict)
        //          http://rotsys.com/api/apis/fetchReview?lang=en&provider_id=236
        dataModel.PostApi(Url: "apis/fetchReview?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    self.CollectionReview = NSMutableArray.init(array: Data.value(forKey: "data") as! NSArray)
                    self.tableView.reloadData()
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CollectionReview.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RatingTableViewCell
        let dict_e = CollectionReview[indexPath.row] as! NSDictionary
        
        let dict = dict_e.value(forKey: "Review") as! NSDictionary
        
        
        if dict.value(forKey: "rating_arrival") as? String == ""{
            cell.viewAT.rating = 0
        }
        else{
            cell.viewAT.rating = Double((dict.value(forKey: "rating_arrival") as? String) ?? "0")!
        }
        
        cell.viewCF.isHidden = true
        
        if dict.value(forKey: "rating_clean") as? String == ""{
            cell.viewLOC.rating = 0
        }
        else{
            cell.viewLOC.rating = Double((dict.value(forKey: "rating_clean") as? String) ?? "0")!
        }
        if dict.value(forKey: "rating_quality") as? String == ""{
            cell.viewQOS.rating = 0
        }
        else{
            cell.viewQOS.rating = Double((dict.value(forKey: "rating_quality") as? String) ?? "0")!
        }
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        let dat = dateFormatter.date(from: dict.value(forKey: "modified") as! String)!
        dateFormatter.dateFormat = "dd MMM"
        //        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: dat)

        cell.lblDate.text = dateString
        cell.lblFeedback.text = dict.value(forKey: "message") as? String
        cell.selectionStyle = .none
        return cell
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
