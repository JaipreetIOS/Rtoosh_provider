//
//  SettingsViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class SettingsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , NVActivityIndicatorViewable{
    @IBOutlet weak var c_personTable_h: NSLayoutConstraint!
    
    @IBOutlet weak var txtServices: SimpleTextField!
    let Arr_title = ["Maximum persons per order" , "Maximum service per order"]
    let Arr_detail = ["How much persons you want to surve per order" ,  "How much services you want to provide per order"]
    let Arr_person = ["Person" ,  "Service"]
    let Arr_count : NSMutableArray = []
    var TempServiceArray : NSMutableArray = []
    var Arr_Header : NSMutableArray = []

	@IBOutlet weak var lblAddServiceHeader: CustomLabel_bold!
	@IBOutlet weak var C_serviceTable_H: NSLayoutConstraint!
    var Selected_Index : Int = -1

    var isEdit : Bool = false

    @IBOutlet weak var txtDuration: SimpleTextField!
    @IBOutlet weak var txtPreice: SimpleTextField!
    @IBOutlet weak var txtDescription: SimpleTextField!
    @IBOutlet weak var txtService_name: SimpleTextField!
    @IBOutlet weak var ViewAddService: BackView!
    @IBOutlet weak var bgView: UIView!
    
    
    var CollectionService : NSMutableArray = []
    
    @IBOutlet weak var PersonTableView: UITableView!
    @IBOutlet weak var ServiceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonTableView.register(UINib.init(nibName: "SceduleTableViewCell", bundle: nil) , forCellReuseIdentifier: "Cell")
        ServiceTableView.register(UINib.init(nibName: "SreviceListTableViewCell", bundle: nil) , forCellReuseIdentifier: "Cell")
        
        ServiceTableView.estimatedRowHeight = 50
        ServiceTableView.rowHeight = UITableViewAutomaticDimension
        ServiceTableView.isUserInteractionEnabled = true
        PersonTableView.isUserInteractionEnabled = true

        GetServiceList()
        
        Arr_count.add(Int(CurrentUserData.value(forKey: "max_persons") as! String) ?? 1)
		var pr_x : CGFloat = 0.0
		if let n = NumberFormatter().number(from: String(describing: CurrentUserData.value(forKey: "min_order") as! String)) {
			pr_x = CGFloat(n)

		}
		Arr_count.add(Int(pr_x) )



        txtServices.text =  CurrentUserData.value(forKey: "max_services") as? String

        for i in CurrentUserServices{
            
        let di = i as! NSDictionary
        
        let dict = ["service_name" : di.value(forKey: "service_name") as! NSString,
                    "description" : di.value(forKey: "description") as! NSString,
                    "price" : di.value(forKey: "price") as! NSString,
                    "duration" : di.value(forKey: "duration") as! NSString]
        
        let temp_dict = di.value(forKey: "Category") as! NSDictionary
        
        
        let temp_dic = [temp_dict.value(forKey: "id") as! String : dict]
        let temp_Arr = temp_dic
            CollectionService.add(temp_Arr)

        }
        self.ServiceTableView.reloadData()

        // Do any additional setup after loading the view."
    }
    @IBAction func BAck(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        self.present(vc , animated: true, completion: nil)
    }
    func GetServiceList()  {
        let Dict = [
            "lang" : "en"
        ]
                self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        print(Dict)
        dataModel.GEtApi(Url: "apis/servicelist?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String != "0"{
                    print(Data)
                    let arr = Data.value(forKey: "data") as!  NSArray
                    
                    self.Arr_Header = NSMutableArray.init(array: arr)
                    
                    
                    for i in arr{
                        let dict = (i as! NSDictionary).value(forKey: "Category") as! NSDictionary
                        let dic = [dict.value(forKey: "id")]
                        self.TempServiceArray.add(dic)
                        
                    }
                    
                    print(self.TempServiceArray)
                    self.ServiceTableView.reloadData()
                    
                    
                    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == PersonTableView {
            return 1
        }
        else{
            
        
        return Arr_Header.count
        }
    }
//
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == PersonTableView {
            return 0

        }
        else{
        return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        c_personTable_h.constant = PersonTableView.contentSize.height
//        if ServiceTableView.contentSize.height <= 200{
//            C_serviceTable_H.constant = 200
//        }
//        else{
        C_serviceTable_H.constant = ServiceTableView.contentSize.height
//        }
        if tableView == PersonTableView {
            let vie = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
            
            return vie
        }
        else{
            
        
        let vie = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        vie.backgroundColor = UIColor.clear
        let main_view = UIView.init(frame: CGRect.init(x: 8, y: 4, width: tableView.frame.size.width - 16, height: 42))
        main_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        main_view.layer.cornerRadius = 4
        main_view.layer.borderWidth = 2
        main_view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        main_view.layer.masksToBounds = true
        
        
        let dict = (Arr_Header[section] as! NSDictionary).value(forKey: "Category") as! NSDictionary
        
        
        let bgImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 42, height: 42))
        bgImg.image = #imageLiteral(resourceName: "nav_barHome")
        main_view.addSubview(bgImg)
        
        let LogoImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 42 , height: 42 ))
        LogoImg.sd_setImage(with: URL.init(string: dict.value(forKey: "image") as! String), placeholderImage: #imageLiteral(resourceName: "ic_profile_hair"))
        main_view.addSubview(LogoImg)
        
        let lbl_title = UILabel.init(frame: CGRect.init(x: 50, y: 0, width: 100, height: 42))
        lbl_title.text = dict.value(forKey: "cat_name") as? String
        //        lbl_title.font =  UIFont.init(name: "Bold", size: 15)!
        lbl_title.font = UIFont.init(name: "Avenir-Black", size: 15)
        
        main_view.addSubview(lbl_title)
        
        let line_view = UIView.init(frame: CGRect.init(x: main_view.frame.size.width - 43, y: 6, width: 1, height: 30))
        line_view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        main_view.addSubview(line_view)
        
        
        let AddBtn = UIButton.init(frame: CGRect.init(x: main_view.frame.size.width - 43, y: 0, width: 40, height: 40))
        //        AddBtn.titleLabel?.font = UIFont.init(name: "avenir-lt-65-medium-5969f31f07372", size: 15)!
        AddBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        AddBtn.setTitle("+", for: .normal)
        AddBtn.setTitleColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), for: .normal)
        AddBtn.addTarget(self, action: #selector(self.AddService(_:)), for: .touchDown)
        AddBtn.tag = section
			AddBtn.accessibilityHint = dict.value(forKey: "cat_name") as? String
        main_view.addSubview(AddBtn)
        
        vie.addSubview(main_view)
        return vie
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == PersonTableView {
            return 2

        }
        
        let dict_return : NSMutableDictionary = [:]
        var arr_return : NSMutableArray = []
        
        for i in CollectionService{
            let dict = i as! NSDictionary
            
            let dict_key_arr = dict.allKeys
            let dict_key = dict_key_arr[0] as! String
            let keys = dict_return.allKeys as! NSArray
            
            if keys.contains(dict_key){
                
                
                
                let arr_temp = NSMutableArray.init(array: dict_return.value(forKey: dict_key) as! NSArray)
                
                
                arr_temp.add(dict.value(forKey: dict_key) as! NSDictionary)
                dict_return.setValue(arr_temp, forKey: dict_key)
            }
            else{
                dict_return.setValue([dict.value(forKey: dict_key) as! NSDictionary], forKey: dict_key)
                
            }
            print(dict_return)
            
            
            
            
            
        }
        
        let return_allKeys = dict_return.allKeys
        
        for i in return_allKeys {
            let dict = (Arr_Header[section] as! NSDictionary).value(forKey: "Category") as! NSDictionary
            if dict.value(forKey: "id") as! String == i as! String{
                
                print(dict_return.value(forKey: i as! String) as! NSArray)
                arr_return = NSMutableArray.init(array: dict_return.value(forKey: i as! String) as! NSArray)
            }
        }
        
        return arr_return.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == PersonTableView {
            return 100
            
        }
        else{
            return UITableViewAutomaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == PersonTableView {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SceduleTableViewCell
        cell.selectionStyle = .none
        cell.lblTitle.text = Arr_title[indexPath.row]
        cell.lblDetail.text = Arr_detail[indexPath.row]
        cell.lblPerson.text = Arr_person[indexPath.row]
        cell.lblPersonCount.text = "\(Arr_count[indexPath.row])"
        cell.btnAdd.addTarget(self, action: #selector(self.Add(_:)), for: .touchDown)
        cell.btnAdd.tag = indexPath.row
        cell.btnSub.addTarget(self, action: #selector(self.Sub(_:)), for: .touchDown)
        cell.btnSub.tag = indexPath.row
        
        if indexPath.row == 0{
            Register_Schedule.setValue("\(Arr_count[indexPath.row])", forKey: "max_persons")
            
        }
        else{
            Register_Schedule.setValue("\(Arr_count[indexPath.row])", forKey: "max_services")
            
        }
        
        
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SreviceListTableViewCell
            cell.selectionStyle = .none
            
            
            let dict_return : NSMutableDictionary = [:]
            var arr_return : NSMutableArray = []
            
            for i in CollectionService{
                let dict = i as! NSDictionary
                
                let dict_key_arr = dict.allKeys
                let dict_key = dict_key_arr[0] as! String
                let keys = dict_return.allKeys as! NSArray
                
                if keys.contains(dict_key){
                    
                    let arr_temp = NSMutableArray.init(array: dict_return.value(forKey: dict_key) as! NSArray)
                    
                    
                    arr_temp.add(dict.value(forKey: dict_key) as! NSDictionary)
                    dict_return.setValue(arr_temp, forKey: dict_key)
                }
                else{
                    dict_return.setValue([dict.value(forKey: dict_key) as! NSDictionary], forKey: dict_key)
                    
                }
                print(dict_return)
                
                
                
                
                
            }
            
            let return_allKeys = dict_return.allKeys
            
            for i in return_allKeys {
                let dict = (Arr_Header[indexPath.section] as! NSDictionary).value(forKey: "Category") as! NSDictionary
                if dict.value(forKey: "id") as! String == i as! String{
                    
                    print(dict_return.value(forKey: i as! String) as! NSArray)
                    arr_return = NSMutableArray.init(array: dict_return.value(forKey: i as! String) as! NSArray)
                }
            }
            
            let dict_show = arr_return[indexPath.row] as! NSDictionary
            var main_index : Int = -1
            
            for i in 0..<CollectionService.count {
                let dict = CollectionService[i] as! NSDictionary
				print(dict)

                let dict_key_arr = dict.allKeys
                let dict_key = dict_key_arr[0] as! String
                
                let Comp_dict = dict.value(forKey: dict_key) as! NSDictionary
                print(Comp_dict)
                print(dict_show)
                if Comp_dict == dict_show{
                    main_index = i
                }
                
                
            }
            
            
            
            cell.btnEdit.addTarget(self, action: #selector(self.Edit(_:)), for: .touchDown)
            cell.btnDelete.addTarget(self, action: #selector(self.Delete(_:)), for: .touchDown)
            
            cell.btnEdit.tag = main_index

			cell.btnEdit.accessibilityHint = "\(indexPath.section)"

            print(main_index)
            cell.btnDelete.tag = main_index
            
            
            cell.lblCost.text = "\(dict_show.value(forKey: "price") as! String) SAR"
            cell.lbltitle.text = dict_show.value(forKey: "service_name") as? String
            cell.lblDuration.text = "Duration : \(dict_show.value(forKey: "duration") as! String)"
            cell.lblDetail.text = dict_show.value(forKey: "description") as? String
            
            
            return cell
        }
        
        
    }
    @IBAction func AddService(_ sender: UIButton) {


		lblAddServiceHeader.text = "\(sender.accessibilityHint!) Selection New Services"

        ViewAddService.isHidden = false
        bgView.isHidden = false
        Selected_Index = sender.tag
        txtDuration.text = ""
        txtDescription.text = ""
        txtPreice.text = ""
        txtService_name.text = ""
        
    }
    @IBAction func Edit(_ sender: UIButton) {
        let temp_dict = CollectionService[sender.tag] as! NSDictionary
        let dict_key_arr = temp_dict.allKeys
        let dict_i = dict_key_arr[0] as! String
        isEdit = true
        let dict = temp_dict.value(forKey: dict_i) as! NSDictionary
        
        ViewAddService.tag = sender.tag
        txtDuration.text = dict.value(forKey: "duration") as? String
        txtDescription.text = dict.value(forKey: "description") as? String
        txtPreice.text = dict.value(forKey: "price") as? String
        txtService_name.text = dict.value(forKey: "service_name") as? String
        ViewAddService.isHidden = false
        bgView.isHidden = false
		Selected_Index = Int(sender.accessibilityHint!)!
        
        
        
    }
    @IBAction func Delete(_ sender: UIButton) {
        
        CollectionService.removeObject(at: sender.tag)
        ServiceTableView.reloadData()
        
    }
  
    @IBAction func Duration(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .countDownTimer
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .allEvents)
    }
    
  
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        
        
        txtDuration.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func Add(_ sender: UIButton) {
        var i = Arr_count[sender.tag] as! Int
        
        i += 1
        
        Arr_count.replaceObject(at: sender.tag, with: i)
        PersonTableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        
        
        
    }
    @IBAction func Sub(_ sender: UIButton) {
        var i = Arr_count[sender.tag] as! Int
        if i != 1{
            i -= 1
            
            Arr_count.replaceObject(at: sender.tag, with: i)
            PersonTableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        }
    }
    @IBAction func SaveService(_ sender: Any) {

		if CheckTextField.Check_text(text: txtService_name.text!) && CheckTextField.Check_text(text: txtDescription.text!) && CheckTextField.Check_text(text: txtPreice.text!) && CheckTextField.Check_text(text: txtDuration.text!) && txtDuration.text!.contains(":"){

        ViewAddService.isHidden = true
        bgView.isHidden = true
        
        let dict = ["service_name" : txtService_name.text!,
                    "description" : txtDescription.text!,
                    "price" : txtPreice.text!,
                    "duration" : txtDuration.text!]
        
        let temp_dict = (Arr_Header[Selected_Index] as! NSDictionary).value(forKey: "Category") as! NSDictionary
        
        
        let temp_dic = [temp_dict.value(forKey: "id") as! String : dict]
			print(temp_dic)
        let temp_Arr = temp_dic
        
			print(temp_Arr)

        
        if isEdit == true{
            CollectionService.replaceObject(at: ViewAddService.tag, with: temp_Arr)
            isEdit = false
            
        }
        else{
            CollectionService.add(temp_Arr)
            
        }
        
        print(CollectionService)
        ServiceTableView.reloadData()
		}
    }
    
    @IBAction func BgButton(_ sender: Any) {
        ViewAddService.isHidden = true
        bgView.isHidden = true
        txtDuration.text = ""
        txtDescription.text = ""
        txtPreice.text = ""
        txtService_name.text = ""
    }
    @IBAction func UpdateSettings(_ sender: UIButton) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "SpecialOfferViewController") as! SpecialOfferViewController
		present(vc, animated: true, completion: nil)
    }
	@IBAction func Done(_ sender: Any) {
		Update()

	}
	func Update()  {
        
        
 
        
        
            
            
            
            self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
//            https://rotsys.com/api/customers/updateServiceOrder?user_id=236&register_order={%22max_persons%22:%223%22,%22max_services%22:%223%22,%22min_order%22:%2210.00%22}&lang=en&register_service={%22services%22:[{%221%22:{%22service_name%22:%22%D9%81%D8%BA%D8%AA%D9%84%D8%B2%22,%22description%22:%22%D9%87%D8%AA%D9%84%D8%BA%D8%AA%D8%B2%D9%85%D9%83%D8%A7%D9%84%22,%22price%22:%2210%22,%22duration%22:%2201:00%22}},{%222%22:{%22service_name%22:%22%D8%BA%D8%BA%D9%82%D8%AA%D8%AA%D9%86%22,%22description%22:%22%D8%A9%D9%88%D8%A7%D9%84%22,%22price%22:%2225%22,%22duration%22:%221:00%22}}]}
        
            let url1 = "http://rotsys.com/api/customers/updateServiceOrder?"
            
        let Dict = ["register_service" : ["services" : CollectionService], "register_order" : ["max_services" : txtServices.text! , "max_persons" : "\(Arr_count[0])" , "min_order": "\(Arr_count[1])"] , "lang" : "en","user_id" : CurrentUserID] as [String : Any]
        print(Dict)
            let params = NSDictionary.init(dictionary: Dict)
            
            // self.stopAnimating()
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    
               
                    
                    
                    for  (key, value)in params
                    {
                        
                        var val : String = ""
                        if value is String{
                            
                            val = value as! String
                        }
                        else{
                            
                            if let objectData = try? JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions(rawValue: 0)) {
                                let objectString = String(data: objectData, encoding: .utf8)
                                val = objectString!
                            }
                        }
                        multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key as! String)
                        print("*******  \(key) : \(value)")
                        //print("******* value = \(value)")
                    }
                    
                    print( params)
                    
            },
                to: url1 ,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            //print(response)
                            debugPrint(response)
                            
                            self.stopAnimating()
                            
                            self.stopAnimating()
                            if response.result.isSuccess
                            {
                                
                                let JSON = response.result.value as! NSDictionary
                                print("JSON: \(JSON)")
                                
                                if JSON.value(forKey: "response") as! String == "1"{
                                     NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
//                                    self.ServiceTableView.isUserInteractionEnabled = false
//                                    self.PersonTableView.isUserInteractionEnabled = false
                                }
                                else{
                                    dataModel.ToastAlertController(Message: JSON.value(forKey: "mesg") as! String, alertMsg: "")
                                }
                                
                                
                            }
                        }
                    case .failure(let encodingError):
                        //print(encodingError)
                        self.stopAnimating()
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
