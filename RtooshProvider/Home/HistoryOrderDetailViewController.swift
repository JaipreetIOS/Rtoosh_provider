//
//  HistoryOrderDetailViewController.swift
//  RtooshProvider
//
//  Created by Apple on 20/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import MessageUI

class HistoryOrderDetailViewController: UIViewController , MFMessageComposeViewControllerDelegate , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var lblNumberOfPerson: CustomLabel_Light!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lblTimeAndDate: CustomLabel_Light!
    @IBOutlet weak var lblStatus: CustomLabel_Light!
    @IBOutlet weak var lblPersons: CustomLabel_Medium!
    @IBOutlet weak var lblClientName: CustomLabel_bold!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblOrderTotalTime: CustomLabel_Medium!
    @IBOutlet weak var btnSma: UIButton!
    
    @IBOutlet weak var lblOrderNumber: CustomLabel_Light!
    @IBOutlet weak var lblTotalPrice: CustomLabel_bold!
    
    var CollectionData : NSMutableDictionary!
    var CollectionOrderItem : NSMutableArray = []
    var order_id : String = ""

    
    @IBOutlet weak var c_detail_h: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSma.layer.cornerRadius = 2
        btnSma.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSma.layer.borderWidth = 1
        btnCall.layer.cornerRadius = 2
        btnCall.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnCall.layer.borderWidth = 1


		btnCall.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		btnCall.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.8)
		btnCall.layer.shadowOpacity = 1.0
		btnCall.layer.shadowRadius = 4
		btnCall.layer.masksToBounds = false
		btnCall.layer.cornerRadius = 4.0

		btnSma.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		btnSma.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.8)
		btnSma.layer.shadowOpacity = 1.0
		btnSma.layer.shadowRadius = 4
		btnSma.layer.masksToBounds = false
		btnSma.layer.cornerRadius = 4.0
        
        CollectionOrderItem = NSMutableArray.init(array:   CollectionData.value(forKey: "OrderItem") as! NSArray)
        
        let Dict_order = CollectionData.value(forKey: "Order") as! NSDictionary
        let dict_client = CollectionData.value(forKey: "client") as! NSDictionary

        var date : String = ""
        
        if Dict_order.value(forKey: "order_type") as? String == "1"{
            date = Dict_order.value(forKey: "created") as! String
            
            
            
        }
        else if Dict_order.value(forKey: "order_type") as? String == "2"{
            date = Dict_order.value(forKey: "schedule_date") as! String
            
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        let TIME = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "HH:mm EE dd MMM"
        let TimeString = dateFormatter.string(from: TIME)
        lblTimeAndDate.text = TimeString

		let dateFormatter1 = DateFormatter()

		dateFormatter1.dateFormat =  "yyyy-MM-dd HH:mm:ss"



        var person : Int = 0
        
        for i in CollectionOrderItem{
            let dict_i = i as! NSDictionary
            person = person + Int(dict_i.value(forKey: "no_of_person") as! String)!
        }
        
        lblNumberOfPerson.text = "\(person)"
        
        if Dict_order.value(forKey: "status") as? String == "2"{
            
            lblStatus.text = ""

			let JobTime = dateFormatter1.date(from: date)!
			let Servertime = dateFormatter1.date(from: Service_Time)!

			let interval =  JobTime.timeIntervalSince(Servertime)
			lblStatus.text = String(timeString(time: TimeInterval(interval)))

            
        }
        else if Dict_order.value(forKey: "status") as? String == "5" || Dict_order.value(forKey: "status") as? String == "8"{
            lblStatus.text = "Completed"
        }
        
        lblOrderNumber.text = Dict_order.value(forKey: "id") as? String
        
        
        lblClientName.text = dict_client.value(forKey: "full_name") as? String
        
        lblPersons.text = "\(person) Persons"
        
        
        
        var Persons : Int = 0
        var time : Int = 0
        
        for i in CollectionOrderItem {
            let dict_i = i as! NSDictionary
            let person_i = Int(dict_i.value(forKey: "no_of_person") as! String)
            Persons = Persons + person_i!
            
            var duration_i = dict_i.value(forKey: "duration") as! String
            duration_i = duration_i.replacingOccurrences(of: " ", with: "")
            let Duration_arr = duration_i.components(separatedBy: ":")
            let hours = Int(Duration_arr[0] )
            let mints = Int(Duration_arr[1] )
            time = (hours! * 60 + mints!) + time
            
            
            
        }
        self.lblOrderTotalTime.text = "\(time/60) hrs \(time%60) min"
        
        

		var comm : CGFloat = 0.0
//		let Dict_order = DataCollection.value(forKey: "Order") as! NSDictionary
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

//		self.lblTotalAmount.text = "\(pr) SAR"

		self.lblTotalPrice.text = "\(pr - comm) SAR"




        tableView.register(UINib.init(nibName: "OrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
	func timeString(time:TimeInterval) -> String {
		let day = Int(time) / 86400

		let hours = (Int(time) % 86400) / 3600
		let minutes = Int(time) / 60 % 60
		let seconds = Int(time) % 60
		return    "\(day)days \(hours)hrs \(minutes)mins"

	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Call(_ sender: Any) {
        let data_Client  = CollectionData.value(forKey: "client") as! NSDictionary

		var number = data_Client.value(forKey: "phone") as! String

		if number.characters.first != "0"{
			number = "0" + number
		}

        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    @IBAction func SMS(_ sender: Any) {
        let data_Client  = CollectionData.value(forKey: "client") as! NSDictionary
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [data_Client.value(forKey: "phone") as! String]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
        
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
        c_detail_h.constant = 114 + tableView.contentSize.height
        
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailTableViewCell
        cell.selectionStyle = .none

        if indexPath.row == CollectionOrderItem.count  {
            cell.namr.text = "Service commission"
            var comm : CGFloat = 0.0
            let Dict_order = CollectionData.value(forKey: "Order") as! NSDictionary
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
        cell.cost.text = "= \(pr * cost) SAR"
        }
        
        
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
