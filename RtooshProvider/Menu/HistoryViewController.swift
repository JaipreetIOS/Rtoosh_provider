//
//  HistoryViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView


var Service_Time : String = ""


class HistoryViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , NVActivityIndicatorViewable{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBg: UIButton!
    @IBOutlet weak var viewDecline: UIView!
    @IBOutlet weak var txtComment: IQTextView!
    var CollectionRequets : NSMutableArray = []
    var CollectionRequets_New : NSMutableArray = []
    var CollectionRequets_Aprroved : NSMutableArray = []
    var CollectionRequets_Complete : NSMutableArray = []

	var Sec_remove : Int = 0
	var Timer_sercer = Timer()

    var Headers = ["New Requests" , "Approved Requests" , "Completed Requests"]
    
    var Headers_image = [#imageLiteral(resourceName: "ic_new_requests") , #imageLiteral(resourceName: "ic_approved_requests") , #imageLiteral(resourceName: "ic_service_like-1")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtComment.layer.cornerRadius = 4
        txtComment.layer.masksToBounds = true
        txtComment.layer.borderColor = UIColor.lightGray.cgColor
        txtComment.layer.borderWidth = 1
        
        viewDecline.layer.shadowColor = UIColor.black.cgColor
        viewDecline.layer.shadowOpacity = 1
        viewDecline.layer.shadowRadius = 8
        viewDecline.layer.shadowOffset = CGSize.zero
        
        tableView.register(UINib.init(nibName: "HistoryCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
           tableView.register(UINib.init(nibName: "HistoryNewTableViewCell", bundle: nil), forCellReuseIdentifier: "NewCell")
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
	override func viewDidAppear(_ animated: Bool) {
		GetRequests()
	}
    
    func GetRequests()  {
        
        
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["provider_id" : CurrentUserID , "lang" : "en"]
        print(Dict)
        //           apis/
        //       apis/orderList?provider_id=80&lang=en
        
        dataModel.PostApi(Url: "apis/orderList", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                print(Data)
                if Data.value(forKey: "response") as! String == "1"{
                    Service_Time = Data.value(forKey: "server_time") as! String
                    self.CollectionRequets = NSMutableArray.init(array: Data.value(forKey: "data") as! NSArray)
                        self.CollectionRequets_New.removeAllObjects()
					self.CollectionRequets_Aprroved.removeAllObjects()
					self.CollectionRequets_Complete.removeAllObjects()

                    for i in self.CollectionRequets{
                        let dict = i as! NSDictionary
                        let dict_order = dict.value(forKey: "Order") as! NSDictionary
                        if dict_order.value(forKey: "status") as! String == "1"{
                            self.CollectionRequets_New.add(i)
                        }
                        if dict_order.value(forKey: "status") as! String == "2"{
                            self.CollectionRequets_Aprroved.add(i)
                            
                        }
                   
                        if dict_order.value(forKey: "status") as! String == "5" || dict_order.value(forKey: "status") as! String == "8"{
                            self.CollectionRequets_Complete.add(i)
                            
                        }
                        
                        
                    }
                    self.tableView.reloadData()

                    self.Timer_sercer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Waiting), userInfo: nil, repeats: true)
                    
                    
                    //                    btnNxt.setTitle("Next", for: .normal)
                }
                else{
                    //                    self.SwitchOinline.isOn = false
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
        
        
    }
	@objc func Waiting() {
		Sec_remove = Sec_remove + 1
		self.tableView.reloadData()
		//    self.tblWaiting.reloadData()
	}
    
    @IBAction func BAck(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        self.present(vc , animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view_main = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: 50))

        
        let view_header = UIView.init(frame: CGRect.init(x: 0, y: 5, width: view.frame.size.width, height: 40))
          let view_header_line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: 1))
        view_header_line.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view_header.addSubview(view_header_line)
        
         let img_logo = UIImageView.init(frame: CGRect.init(x: 8, y: 8, width: 24, height: 24))
        img_logo.image = Headers_image[section]
        view_header.addSubview(img_logo)
        
        
        let title = UILabel.init(frame: CGRect.init(x: 45, y: 12, width: 200, height: 24))
        title.font = UIFont.init(name: "AvenirLT-Medium", size: 17)
        title.text = Headers[section] as? String
        title.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view_header.addSubview(title)
        
        
        let Count = UILabel.init(frame: CGRect.init(x: view.frame.size.width - 80, y: 8, width: 24, height: 24))
        Count.font = UIFont.init(name: "AvenirLT-Medium", size: 17)
        switch section {
        case 0:
            Count.text = "\(CollectionRequets_New.count)"

        case 1:
            Count.text = "\(CollectionRequets_Aprroved.count)"


        case 2:
            Count.text = "\(CollectionRequets_Complete.count)"


            
        default:
            Count.text = "0"
        }
        
        
        Count.textAlignment = .center
        Count.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if section == 0{
            Count.backgroundColor = #colorLiteral(red: 0.9335876703, green: 0.2606739402, blue: 0.3524556756, alpha: 1)
            
        }
        else{
            Count.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        }
        
        Count.layer.cornerRadius = 12
        Count.layer.masksToBounds = true
        view_header.addSubview(Count)
        
        let img_down = UIImageView.init(frame: CGRect.init(x: view.frame.size.width - 50, y: 10, width: 20, height: 20))
        img_down.image = #imageLiteral(resourceName: "ic_dropdown")
        view_header.addSubview(img_down)
        view_header.layer.shadowColor = UIColor.black.cgColor
        view_header.layer.shadowOpacity = 1
        view_header.layer.shadowOffset = CGSize.zero
        view_header.layer.shadowRadius = 6
        
        view_main.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		view_header.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        view_main.addSubview(view_header)
        return view_main
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return CollectionRequets_New.count
        case 1:
            return CollectionRequets_Aprroved.count
        case 2:
            return CollectionRequets_Complete.count

        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! HistoryNewTableViewCell
            cell.selectionStyle = .none
            
            let dict = CollectionRequets_New[indexPath.row] as! NSDictionary
            let Data_Items = dict.value(forKey: "OrderItem") as! NSArray
            let Dict_order = dict.value(forKey: "Order") as! NSDictionary

            cell.lblNumberService.text = "\(Data_Items.count) Services Request"
            cell.btnAccept.tag = Int(Dict_order.value(forKey: "id") as! String)!
            cell.btnDecline.tag = Int(Dict_order.value(forKey: "id") as! String)!

            var date : String = ""
            
            if Dict_order.value(forKey: "order_type") as? String == "1"{
                date = Dict_order.value(forKey: "created") as! String
				cell.btnAccept.accessibilityHint = "1"

            }
            else if Dict_order.value(forKey: "order_type") as? String == "2"{
                date = Dict_order.value(forKey: "schedule_date") as! String
				cell.btnAccept.accessibilityHint = "2"
            }
            var person : Int = 0

            for i in Data_Items{
                let dict_i = i as! NSDictionary
                person = person + Int(dict_i.value(forKey: "no_of_person") as! String)!
            }
            cell.lblCount.text = "\(person)"
            
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"

            let dateFormattertime = DateFormatter()
			dateFormattertime.dateFormat =  "yyyy-MM-dd HH:mm:ss"


			let JobTime = dateFormatter.date(from: date)!
			let Servertime = dateFormatter.date(from: Service_Time)!

			let interval = 600 - Servertime.timeIntervalSince(JobTime)
			let sec = Int(interval) - Sec_remove
			cell.lblTime.text = String(timeString(time: TimeInterval(sec)))
			
            if (dateFormatter.date(from: date) != nil) {
                let TIME = dateFormatter.date(from: date)!
                dateFormatter.dateFormat = "HH:mm"
                let TimeString = dateFormatter.string(from: TIME)
                let day = dateFormattertime.date(from: date)!
                dateFormattertime.dateFormat = "dd MMM"
                let dateString = dateFormattertime.string(from: day)
                cell.lblChTime.text = TimeString
                cell.lblDay.text = dateString
                
                
            }
            
            
            
            cell.btnDecline.addTarget(self, action: #selector(self.Decline(_:)), for: .touchDown)
            cell.btnAccept.addTarget(self, action: #selector(self.Accept(_:)), for: .touchDown)
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryCompleteTableViewCell
        cell.selectionStyle = .none
        if indexPath.section == 2{
            
        
        let dict = CollectionRequets_Complete[indexPath.row] as! NSDictionary
            let Data_Items = dict.value(forKey: "OrderItem") as! NSArray
            var person : Int = 0
            
            for i in Data_Items{
                let dict_i = i as! NSDictionary
                person = person + Int(dict_i.value(forKey: "no_of_person") as! String)!
            }
            cell.lblCount.text = "\(person)"
            if Data_Items.count == 1{
                let dict_item1 = Data_Items[0] as! NSDictionary
            
                
                cell.item1.text =  dict_item1.value(forKey: "service_name") as? String
              
                
                cell.viewItem1.isHidden = false
                cell.viewItem2.isHidden = true
                cell.viewItem3.isHidden = true

            }
            if Data_Items.count == 2{
                let dict_item1 = Data_Items[0] as! NSDictionary
                let dict_item2 = Data_Items[1] as! NSDictionary
                
                cell.item1.text =  dict_item1.value(forKey: "service_name") as? String
                cell.item2.text =  dict_item2.value(forKey: "service_name") as? String
                
                cell.viewItem1.isHidden = false
                cell.viewItem2.isHidden = false
                cell.viewItem3.isHidden = true
            }
            if Data_Items.count == 3{
                let dict_item1 = Data_Items[0] as! NSDictionary
                let dict_item2 = Data_Items[1] as! NSDictionary
                let dict_item3 = Data_Items[2] as! NSDictionary
                
                cell.item1.text =  dict_item1.value(forKey: "service_name") as? String
                cell.item2.text =  dict_item2.value(forKey: "service_name") as? String
                cell.item3.text =  dict_item3.value(forKey: "service_name") as? String
                
                cell.viewItem1.isHidden = false
                cell.viewItem2.isHidden = false
                cell.viewItem3.isHidden = false
            }
            let Dict_order = dict.value(forKey: "Order") as! NSDictionary
            
            cell.lblTag.text = "#\(Dict_order.value(forKey: "id") as! String)"
            cell.lblTime.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.lblTime.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            
            let dict_client = dict.value(forKey: "client") as! NSDictionary
            

            cell.lblTotal.text = (Dict_order.value(forKey: "total_paid_amount") as? String)! + " " + "SAR"

			var comm : CGFloat = 0.0
			//		let Dict_order = DataCollection.value(forKey: "Order") as! NSDictionary
			//			let commission = CGFloat(Dict_order.value(forKey: "commission") as! String)


			var pr : CGFloat = 0.0

			var commission : CGFloat = 0.0
			if let n = NumberFormatter().number(from: String(describing: Dict_order.value(forKey: "commission") as! String)) {
				commission = CGFloat(n)

			}

			//

			for i in Data_Items{
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

			cell.lblTotal.text = "\(pr + comm) SAR"




            var date : String = ""
            
            if Dict_order.value(forKey: "order_type") as? String == "1"{
                date = Dict_order.value(forKey: "created") as! String
            }
            else if Dict_order.value(forKey: "order_type") as? String == "2"{
                date = Dict_order.value(forKey: "schedule_date") as! String

            }
			cell.lblTime.text = dict_client.value(forKey: "full_name") as? String


            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"

            let dateFormattertime = DateFormatter()
            dateFormattertime.dateFormat =  "yyyy-MM-dd HH:mm:ss"

            if (dateFormatter.date(from: date) != nil) {
                let TIME = dateFormatter.date(from: date)!
                dateFormatter.dateFormat = "HH:mm"
                let TimeString = dateFormatter.string(from: TIME)
                let day = dateFormattertime.date(from: date)!
                dateFormattertime.dateFormat = "dd MMM"
                let dateString = dateFormattertime.string(from: day)
                cell.lblChTime.text = TimeString
                cell.lblDay.text = dateString




                
            }
        }
        else{
            
            
            let dict = CollectionRequets_Aprroved[indexPath.row] as! NSDictionary
            let Data_Items = dict.value(forKey: "OrderItem") as! NSArray
            var person : Int = 0
            
            for i in Data_Items{
                let dict_i = i as! NSDictionary
                person = person + Int(dict_i.value(forKey: "no_of_person") as! String)!
            }
            cell.lblCount.text = "\(person)"
            if Data_Items.count == 1{
                let dict_item1 = Data_Items[0] as! NSDictionary
                
                
                cell.item1.text =  dict_item1.value(forKey: "service_name") as? String
                
                
                cell.viewItem1.isHidden = false
                cell.viewItem2.isHidden = true
                cell.viewItem3.isHidden = true
                
            }
            if Data_Items.count == 2{
                let dict_item1 = Data_Items[0] as! NSDictionary
                let dict_item2 = Data_Items[1] as! NSDictionary
                
                cell.item1.text =  dict_item1.value(forKey: "service_name") as? String
                cell.item2.text =  dict_item2.value(forKey: "service_name") as? String
                
                cell.viewItem1.isHidden = false
                cell.viewItem2.isHidden = false
                cell.viewItem3.isHidden = true
            }
            if Data_Items.count == 3{
                let dict_item1 = Data_Items[0] as! NSDictionary
                let dict_item2 = Data_Items[1] as! NSDictionary
                let dict_item3 = Data_Items[2] as! NSDictionary
                
                cell.item1.text =  dict_item1.value(forKey: "service_name") as? String
                cell.item2.text =  dict_item2.value(forKey: "service_name") as? String
                cell.item3.text =  dict_item3.value(forKey: "service_name") as? String
                
                cell.viewItem1.isHidden = false
                cell.viewItem2.isHidden = false
                cell.viewItem3.isHidden = false
            }
            let Dict_order = dict.value(forKey: "Order") as! NSDictionary
            
            cell.lblTag.text = "#\(Dict_order.value(forKey: "id") as! String)"
//            cell.lblTime.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            cell.lblTime.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            
            let dict_client = dict.value(forKey: "client") as! NSDictionary
            

            cell.lblTotal.text = (Dict_order.value(forKey: "total_paid_amount") as? String)! + " " + "SAR"

			var comm : CGFloat = 0.0
			//		let Dict_order = DataCollection.value(forKey: "Order") as! NSDictionary
			//			let commission = CGFloat(Dict_order.value(forKey: "commission") as! String)


			var pr : CGFloat = 0.0

			var commission : CGFloat = 0.0
			if let n = NumberFormatter().number(from: String(describing: Dict_order.value(forKey: "commission") as! String)) {
				commission = CGFloat(n)

			}

			//

			for i in Data_Items{
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

			cell.lblTotal.text = "\(pr + comm) SAR"


            var date : String = ""
            
            if Dict_order.value(forKey: "order_type") as? String == "1"{
                date = Dict_order.value(forKey: "created") as! String
            }
            else if Dict_order.value(forKey: "order_type") as? String == "2"{
                date = Dict_order.value(forKey: "schedule_date") as! String
                
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"

            let dateFormattertime = DateFormatter()
            dateFormattertime.dateFormat =  "yyyy-MM-dd HH:mm:ss"

			let JobTime = dateFormatter.date(from: date)!
			let Servertime = dateFormatter.date(from: Service_Time)!

			let interval = JobTime.timeIntervalSince(Servertime)
			let sec = Int(interval) - Sec_remove
			cell.lblTime.text = String(timeString(time: TimeInterval(sec)))
//			Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)

            if (dateFormatter.date(from: date) != nil) {
                let TIME = dateFormatter.date(from: date)!
                dateFormatter.dateFormat = "HH:mm"
                let TimeString = dateFormatter.string(from: TIME)
                let day = dateFormattertime.date(from: date)!
                dateFormattertime.dateFormat = "dd MMM"
                let dateString = dateFormattertime.string(from: day)
                cell.lblChTime.text = TimeString
                cell.lblDay.text = dateString
                
                
            }
        }
        cell.btnDetail.accessibilityHint = "\(indexPath.section)"

        cell.btnDetail.tag = indexPath.row
         cell.btnDetail.addTarget(self, action: #selector(self.Detail(_:)), for: .touchDown)
        return cell
    }
	func timeString(time:TimeInterval) -> String {
		let day = Int(time) / 86400

		let hours = (Int(time) % 86400) / 3600
		let minutes = Int(time) / 60 % 60
		let seconds = Int(time) % 60
		return    "\(day):\(hours):\(minutes):\(seconds)"

	}

    @IBAction func Detail(_ Accept: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryOrderDetailViewController") as! HistoryOrderDetailViewController
        
        
        switch Int(Accept.accessibilityHint!) {
        case 0?:
            vc.CollectionData = NSMutableDictionary.init(dictionary: CollectionRequets_New[Accept.tag] as! NSDictionary)
        case 1?:
            vc.CollectionData = NSMutableDictionary.init(dictionary: CollectionRequets_Aprroved[Accept.tag] as! NSDictionary)
        default:
            vc.CollectionData = NSMutableDictionary.init(dictionary: CollectionRequets_Complete[Accept.tag] as! NSDictionary)

        }
        
        present(vc, animated: true, completion: nil)
    }
    @IBAction func Accept(_ Accept: UIButton) {




        AcceptRequest(req_id: "\(Accept.tag)" , type:  Accept.accessibilityHint!)

        
    }
    @IBAction func Decline(_ sender: UIButton) {
        btnBg.isHidden = false
        viewDecline.isHidden = false
        viewDecline.tag = sender.tag
		GetRequests()
        
    }
    @IBAction func BGBack(_ sender: Any) {
        btnBg.isHidden = true
        viewDecline.isHidden = true

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func ImSureDecline(_ sender: Any) {
        DeclineRequest(status: "\(viewDecline.tag)")
        
    }
    @IBAction func CancelDecline(_ sender: Any) {
        btnBg.isHidden = true
        viewDecline.isHidden = true
    }
	func AcceptRequest(req_id : String , type : String)  {
        
        
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["request_id" : req_id , "lang" : "en"]
        print(Dict)
        //           apis/
        //        apis/acceptreq?request_id=2&lang=en
        
        dataModel.PostApi(Url: "apis/acceptreq", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    self.viewDecline.isHidden = true
					if type == "2"{
						self.GetRequests()
					}
					else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    
                    vc.order_id = req_id
                    self.present(vc, animated: true, completion: nil)
                    
					}
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
        
        
    }
    func DeclineRequest(status : String)  {
        
        
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["request_id" : status ,"reason" : txtComment.text! , "lang" : "en" ]
        print(Dict)
        //           apis/
        //        apis/declinereq?request_id=2&reason=abc&lang=en
        
        dataModel.PostApi(Url: "apis/declinereq", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    self.btnBg.isHidden = true
                    self.viewDecline.isHidden = true
                     self.GetRequests()

                    //                    btnNxt.setTitle("Next", for: .normal)
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
        
        
    }
    
}
