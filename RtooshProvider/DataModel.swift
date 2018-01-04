//
//  DataModel.swift
//  BnkUp
//
//  Created by OSX on 04/10/16.
//  Copyright © 2016 Jaipreet. All rights reserved.
//

import Alamofire
import UIKit
import IQKeyboardManagerSwift
//http://rotsys.com/api/customers/verifyOtp?phone=9888801596&otp=4631&deviceToken=&deviceType=ios&lang=en&userType=2//http://nimbyisttechnologies.com/himanshu/express/api/apis/
var Baseurl : String = "http://rotsys.com/api/"
var SignIn : NSString = ""
var SignUp : NSString = ""
var ForgotPassword : NSString = ""
var UpdateDetail : NSString = ""


//var BuyerAuthUserName : String = "sandeep.orem12@gmail.com"
//var BuyerAuthUserPassword : String = "66327Jk71Yh77v384MZ51H4hQ7c06q7l"


//home?user_id=12


typealias CompletionBlock = (_ result: Any, _ error: NSError?) -> Void




class DataModel: NSObject {

    
    //blocks
    var completion: CompletionBlock = { result, error in print(error!) }
    

    

    
    

    
     func PostApi( Url: NSString, dict: NSDictionary, withCompletionHandler:@escaping (_ result:NSDictionary , _ Error : NSString ) -> Void) {
        
        IQKeyboardManager.sharedManager().resignFirstResponder()
        var url = "\(Baseurl)\(Url)"
        
        
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        
        
      print(url)
        
        
        Alamofire.request(url as String  , method: .post , parameters: dict as? Parameters ).responseJSON { response in
              // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
                
                
                
                withCompletionHandler( JSON as! NSDictionary , response.result.description as NSString )
            }
            else{
                //                withCompletionHandler()
                //                let Dict : NSDictionary()
                let JSON = ["error":"data"]
                withCompletionHandler( JSON as NSDictionary , "Error" )
                
            }
        }//
        //
    }
    func GEtApi( Url: NSString, dict: NSDictionary, withCompletionHandler:@escaping (_ result:NSDictionary , _ Error : NSString ) -> Void) {
        
        
        var url = "\(Baseurl)\(Url)"
        
        IQKeyboardManager.sharedManager().resignFirstResponder()

        
        url = url.replacingOccurrences(of: " ", with: "%20")
        
        
        print(url)
        
        
        Alamofire.request(url as String  , method: .get , parameters: dict as? Parameters ).responseJSON { response in
            // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                //                print("JSON: \(JSON)")
                
                
                
                withCompletionHandler( JSON as! NSDictionary , response.result.description as NSString )
            }
            else{
                //                withCompletionHandler()
                //                let Dict : NSDictionary()
                let JSON = ["error":"data"]
                withCompletionHandler( JSON as NSDictionary , "Error" )
                
            }
        }//
        //
    }
    func GEtDirectionApi( Url: NSString, dict: NSDictionary, withCompletionHandler:@escaping (_ result:NSDictionary , _ Error : NSString ) -> Void) {
        
        
        var url = "\(Url)"
        
        IQKeyboardManager.sharedManager().resignFirstResponder()
        
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        
        
        print(url)
        
        
        Alamofire.request(url as String  , method: .get , parameters: dict as? Parameters , encoding: URLEncoding.default).responseJSON { response in
            // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                //                print("JSON: \(JSON)")
                
                
                
                withCompletionHandler( JSON as! NSDictionary , response.result.description as NSString )
            }
            else{
                //                withCompletionHandler()
                //                let Dict : NSDictionary()
                let JSON = ["error":"data"]
                withCompletionHandler( JSON as NSDictionary , "Error" )
                
            }
        }//
        //
    }

       func PostLocationApi( Url: NSString, dict: NSDictionary, withCompletionHandler:@escaping (_ result:NSDictionary , _ Error : NSString ) -> Void) {
        
        
        var url = "\(Baseurl)\(Url)"
        
        
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        
        
        print(url)
        
        
        Alamofire.request(url as String  , method: .post , parameters: dict as? Parameters ).responseJSON { response in
            // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
                
                
                
                withCompletionHandler( JSON as! NSDictionary , response.result.description as NSString )
            }
            else{
                //                withCompletionHandler()
                //                let Dict : NSDictionary()
                let JSON = ["error":"data"]
                withCompletionHandler( JSON as NSDictionary , response.result.description as NSString )
                
            }
        }//
        //
    }
       func UploadVideoApi( Url: NSString,movieURL : NSString ,  dict: NSDictionary, withCompletionHandler:@escaping (_ result:NSDictionary , _ Error : NSString ) -> Void) {
        
        var url = "\(Baseurl)\(Url)"
        
        
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]

   
                
       
        
//             Alamofire.upload(movieURL, to: url, method: .post, headers: headers).uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//                            print("Upload Progress: \(progress.fractionCompleted)")
//                        }
//                        .downloadProgress { progress in // called on main queue by default
//                            print("Download Progress: \(progress.fractionCompleted)")
//                        }
//                        .validate { request, response, data in
//                            // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
//                            return .success
//                        }
//                        .responseJSON { response in
//                            debugPrint(response)
//                    }

        
//        Alamofire.upload(url, to: url, method: .post , headers : headers)
//            .uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//                print("Upload Progress: \(progress.fractionCompleted)")
//            }
//            .downloadProgress { progress in // called on main queue by default
//                print("Download Progress: \(progress.fractionCompleted)")
//            }
//            .validate { request, response, data in
//                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
//                return .success
//            }
//            .responseJSON { response in
//                debugPrint(response)
//        }
        

    }
    
    func GetRegApi( urlString: NSString, dict: NSDictionary , withCompletionHandler:@escaping (_ result:NSDictionary ) -> Void) {
        _ = Alamofire.request("https://httpbin.org/get", parameters: ["foo": "bar"])

//        Alamofire.request(urlString, method: .get, parameters: dict, encoding: JSONEncoding.default)
//            .downloadProgress(queue: DispatchQueue.utility) { progress in
//                print("Progress: \(progress.fractionCompleted)")
//            }
//            .validate { request, response, data in
//                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
//                return .success
//            }
//            .responseJSON { response in
//                debugPrint(response)
//        }
    }

    func OKAlertController(Message : String , alertMsg : String)  {
        let alert = UIAlertController.init(title: alertMsg, message: Message, preferredStyle: .alert)
        
        let Ok = UIAlertAction.init(title: "OK", style: .cancel) { (sender) in
            
        }
        alert.addAction(Ok)
        
        var topController = UIApplication.shared.keyWindow!.rootViewController!
        
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!;
        }
        topController.present(alert, animated:true, completion:nil)
        //        alert.present(alert, animated: true, completion: nil)
        
    }
    func ToastAlertController(Message : String , alertMsg : String)  {
        let alert = UIAlertController.init(title: alertMsg, message: Message, preferredStyle: .alert)
        
        
        let when = DispatchTime.now() + 1.5
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
        
        var topController = UIApplication.shared.keyWindow!.rootViewController!
        
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!;
        }
        topController.present(alert, animated:true, completion:nil)
        //        alert.present(alert, animated: true, completion: nil)
        
    }
    func SetDataFormat(date : String) -> String {
        //         let dte = "2017-01-27 18:36:36"
        print(date)
        let dateFormatter = DateFormatter()
        //        let tempLocale = dateFormatter.locale // save locale temporarily
        //        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        if (dateFormatter.date(from: date) != nil) {
        let dat = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm a"
        //        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: dat)
        print("EXACT_DATE : \(dateString)")
        return dateString
        }
        return ""
    }
}
