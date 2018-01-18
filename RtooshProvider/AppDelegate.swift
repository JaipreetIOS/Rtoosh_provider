//
//  AppDelegate.swift
//  RtooshProvider
//
//  Created by Apple on 27/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import UserNotificationsUI
import UserNotifications
import CoreLocation
import NVActivityIndicatorView

var dataModel = DataModel()
var CheckTextField = TextFieldCheck()
var CurrentDeviceToken : String = "56645"
var CurrentPhoneNumber : String = ""
var CurrentCountryCode : String = "+91"
var IsLocationUpdate : String = "0"
var CurrentLat : String = "30.7082062"
var Currentlng : String = "76.7027685"

var AccessTokenForGoogle : String = "AIzaSyCN2K2VLWkAt5pjn18dP1iGFW7OrlZAwB4"


var NotificationGetNewRequest : String = "NotificationGetNewRequest"
var NotificationGetNewRequestOpenView : String = "NotificationGetNewRequestOpenView"

var NotificationUserOnline : String = "NotificationUserOnline"
var NotificationUserGetData : String = "NotificationUserGetData"
var NotificationUserDataUpdated : String = "NotificationUserDataUpdated"
var NotificationCheckVacation : String = "NotificationCheckVacation"


var CurrentUserID : String = ""
var CurrentUserData : NSMutableDictionary!
var CurrentUserServices : NSMutableArray = []
var CurrentUserHours : NSMutableArray = []
var CurrentUserProviderImages : NSMutableArray = []


var Notification_DoneIds : String = "SaveIdsToRegister"
var Notification_Schedule : String = "SaveScheduleToRegister"
var Notification_Service : String = "SaveScrviceToRegister"
var Notification_publicInfo : String = "SavePublicInfoToRegister"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , CLLocationManagerDelegate , UNUserNotificationCenterDelegate , NVActivityIndicatorViewable  {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    var timer = Timer()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(AccessTokenForGoogle)
        GMSPlacesClient.provideAPIKey(AccessTokenForGoogle)

        IQKeyboardManager.sharedManager().enable = true
        
        if UserDefaults.standard.value(forKey: "CurrentUserData") is NSDictionary
        {
            
            IsLocationUpdate = "1"
            CurrentUserData = NSMutableDictionary.init(dictionary: UserDefaults.standard.value(forKey: "CurrentUserData") as! NSDictionary)
                CurrentUserID = CurrentUserData.value(forKey: "id") as! String
                
                    
                    GetUserData()
                    print(CurrentUserData)
            
            

            
            
        }
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
        timer = Timer.scheduledTimer(timeInterval: 500, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        
        
          NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(NotificationUserGetData), object: nil)
        
        
//AIzaSyD_GuMGlzmTyw31eLJ13eM4isaUzUflKow
        // Override point for customization after application launch.
        return true
    }
    @objc func methodOfReceivedNotification(notification: Notification){
        
       GetUserData()
        
        
    }
    func GetUserData()  {
        //      apis/getUser?user_id=66&lang=en
        
        
        
        
        let Dict = ["user_id" : CurrentUserID, "lang" : "en"]
        //            print(Dict)
        //            name=Himanshu kumar&email=himanshukumar@gmail.com&password=123456
        
        dataModel.PostApi(Url: "apis/getUser", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in

            if error == "Error"{
//                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")

            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                    print("Data=== \(Data)")
					CurrentUserProviderImages.removeAllObjects()
                    let dict = Data.value(forKey: "data") as!  NSDictionary
                    let data  = dict.value(forKey: "User") as!  NSDictionary
                    let dataservies  = dict.value(forKey: "Service") as!  NSArray
                    let Hours  = dict.value(forKey: "Hour") as!  NSArray
                    let Provider  = dict.value(forKey: "ProviderImages") as!  NSArray

                    CurrentUserID = data.value(forKey: "id") as! String
                    CurrentUserData = NSMutableDictionary.init(dictionary: data)
                    CurrentUserServices = NSMutableArray.init(array:  dataservies)
                    CurrentUserHours = NSMutableArray.init(array:  Hours)
                    CurrentUserProviderImages = NSMutableArray.init(array:  Provider)

                    
                    CurrentPhoneNumber = data.value(forKey: "phone") as! String
                    UserDefaults.standard.set(CurrentPhoneNumber, forKey: "CurrentPhoneNumber")
                    UserDefaults.standard.set(CurrentUserData, forKey: "CurrentUserData")
                    UserDefaults.standard.synchronize()
                    NotificationCenter.default.post(name: Notification.Name(NotificationUserOnline), object: nil, userInfo: [:])
                     NotificationCenter.default.post(name: Notification.Name(NotificationUserDataUpdated), object: nil, userInfo: [:])
                    NotificationCenter.default.post(name: Notification.Name(NotificationCheckVacation), object: nil, userInfo: [:])

                    
                }
                else{
//                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

                }
            }
        })
        
        
        
        
    }
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        CurrentDeviceToken = deviceTokenString
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        UserDefaults.standard.set(deviceTokenString, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        
        // Persist it in your backend in case it's new
    }
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

	}



    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
        let da = data as NSDictionary
   let     order =  da.value(forKey: "0") as! NSDictionary

        if order.value(forKey: "account_status") as! String == "1"{

			if order.value(forKey: "orderType") as! String == "1"{


                        self.window = UIWindow(frame: UIScreen.main.bounds)
            
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MyNavigationController")
            
                        self.window?.rootViewController = initialViewController
                        self.window?.makeKeyAndVisible()

        NotificationCenter.default.post(name: Notification.Name(NotificationGetNewRequestOpenView), object: nil, userInfo: data)

			}
		if order.value(forKey: "orderType") as! String == "2"{
			self.window = UIWindow(frame: UIScreen.main.bounds)

			let storyboard = UIStoryboard(name: "Main", bundle: nil)

			let initialViewController = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController

			self.window?.rootViewController = initialViewController
			self.window?.makeKeyAndVisible()

//			NotificationCenter.default.post(name: Notification.Name(NotificationGetNewRequestOpenView), object: nil, userInfo: data)
		}
		}
    }
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
		CheckOrderStatus()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        Currentlng = "\(userLocation.coordinate.longitude)"
        CurrentLat = "\(userLocation.coordinate.latitude)"
        locationManager.stopUpdatingLocation()
        
        
        LocationUpdate()

    }
    @objc func updateTimer() {
        self.locationManager.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

	func LocationUpdate()  {
		//        http://rotsys.com/api/apis/updateLocation?user_id=59&lat=30.6666&lng=70.2222&lang=en




		let Dict = ["user_id" : CurrentUserID, "lat" : CurrentLat ,"lng": Currentlng , "lang" : "en"]
		//            print(Dict)
		//            name=Himanshu kumar&email=himanshukumar@gmail.com&password=123456

		dataModel.PostApi(Url: "apis/updateLocation", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in

			if error == "Error"{
				//                    dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")

			}
			else{
				if Data.value(forKey: "response") as! String == "1"{
				}
				else{
					//                        dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

				}
			}
		})




	}


    func CheckOrderStatus()  {
//http://rotsys.com/api/apis/ongoingRequest?user_id=102&lang=en
        
            
            
            let Dict = ["user_id" : CurrentUserID , "lang" : "en"]
//            print(Dict)
            //            name=Himanshu kumar&email=himanshukumar@gmail.com&password=123456
            
            dataModel.PostApi(Url: "apis/ongoingRequest", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
                
                if error == "Error"{
//                    dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")

                }
                else{
                    if Data.value(forKey: "response") as! String == "1"{
						let Data_data = Data.value(forKey: "data") as! NSDictionary
						let Data_order = Data_data.value(forKey: "Order") as! NSDictionary

						if Data_order.value(forKey: "status") as! String == "5"{

						self.window = UIWindow(frame: UIScreen.main.bounds)

						let storyboard = UIStoryboard(name: "Main", bundle: nil)

						let initialViewController = storyboard.instantiateViewController(withIdentifier: "PaymentDetailViewController") as! PaymentDetailViewController
							initialViewController.order_id = Data_order.value(forKey: "id") as! String
							initialViewController.DataCollection = NSMutableDictionary.init(dictionary: Data_data)
							

						self.window?.rootViewController = initialViewController
						self.window?.makeKeyAndVisible()
						}
						if Data_order.value(forKey: "status") as! String == "6" || Data_order.value(forKey: "status") as! String == "4"{

							self.window = UIWindow(frame: UIScreen.main.bounds)

							let storyboard = UIStoryboard(name: "Main", bundle: nil)

							let initialViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
							initialViewController.order_id = Data_order.value(forKey: "id") as! String
//							initialViewController.DataCollection = NSMutableDictionary.init(dictionary: Data_data)


							self.window?.rootViewController = initialViewController
							self.window?.makeKeyAndVisible()
						}


                    }
                    else{
//                        dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

                    }
                }
            })
            
            
        
        
    }
}

