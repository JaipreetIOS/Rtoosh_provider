//
//  PaymentDetailViewController.swift
//  RtooshProvider
//
//  Created by Apple on 04/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Cosmos
import NVActivityIndicatorView

class PaymentDetailViewController: UIViewController , UITableViewDataSource , UITableViewDelegate, NVActivityIndicatorViewable{

    @IBOutlet weak var lblTotalAmount: CustomLabel_bold!
    @IBOutlet weak var lblClientName: CustomLabel_bold!
    @IBOutlet weak var lblTotal: CustomLabel_bold!
    @IBOutlet weak var txtNumberOfService: SimpleTextField!
    @IBOutlet weak var txtPaid: SimpleTextField!
    @IBOutlet weak var txtNote: IQTextView!
    @IBOutlet weak var ViewRating: CosmosView!
    @IBOutlet weak var txtFeedback: IQTextView!
    @IBOutlet weak var ViewRate: UIView!
    @IBOutlet weak var viewAdditionalService: UIView!
    @IBOutlet weak var c_detal_h: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNo: CustomButton_Light!
    @IBOutlet weak var btnYes: CustomButton_Light!
    var isSelectYes : String = ""
    
    var DataCollection : NSMutableDictionary!
    var CollectionOrderItem : NSMutableArray = []
    var order_id : String = ""
	var ViewFor : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewAdditionalService.layer.shadowColor = UIColor.black.cgColor
        viewAdditionalService.layer.shadowOpacity = 1
        viewAdditionalService.layer.shadowRadius = 8
        viewAdditionalService.layer.shadowOffset = CGSize.zero
        
        
        ViewRate.layer.shadowColor = UIColor.black.cgColor
        ViewRate.layer.shadowOpacity = 1
        ViewRate.layer.shadowRadius = 8
        ViewRate.layer.shadowOffset = CGSize.zero
        
        txtFeedback.layer.cornerRadius = 4
        txtFeedback.layer.masksToBounds = true
        txtNote.layer.cornerRadius = 4
        txtNote.layer.masksToBounds = true
        
        btnYes.layer.masksToBounds = true
        btnYes.layer.cornerRadius = 8
        btnYes.layer.shadowColor = UIColor.lightText.cgColor
        btnYes.layer.shadowOpacity = 1
        btnYes.layer.shadowRadius = 8
        btnYes.layer.shadowOffset = CGSize.zero
        btnNo.layer.masksToBounds = true
        
        btnYes.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnYes.layer.borderWidth = 0
        
        btnNo.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnNo.layer.borderWidth = 1
        btnNo.layer.cornerRadius = 8
        btnNo.layer.shadowColor = UIColor.lightText.cgColor
        btnNo.layer.shadowOpacity = 1
        btnNo.layer.shadowRadius = 8
        btnNo.layer.shadowOffset = CGSize.zero
        tableView.register(UINib.init(nibName: "OrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        let OrderTtem_dict = DataCollection.value(forKey: "OrderItem") as! NSArray
        self.CollectionOrderItem = NSMutableArray.init(array: OrderTtem_dict)
        
        tableView.reloadData()
        
//        let OrderData_dict = DataCollection.value(forKey: "Order") as! NSDictionary


		var comm : CGFloat = 0.0
		let Dict_order = DataCollection.value(forKey: "Order") as! NSDictionary
		//			let commission = CGFloat(Dict_order.value(forKey: "commission") as! String)


		var pr : CGFloat = 0.0

		var commission : CGFloat = 0.0
		if let n = NumberFormatter().number(from: String(describing: Dict_order.value(forKey: "commission") as! String)) {
			commission = CGFloat(n)

		}

		//
		for i in CollectionOrderItem{
			let dict = i as! NSDictionary
			var pr_x : CGFloat = 0.0
			if let n = NumberFormatter().number(from: String(describing: dict.value(forKey: "no_of_person") as! String)) {
				pr_x = CGFloat(n)

			}
			var cost : CGFloat = 0.0
			if let n = NumberFormatter().number(from: String(describing: dict.value(forKey: "price") as! String)) {
				cost = CGFloat(n)

			}

			let tot = pr_x * cost

			pr = pr + tot

		}


		comm = (commission * pr)/100

		self.lblTotalAmount.text = "\(pr) SAR"

        self.lblTotal.text = "\(pr - comm) SAR"
        
        let data_Client  = DataCollection.value(forKey: "client") as! NSDictionary

        self.lblClientName.text = "\(data_Client.value(forKey: "full_name") as! String)"
		btnYes.setBackgroundImage(nil, for: .normal)
		btnNo.setBackgroundImage(nil, for: .normal)



		btnYes.setImage(#imageLiteral(resourceName: "ic_check_pink"), for: .normal)
		btnNo.setImage(#imageLiteral(resourceName: "ic_check_pink"), for: .normal)

		btnYes.setTitleColor(#colorLiteral(red: 0.9350000024, green: 0.3659999967, blue: 0.4930000007, alpha: 1), for: .normal)
		btnNo.setTitleColor(#colorLiteral(red: 0.9350000024, green: 0.3659999967, blue: 0.4930000007, alpha: 1), for: .normal)

		btnYes.layer.borderWidth = 1
		btnNo.layer.borderWidth = 1

		if Dict_order.value(forKey: "status") as! String == "5"{
			BgButton.isHidden = false
			ViewRate.isHidden = true
			viewAdditionalService.isHidden = false

		}
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CollectionOrderItem.count != 0{
            
            return CollectionOrderItem.count + 1
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        c_detal_h.constant = 320 + tableView.contentSize.height
        
        
//        c_map_h.constant =  ScrollView.frame.size.height - (c_detail_h.constant + 140)
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailTableViewCell
        
        cell.selectionStyle = .none

		if indexPath.row == CollectionOrderItem.count {
			cell.namr.text = "Service commission"
			var comm : CGFloat = 0.0
			let Dict_order = DataCollection.value(forKey: "Order") as! NSDictionary
			//			let commission = CGFloat(Dict_order.value(forKey: "commission") as! String)


			var pr : CGFloat = 0.0

			var commission : CGFloat = 0.0
			if let n = NumberFormatter().number(from: String(describing: Dict_order.value(forKey: "commission") as! String)) {
				commission = CGFloat(n)

			}
			cell.count.text = "\(commission)%"

			//
			for i in CollectionOrderItem{
				let dict = i as! NSDictionary
				var pr_x : CGFloat = 0.0
				if let n = NumberFormatter().number(from: String(describing: dict.value(forKey: "no_of_person") as! String)) {
					pr_x = CGFloat(n)

				}
				var cost : CGFloat = 0.0
				if let n = NumberFormatter().number(from: String(describing: dict.value(forKey: "price") as! String)) {
					cost = CGFloat(n)

				}

				let tot = pr_x * cost

				pr = pr + tot

			}


			comm = (commission * pr)/100

			cell.cost.text = "= \(comm) SAR"
		}
        else{
        
        let dict = CollectionOrderItem[indexPath.row] as! NSDictionary
        cell.namr.text = dict.value(forKey: "service_name") as? String
        cell.count.text = "\(dict.value(forKey: "no_of_person") as! String) x \(dict.value(forKey: "price") as! String)"
        var pr : CGFloat = 0.0
        if let n = NumberFormatter().number(from: String(describing: dict.value(forKey: "no_of_person") as! String)) {
            pr = CGFloat(n)
            
        }
        var cost : CGFloat = 0.0
        if let n = NumberFormatter().number(from: String(describing: dict.value(forKey: "price") as! String)) {
            cost = CGFloat(n)
            
        }
        cell.cost.text = "\(pr * cost) SAR"

        }
            return cell
    }
    
    @IBAction func Done(_ sender: Any) {
        if isSelectYes == "true"{
            BgButton.isHidden = false
            ViewRate.isHidden = true
            viewAdditionalService.isHidden = false
        }
        else if isSelectYes == "false"{
            BgButton.isHidden = false
            ViewRate.isHidden = false
            viewAdditionalService.isHidden = true
        }
    }
    @IBAction func ButtonBG(_ sender: Any) {


		if ViewRate.isHidden == false{

		}
		else{
        BgButton.isHidden = true
        ViewRate.isHidden = true
        viewAdditionalService.isHidden = true
		}
    }
    @IBOutlet weak var BgButton: UIButton!
    @IBAction func YES(_ sender: Any) {
        btnYes.setBackgroundImage(#imageLiteral(resourceName: "nav_barHome"), for: .normal)
        btnNo.setBackgroundImage(nil, for: .normal)
//        btnYes.layer.masksToBounds = false
//        btnNo.layer.masksToBounds = true
        btnYes.setImage(#imageLiteral(resourceName: "ic_check_white"), for: .normal)
        btnNo.setImage(#imageLiteral(resourceName: "ic_check_pink"), for: .normal)
        
        btnYes.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnNo.setTitleColor(#colorLiteral(red: 0.9350000024, green: 0.3659999967, blue: 0.4930000007, alpha: 1), for: .normal)

        btnYes.layer.borderWidth = 0
        btnNo.layer.borderWidth = 1

        isSelectYes = "true"
    }
    
    @IBAction func NO(_ sender: Any) {
        btnNo.setBackgroundImage(#imageLiteral(resourceName: "nav_barHome"), for: .normal)
        btnYes.setBackgroundImage(nil, for: .normal)
        btnNo.setImage(#imageLiteral(resourceName: "ic_check_white"), for: .normal)
        btnYes.setImage(#imageLiteral(resourceName: "ic_check_pink"), for: .normal)
        
        btnNo.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnYes.setTitleColor(#colorLiteral(red: 0.9350000024, green: 0.3659999967, blue: 0.4930000007, alpha: 1), for: .normal)

//        btnNo.layer.masksToBounds = false
//        btnYes.layer.masksToBounds = true

        
        btnNo.layer.borderWidth = 0
        btnYes.layer.borderWidth = 1
        
        isSelectYes = "false"
    }
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func SaveRating(_ sender: Any) {
//        if CheckTextField.Check_text(text: txtFeedback.text!) {
            SendRating()
//        }

        
    }
    @IBAction func SaveAdditional(_ sender: Any) {
        
        if CheckTextField.Check_text(text: txtNote.text!) && CheckTextField.Check_text(text: txtPaid.text!) && CheckTextField.Check_text(text: txtNumberOfService.text!){
            SaveAdd()
        }
        
    }
    func SaveAdd()  {
        //      apis/addionalser?order_id=2&number_of_services=3&total_paid_amount=200&note=testnote&lang=en
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["order_id" : order_id,
                    "number_of_services" : txtNumberOfService.text!,
                    "total_paid_amount" : txtPaid.text!,
                    "note" : txtNote.text!,
                    "lang" : "en" ]
        print(Dict)
        
        dataModel.PostApi(Url: "apis/addionalser", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
					self.BgButton.isHidden = false
					self.ViewRate.isHidden = false
					self.viewAdditionalService.isHidden = true
					//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
//                    self.present(vc, animated: true, completion: nil)

                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
    }
        func SendRating()  {
            //      http://rotsys.com/api/apis/addFeedback?provider_id=32&user_id=31&rating=4&comment=gfgdfsgdfsg&lang=en
            let data_Client  = DataCollection.value(forKey: "client") as! NSDictionary

            self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
            
            let Dict = ["provider_id" : CurrentUserID,
                        "user_id" : data_Client.value(forKey: "id") as! String,
                        "rating" : ViewRating.rating,
                        "comment" : txtFeedback.text!,
                        "request_id" : order_id,
                        "lang" : "en" ] as [String : Any]
            print(Dict)
            
            dataModel.PostApi(Url: "apis/addFeedback", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
                self.stopAnimating()
                
                if error == "Error"{
                    dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                    
                }
                else{
                    if Data.value(forKey: "response") as! String == "1"{
                        self.BgButton.isHidden = true
                        self.ViewRate.isHidden = true
                        self.viewAdditionalService.isHidden = true
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
                        self.present(vc, animated: true, completion: nil)
                    }
                    else{
                        dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                        
                    }
                }
            })
            
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
