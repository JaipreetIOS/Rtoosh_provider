//
//  DetailViewController.swift
//  RtooshProvider
//
//  Created by Apple on 04/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import GoogleMaps
import GooglePlaces
import MessageUI

//import GooglePlacePicker

class DetailViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , NVActivityIndicatorViewable , MFMessageComposeViewControllerDelegate{
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var lblEtaTime: CustomLabel_Medium!
    @IBOutlet weak var lblExpectedSec: CustomLabel_bold!
    @IBOutlet weak var lblExpectedMint: CustomLabel_bold!
    @IBOutlet weak var lblEstimateTime: CustomLabel_bold!
    @IBOutlet weak var lblPrepairTime: CustomLabel_Light!
    @IBOutlet weak var lblOrderTotalTime: CustomLabel_Light!
    @IBOutlet weak var lblPerson: CustomLabel_Light!
    @IBOutlet weak var lblTotalPrice: CustomLabel_bold!
    @IBOutlet weak var ViewComplete: UIView!
    @IBOutlet weak var ViewStart: UIView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var btnStart: CustomButton_Light!
    @IBOutlet weak var c_map_h: NSLayoutConstraint!
    @IBOutlet weak var c_detail_h: NSLayoutConstraint!
    @IBOutlet weak var img_bg: UIImageView!
    @IBOutlet weak var btnGoogleMap: CustomButton_Light!
    @IBOutlet weak var btnShareLocation: CustomButton_Light!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSms: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    
    var order_id : String = ""
    var CollectionOrderItem : NSMutableArray = []
    var CollectionData : NSMutableDictionary!
    
    var Estimate_time : String = ""
    var Estimate_distace : String = ""

    
    var driver_marker = GMSMarker()
    var driverpolyline = GMSPolyline()

    override func viewDidLoad() {
        super.viewDidLoad()
        img_bg.layer.masksToBounds = true
        ViewStart.layer.masksToBounds = true
        btnSms.layer.cornerRadius = 2
        btnSms.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSms.layer.borderWidth = 1
        btnCall.layer.cornerRadius = 2
        btnCall.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnCall.layer.borderWidth = 1

//		btnCall.backgroundColor = UIColor(red: 171, green: 178, blue: 186, alpha: 1.0)
		// Shadow and Radius
		btnCall.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		btnCall.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.8)
		btnCall.layer.shadowOpacity = 2.0
		btnCall.layer.shadowRadius = 4
		btnCall.layer.masksToBounds = false
		btnCall.layer.cornerRadius = 4.0

		btnSms.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		btnSms.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.8)
		btnSms.layer.shadowOpacity = 2.0
		btnSms.layer.shadowRadius = 4
		btnSms.layer.masksToBounds = false
		btnSms.layer.cornerRadius = 4.0

        btnGoogleMap.layer.cornerRadius = 11
        btnShareLocation.layer.cornerRadius = 11
        tableView.register(UINib.init(nibName: "OrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        ViewComplete.isHidden = true
         GetOrderDetail()




        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetOrderDetail()  {
//        http://rotsys.com/api/customers/orderDetail?order_id=2&lang=en
        
            
            self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
            
            let Dict = ["order_id" : order_id ,"lang": "en"]
            print(Dict)
            dataModel.PostApi(Url: "customers/orderDetail?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
                self.stopAnimating()
                
                if error == "Error"{
                    dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                    
                }
                else{
                    if Data.value(forKey: "response") as! String == "1"{
                        let Dict = Data.value(forKey: "data") as! NSDictionary
                        self.CollectionData = NSMutableDictionary.init(dictionary: Dict)
                      let OrderData_dict = Dict.value(forKey: "Order") as! NSDictionary
                        let OrderTtem_dict = Dict.value(forKey: "OrderItem") as! NSArray
                        self.CollectionOrderItem = NSMutableArray.init(array: OrderTtem_dict)
                        self.tableView.reloadData()
                        self.lblTotalPrice.text = "\(OrderData_dict.value(forKey: "total_paid_amount") as! String) SAR"
                        
                        var Persons : Int = 0
                        var time : Int = 0

                        for i in OrderTtem_dict {
                            let dict_i = i as! NSDictionary
                            let person_i = Int(dict_i.value(forKey: "no_of_person") as! String)
                            Persons = Persons + person_i!
                            
                            var duration_i = dict_i.value(forKey: "duration") as! String
                            duration_i = duration_i.replacingOccurrences(of: " ", with: "")
                            let Duration_arr = duration_i.components(separatedBy: ":")
                            let hours = Int(Duration_arr[0] )
							var mints = 00
							if Duration_arr.count == 2{

								mints = Int(Duration_arr[1] )!
							}
                            time = (hours! * 60 + mints) + time
                            

                            
                        }
                        self.lblPerson.text = "\(Persons) Persons"
                        self.lblOrderTotalTime.text = "\(time/60) hrs \(time%60) min"
						self.lblExpectedMint.text = "\(time/60) hrs \(time%60) min"
                  
                        self.DirectionApi()


						if OrderData_dict.value(forKey: "status") as! String == "4"{
							self.btnStart.setTitle("Service Complete", for: .normal)
							self.ViewStart.isHidden = true
							self.ViewComplete.isHidden = false

						}

						//			let commission = CGFloat(Dict_order.value(forKey: "commission") as! String)


						var pr : CGFloat = 0.0



						//
						for i in OrderTtem_dict{
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




						self.lblTotalPrice.text = "\(pr) SAR"



//                        self.lblPerson.text = "\() Person"
                        
                        
                    }
                    else{
                        dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                        
                    }
                }
            })
            
            
        }
    
    
    @IBAction func BAck(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func StartAndComplete(_ sender: UIButton) {
        if sender.title(for: .normal) == "Start The Service"{
          
            StartService()

        }
        else{
//            ViewComplete.isHidden = true
                CompleteService()
            
            

        }
    }
    
    @IBAction func IMREADY(_ sender: Any) {
    }
    @IBAction func CALL(_ sender: Any) {
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
  
    @IBOutlet weak var GoogleMap: CustomButton_Light!
    @IBAction func GoogleMap(_ sender: Any) {



		let data_Client  = CollectionData.value(forKey: "client") as! NSDictionary


		let dis_lat = data_Client.value(forKey: "lat") as! String
		let dis_lng = data_Client.value(forKey: "lng") as! String
		UIApplication.shared.open(NSURL(string:
			"comgooglemaps://?saddr=\(CurrentLat),\(Currentlng)&daddr=\(dis_lat),\(dis_lng)&directionsmode=driving")! as URL)
        
    }
    @IBAction func ShareLocation(_ sender: UIButton) {
		let data_Client  = CollectionData.value(forKey: "client") as! NSDictionary


		let dis_lat = data_Client.value(forKey: "lat") as! String
		let dis_lng = data_Client.value(forKey: "lng") as! String
		let textToShare = "http://maps.google.com/maps?q=\(dis_lat),\(dis_lng)&iwloc=A&hl=es"



		let activityViewController = UIActivityViewController(activityItems: [textToShare, URL.init(string: textToShare)!], applicationActivities: nil)
		navigationController?.present(activityViewController, animated: true)


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CollectionOrderItem.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        c_detail_h.constant = 35 + tableView.contentSize.height
        
        
        c_map_h.constant =  ScrollView.frame.size.height - (c_detail_h.constant + 140)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailTableViewCell
        
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
        cell.selectionStyle = .none
        return cell
    }
    
    func GoogleMapDirection()  {
        
    }
    //MARK: Direction Api
    
    func DirectionApi()
    {
        
        let data_Client  = CollectionData.value(forKey: "client") as! NSDictionary
        
        
        let dis_lat = data_Client.value(forKey: "lat") as! String
        let dis_lng = data_Client.value(forKey: "lng") as! String

        if CurrentLat == ""{
     CurrentLat = "30.7082062"
     Currentlng  = "76.7027685"
        }
        
     let   cancat = "\(CurrentLat),\(Currentlng)"
  let      dest_cancat = "\(dis_lat),\(dis_lng)"
        let params = [
            "origin":cancat,
            "destination":dest_cancat,
            "key":AccessTokenForGoogle
            ] as [String : Any]
        
        print(params)
        
        
        dataModel.GEtDirectionApi(Url: "https://maps.googleapis.com/maps/api/directions/json?", dict: params as NSDictionary) { (data, error) in
            if error == "Error"
            {
                
                return
            }
            
            if data != nil
            {
                
                
                let status = data["status"] as! String
                //****Draw Route Path Google map Direction*******/
                
                if status == "NOT_FOUND"
                {
                    
                }
                else
                {
                    let routes = data["routes"] as! NSArray
                    
                    
                    for route_i in routes
                    {
                        let route = route_i as! NSDictionary
                        
                        let routoverpolyline = route["overview_polyline"] as! NSDictionary
                        let points = routoverpolyline["points"] as! String
                        let path = GMSPath.init(fromEncodedPath: points)
                        let polyline = GMSPolyline.init(path:path)
                        polyline.strokeWidth = 4
                        polyline.strokeColor = UIColor.black
                        polyline.map = self.mapView
                    }
                    
                    
                    let marker = GMSMarker()
                    let marker2 = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: Double(CurrentLat)!, longitude: Double(Currentlng)!)
                    //        marker.title = "Sydney"
                    //        marker.snippet = "Australia"
                    let vi_ic = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
                     let im_ic = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
                    im_ic.image = #imageLiteral(resourceName: "ic_map_pin")
                    vi_ic.addSubview(im_ic)
                    marker.iconView = vi_ic
                    marker.map = self.mapView
                    
                    marker2.position = CLLocationCoordinate2D(latitude: Double(dis_lat)!, longitude: Double(dis_lng)!)
                    //        marker.title = "Sydney"
                    //        marker.snippet = "Australia"
                    let vi_ic2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
                    let im_ic2 = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
                    im_ic2.image = #imageLiteral(resourceName: "ic_location")
                    vi_ic2.addSubview(im_ic2)
                    marker2.iconView = vi_ic2
                    
                    marker2.map = self.mapView
                    
//                    if self.stop_camera == true
//                    {
//                        let vancouver = CLLocationCoordinate2D(latitude: Double(CurrentLat)!, longitude: Double(Currentlng)!)
//                        let calgary = CLLocationCoordinate2D(latitude: Double(dis_lat)!, longitude: Double(dis_lat)!)
//                        let bounds = GMSCoordinateBounds(coordinate: vancouver, coordinate: calgary)
//                        let camera = self.mapView.camera(for: bounds, insets: UIEdgeInsets())!
//                
//                        self.mapView.camera = camera
//                        self.stop_camera = false
//                    }
                    
                    
                    let camera = GMSCameraPosition.camera(withLatitude: Double(CurrentLat)!, longitude: Double(Currentlng)!, zoom: 14)
                                    self.mapView.camera = camera
                                    self.mapView.animate(to: camera)
                    let r1 = routes[0] as! NSDictionary
                    
                    let legs_data = r1["legs"] as! NSArray
                    let l1 = legs_data[0] as! NSDictionary
                    let distance = l1.value(forKey: "distance") as! NSDictionary
                    let duration = l1.value(forKey: "duration") as! NSDictionary
                    
                    self.lblEstimateTime.text = duration.value(forKey: "text") as? String
                    self.lblPrepairTime.text = "\(duration.value(forKey: "text") as! String) left"
                    self.lblEtaTime.text =  "\(duration.value(forKey: "text") as! String) (\(distance.value(forKey: "text") as! String))"
                    

                    print(legs_data)
                    
                    
                    //                let camera = GMSCameraPosition.camera(withLatitude: Double(self.fetch_so_lat)!, longitude: Double(self.fetch_so_long)!, zoom: 14)
                    //                //self.map_view.camera = camera
                    //                self.map_view.animate(to: camera)
                }
                
                
                
                
                
            }
            else
                
            {
                
                
                let alert = UIAlertController(title: "", message:"No Data Please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
                
                
            }
            
            

            
            
        }
  
        
    }

    func StartService()  {
//        http://rotsys.com/api/apis/startservice?service_id=2&lang=en
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["service_id" : order_id, "lang" : "en" ]
        print(Dict)
        
        dataModel.PostApi(Url: "apis/startservice", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    self.btnStart.setTitle("Service Complete", for: .normal)
                    self.ViewStart.isHidden = true
                    self.ViewComplete.isHidden = false
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }
    func CompleteService()  {
        //       http://rotsys.com/api/apis/completeservice?service_id=2&lang=en

        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["service_id" : order_id, "lang" : "en" ]
        print(Dict)
        
        dataModel.PostApi(Url: "apis/completeservice", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailViewController") as! PaymentDetailViewController
                    vc.DataCollection = self.CollectionData
                    vc.order_id = self.order_id
                    self.present(vc, animated: true, completion: nil)

                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }
    
//    186 (140) + 64
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
