//
//  HomeViewController.swift
//  RtooshProvider
//
//  Created by Apple on 01/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import GoogleMaps
import DotsLoading
import IQKeyboardManagerSwift
import NVActivityIndicatorView
import GooglePlaces

var NewOrderData : NSMutableDictionary!



class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, ENSideMenuDelegate , NVActivityIndicatorViewable , CLLocationManagerDelegate{
    @IBOutlet weak var viewLoadingWaiting: UIView!
    @IBOutlet weak var lblCountAppService: CircleLabel!
	var locationManager = CLLocationManager()
	var currentLocation: CLLocation?
	var zoomLevel: Float = 15.0

    @IBOutlet weak var lblAprrDate: CustomLabel_Light!
    @IBOutlet weak var lblAprrTime: CustomLabel_Light!
    @IBOutlet weak var lblCountNewService: CircleLabel!
    @IBOutlet weak var btnDark: UIButton!
    @IBOutlet weak var txtReason: IQTextView!
    @IBOutlet weak var ViewDecline: UIView!
    @IBOutlet weak var ViewAcceptButton: UIView!
    @IBOutlet weak var C_Time_w: NSLayoutConstraint!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnDecline: CustomButton_Light!
    @IBOutlet weak var btnAccept: CustomButton_Light!
    @IBOutlet weak var viewRequest: UIView!
    @IBOutlet weak var imgBgWaiting: UIImageView!
    @IBOutlet weak var viewWaiting: UIView!
    @IBOutlet weak var viewOnlineStatus: UIView!
    @IBOutlet weak var viewService: UIView!
    @IBOutlet weak var btnCancel: CustomButton_Light!
    @IBOutlet weak var ViewAgree: UIView!
    @IBOutlet weak var btnNxt: CustomButton_Light!
    @IBOutlet weak var viewCheckService: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBg: UIButton!
    @IBOutlet weak var viewOffline: UIView!
    @IBOutlet weak var mapView: GMSMapView!
	@IBOutlet weak var btnMenu: UIButton!
	@IBOutlet weak var imgClock: UIImageView!
	@IBOutlet weak var imgCalendar: UIImageView!
	
    @IBOutlet weak var lblRequestTime: CustomLabel_Medium!
    
    var CollectionRequets : NSMutableArray = []
    var CollectionRequets_New : NSMutableArray = []
    var CollectionRequets_Aprroved : NSMutableArray = []

    
	var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?

    var order_id : String = ""
    var timer = Timer()
    var Mints_10 : Int = 600
	var ViewFor : String = ""
    
    
    @IBOutlet weak var SwitchOinline: UISwitch!
    var Arr_title = ["Make up" , "Hair" , "Nails" , "Henna & Tatto" , "All "]
    
    var selected_Index : Int = 0
    let dotColors = [#colorLiteral(red: 0.9293708205, green: 0.2246870995, blue: 0.4236851335, alpha: 1), #colorLiteral(red: 0.9334717393, green: 0.2492173314, blue: 0.3575581312, alpha: 1),#colorLiteral(red: 0.9380148649, green: 0.3111425936, blue: 0.2990595698, alpha: 1), #colorLiteral(red: 0.9379648566, green: 0.3072549701, blue: 0.3039985895, alpha: 1), #colorLiteral(red: 0.9388373494, green: 0.369261086, blue: 0.2445831597, alpha: 1) , #colorLiteral(red: 0.9388373494, green: 0.369261086, blue: 0.2445831597, alpha: 1)]
//    var loadingView = DotsLoadingView(colors: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
					imgBgWaiting.layer.cornerRadius = 25
					imgBgWaiting.layer.masksToBounds = true
					self.sideMenuController()?.sideMenu?.delegate = self

					txtReason.layer.cornerRadius = 4
					txtReason.layer.masksToBounds = true
					txtReason.layer.borderColor = UIColor.lightGray.cgColor
					txtReason.layer.borderWidth = 1

					ViewDecline.layer.shadowColor = UIColor.black.cgColor
					ViewDecline.layer.shadowOpacity = 1
					ViewDecline.layer.shadowRadius = 8
					ViewDecline.layer.shadowOffset = CGSize.zero

					view.bringSubview(toFront: btnMenu)

					locationManager = CLLocationManager()
					locationManager.desiredAccuracy = kCLLocationAccuracyBest
					locationManager.requestAlwaysAuthorization()
					locationManager.distanceFilter = 50
					locationManager.startUpdatingLocation()
					locationManager.delegate = self

					viewOnlineStatus.isHidden = true
					viewWaiting.isHidden = true

					let camera = GMSCameraPosition.camera(withLatitude: Double(CurrentLat)!,
		                                      longitude: Double(Currentlng)!,
		                                      zoom: zoomLevel)
					mapView.camera = camera

					tableView.register(UINib.init(nibName: "RadioButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
					NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name:Notification.Name(NotificationGetNewRequest), object: nil)
					NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationOpenView(notification:)), name: Notification.Name(NotificationGetNewRequestOpenView), object: nil)

					NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationCheckVacation(notification:)), name: Notification.Name(NotificationCheckVacation), object: nil)

    }

	override func viewDidAppear(_ animated: Bool) {

					btnAccept.layer.cornerRadius = 20
					btnDecline.layer.cornerRadius = 20

					GetRequests()
					CheckOnlineButtonStatus()


					navigationController?.isNavigationBarHidden = true

					viewTime.layer.cornerRadius = 100

					let overlay1 = createOverlay2(frame: viewRequest.frame, xOffset: viewTime.frame.midX, yOffset: viewTime.frame.midY, radius: 100 )
					viewRequest.addSubview(overlay1)
					viewRequest.bringSubview(toFront: ViewAcceptButton)


	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Navigation


	@objc func methodOfReceivedNotificationCheckVacation(notification: Notification){
		CheckOnlineButtonStatus()
	}

    @objc func methodOfReceivedNotificationOpenView(notification: Notification){

		let dict = notification.userInfo! as NSDictionary
			NewOrderData = NSMutableDictionary.init(dictionary: dict.value(forKey: "0") as! NSDictionary)
//		   CheckNewNotification()

    }
    
    @objc func methodOfReceivedNotification(notification: Notification){

//        print(notification.userInfo! as NSDictionary)
//        let dict = notification.userInfo! as NSDictionary
//        NewOrderData = NSMutableDictionary.init(dictionary: dict.value(forKey: "0") as! NSDictionary)
//
//		CheckNewNotification()


    }


	// MARK: - Functions

	func CheckOnlineButtonStatus()  {

		let status : Int = Int((CurrentUserData.value(forKey: "status") as? String)!)!

		if status != 1{
			SwitchOinline.isOn = false
			SwitchOinline.isUserInteractionEnabled = false
			OfflineMode()
		}
		else{
			if CurrentUserData.value(forKey: "vacation_mode") as! String == "1"{
				SwitchOinline.isOn = false
				SwitchOinline.isUserInteractionEnabled = false
				OfflineMode()
			}
			else{
				if CurrentUserData.value(forKey: "work_online") as! String != "1"{
					SwitchOinline.isOn = false
					SwitchOinline.isUserInteractionEnabled = false
					OfflineMode()
				}
				else{
					SwitchOinline.isUserInteractionEnabled = true
					if CurrentUserData.value(forKey: "online") as! String == "1"{
						SwitchOinline.isOn = true
						WaitingMode()
					}
					else{
						SwitchOinline.isOn = false
						OfflineMode()
					}


				}





			}


			
		}

		CheckNewNotification()





	}

	func CheckNewNotification()  {
		if NewOrderData != nil{
			// your code with delay
			self.RequestMode()
//			backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
//				UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
//			})
			self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
			order_id =  NewOrderData.value(forKey: "orderID") as! String
			NewOrderData = nil

		}
	}

    @objc func updateTimer() {
        Mints_10 -= 1     //This will decrement(count down)the seconds.
        
        
        if Mints_10 == 0{
            Mints_10 = 600
            timer.invalidate()
                WaitingMode()
        }
        else{
        let minutes = Mints_10 / 60 % 60
        let seconds = Mints_10 % 60
        lblRequestTime.text = "\(minutes) : \(seconds)" //This will update the label.
        }
    }

	func RequestTimeOut()  {
		self.WaitingMode()


	}
	// MARK: - ENSideMenu Delegate
	func sideMenuWillOpen() {
		print("sideMenuWillOpen")

		btnDark.isHidden = false





	}

	func sideMenuWillClose() {
		print("sideMenuWillClose")
		btnDark.isHidden = true


	}
	// MARK: - Api's

    
    func StatusOnline(Status : String)  {

        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["user_id" : CurrentUserID, "status" : Status ,"lang": "en"]
        print(Dict)
        //           apis/
//        changeStatus?user_id=59&status=0&lang=en
        
        dataModel.PostApi(Url: "apis/changeStatus", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    if Status == "1"{
						self.WaitingMode()
                    }
                    else{
                        self.OfflineMode()

                    }

                }
                else{
                    self.SwitchOinline.isOn = false
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
        
        
    }
    func GetRequests()  {
        
        
        
//        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)

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
                 
                    self.CollectionRequets = NSMutableArray.init(array: Data.value(forKey: "data") as! NSArray)
                    
                    var next : Bool = false
                    for i in self.CollectionRequets{
                        let dict = i as! NSDictionary
                        let dict_order = dict.value(forKey: "Order") as! NSDictionary
                        if dict_order.value(forKey: "status") as! String == "1"{
                            self.CollectionRequets_New.add(i)
                        }
                        if dict_order.value(forKey: "status") as! String == "2"{
                            self.CollectionRequets_Aprroved.add(i)
                            if next == false{
                                next = true
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let date = dateFormatter.date(from: dict_order.value(forKey: "schedule_date") as! String)
                                dateFormatter.dateFormat = "MM:dd"
                                print(dateFormatter.string(from: date!))
                                self.lblAprrDate.text = dateFormatter.string(from: date!)
                                let dateFormatter1 = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                dateFormatter1.dateFormat = "HH:mm"
                                
                                print(dateFormatter1.string(from: date!))
                                self.lblAprrTime.text = dateFormatter1.string(from: date!)
                                
                            }

                        }
                        
                        self.lblCountNewService.text = "\(self.CollectionRequets_New.count)"
                        self.lblCountAppService.text = "\(self.CollectionRequets_Aprroved.count)"
						if self.CollectionRequets_Aprroved.count == 0{
							self.imgClock.isHidden = true
							self.imgCalendar.isHidden = true
							self.lblAprrDate.isHidden = true
							self.lblAprrTime.isHidden = true

						}
						else{
							self.imgClock.isHidden = false
							self.imgCalendar.isHidden = false
							self.lblAprrDate.isHidden = false
							self.lblAprrTime.isHidden = false

						}

                        
                        
                    }

                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
        
        
    }
    

    
    func AcceptRequest(req_id : String)  {
        
        
        
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
                    self.viewRequest.isHidden = true
                    self.SwitchOinline.isOn = false
					self.OfflineMode()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    
                    vc.order_id = req_id
                    self.present(vc, animated: true, completion: nil)

                    
                    //                    btnNxt.setTitle("Next", for: .normal)
                }
                else{
                    self.SwitchOinline.isOn = false
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
        
        
    }
    func DeclineRequest(status : String)  {
        
        
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["request_id" : status ,"reason" : txtReason.text! , "lang" : "en" ]
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
                    
                    self.OfflineMode()

                    //                    btnNxt.setTitle("Next", for: .normal)
                }
                else{
                    self.SwitchOinline.isOn = false
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
        
        
    }
    
	// MARK: - Button Action

    @IBAction func CloseManu(_ sender: Any) {
        hideSideMenuView()
    }
	@IBAction func MENU(_ sender: Any) {
		toggleSideMenuView()

	}

	@IBAction func menu(_ sender: Any) {
		toggleSideMenuView()

	}
	@IBAction func Back(_ sender: Any) {

    }

    @IBAction func ButtonBg(_ sender: Any) {
    }
    @IBAction func Next(_ sender: Any) {
        if btnNxt.title(for: .normal) == "Next"{
        btnNxt.setTitle("AGREE", for: .normal)
            ViewAgree.isHidden = false

            viewCheckService.isHidden = true
            btnCancel.isHidden = false

        }
        else{


			if SwitchOinline.isOn == true{
				StatusOnline(Status: "1")

				//               OnlineMode()
				//
				//            tableView.reloadData()
			}
			else{
				StatusOnline(Status: "0")

				OfflineMode()
			}


//            RequestMode()

//            btnNxt.setTitle("Next", for: .normal)


            


        }
    }

    
    @IBAction func Cancel(_ sender: Any) {
       
        OfflineMode()
        btnNxt.setTitle("Next", for: .normal)
        SwitchOinline.setOn(false, animated: true)
        
    }

	@IBAction func Switch_Online(_ sender: UISwitch) {

		if SwitchOinline.isOn == true{
			//            StatusOnline(Status: "1")
			self.OnlineMode()

			//               OnlineMode()
			//
			//            tableView.reloadData()
		}
		else{
			//            StatusOnline(Status: "0")

			OfflineMode()
		}

	}

	@IBAction func Decline(_ sender: Any) {
		DeclineMode()
		NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])



	}
	@IBAction func Accept(_ sender: Any) {
		NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])

		AcceptRequest(req_id: order_id)
	}
	@IBAction func CancelDecline(_ sender: Any) {
		NewOrderData = nil

		ViewDecline.isHidden = true
	}
	@IBAction func ImSureDecline(_ sender: Any) {
		if   CheckTextField.Check_text(text: txtReason.text!){
			DeclineRequest(status : order_id)
		}
	}
	@IBAction func HistoryNew(_ sender: Any) {

		//		toggleSideMenuView()

		let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController

		self.present(vc, animated: true, completion: nil)
	}
	@IBAction func HistoryApprove(_ sender: Any) {
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController

		self.present(vc, animated: true, completion: nil)
	}


	// MARK: - TableViewDelegates

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RadioButtonTableViewCell
        cell.selectionStyle = .none
        
        cell.btn.Selected_title = Arr_title[indexPath.row]
        cell.btn.Selected_Image = #imageLiteral(resourceName: "ic_check_service")

        if indexPath.row == selected_Index{
            cell.btn.Selected_Image = #imageLiteral(resourceName: "ic_check_service")
        }
        else{
            cell.btn.Selected_Image = #imageLiteral(resourceName: "ic_uncheck_service")

        
        }
//        if indexPath.row != Arr_title.count - 1{
//
//            cell.btn.Selected_Image = #imageLiteral(resourceName: "ic_uncheck_service")
//        }
        
        if selected_Index == Arr_title.count - 1{
            
            cell.btn.Selected_Image = #imageLiteral(resourceName: "ic_check_service")
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_Index = indexPath.row
        tableView.reloadData()
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var Accept: CustomButton_Light!
    func createOverlay(frame : CGRect, xOffset: CGFloat, yOffset: CGFloat, radius: CGFloat) -> UIView
    {
        let overlayView = UIView(frame: frame)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffset, y: yOffset), radius: radius, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.red.cgColor
        maskLayer.path = path
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        overlayView.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        overlayView.layer.borderWidth = 4
        overlayView.layer.masksToBounds = true
        overlayView.layer.cornerRadius = viewTime.frame.size.height/2
        
        return overlayView
    }
    func createOverlay2(frame : CGRect, xOffset: CGFloat, yOffset: CGFloat, radius: CGFloat) -> UIView
    {
        let overlayView = UIView(frame: frame)
        
       
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffset, y: yOffset), radius: radius - 6, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.red.cgColor
        maskLayer.path = path
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        
        
        let CView = UIImageView(frame: CGRect.init(x: xOffset - radius, y: yOffset - radius, width: radius * 2, height: radius * 2))
        CView.image = #imageLiteral(resourceName: "nav_barHome")
        CView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        CView.contentMode = .scaleToFill
//        CView.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//        CView.layer.borderWidth = 8
        CView.layer.masksToBounds = true
        CView.layer.cornerRadius = 100
        overlayView.addSubview(CView)
        
        return overlayView
    }

	// MARK: - ViewChange Functions

    
    func OfflineMode()  {
        viewWaiting.isHidden = true
        viewOffline.isHidden = false
        btnBg.isHidden = true
        viewOnlineStatus.isHidden = true
        viewService.isHidden = true
        viewRequest.isHidden = true
        IsLocationUpdate = "0"
        
        
//        loadingView.stop()
        ViewDecline.isHidden = true
        viewTime.isHidden = true
    }
    func OnlineMode()  {
        viewWaiting.isHidden = true
        viewOffline.isHidden = true
        btnBg.isHidden = false
        viewOnlineStatus.isHidden = true
        viewService.isHidden = false
        viewCheckService.isHidden = true
        ViewAgree.isHidden = false
        IsLocationUpdate = "1"
        btnNxt.setTitle("AGREE", for: .normal)

        viewRequest.isHidden = true
        btnCancel.isHidden = false

        
        
//        loadingView.stop()
        ViewDecline.isHidden = true
        viewTime.isHidden = true
    }
    func WaitingMode() {
        viewWaiting.isHidden = false
        viewOffline.isHidden = true
        btnBg.isHidden = true
        viewOnlineStatus.isHidden = false
        viewService.isHidden = true
        
        viewRequest.isHidden = true
        
     let   loadingView = DotsLoadingView(colors: dotColors)
    //    self.viewLoadingWaiting.addSubview(loadingView)
        self.view.addSubview(loadingView)

       // loadingView.show()
     
        
        ViewDecline.isHidden = true
        viewTime.isHidden = true
        
//        _ = Timer.scheduledTimer(timeInterval: 10, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    func RequestMode()  {
        viewWaiting.isHidden = true
        viewOffline.isHidden = true
        btnBg.isHidden = true
        viewOnlineStatus.isHidden = false
        viewService.isHidden = true
       
        
        viewRequest.isHidden = false
        

//        loadingView.stop()
        ViewDecline.isHidden = true
        viewTime.isHidden = false
    }
    func DeclineMode()  {
        viewWaiting.isHidden = true
        viewOffline.isHidden = true
        btnBg.isHidden = true
        viewOnlineStatus.isHidden = false
        viewService.isHidden = true
        
        SwitchOinline.isOn = false
        viewRequest.isHidden = false
        
        viewRequest.bringSubview(toFront: ViewDecline)
        
//        loadingView.stop()
        ViewDecline.isHidden = false
        viewTime.isHidden = false
    }


	// MARK: - Location Delegate

	// Handle incoming location events.
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location: CLLocation = locations.last!
		print("Location: \(location)")

		let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
		                                      longitude: location.coordinate.longitude,
		                                      zoom: zoomLevel)

		locationManager.stopUpdatingLocation()


	}
	// Handle location manager errors.
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		locationManager.stopUpdatingLocation()
		print("Error: \(error)")
	}


	// Handle authorization for the location manager.
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .restricted:
			print("Location access was restricted.")
		case .denied:
			print("User denied access to location.")
			// Display the map using the default location.
		//			mapView.isHidden = false
		case .notDetermined:
			print("Location status not determined.")
		case .authorizedAlways: fallthrough
		case .authorizedWhenInUse:
			print("Location status is OK.")
		}
	}

}
