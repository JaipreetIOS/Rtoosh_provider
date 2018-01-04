//
//  CalenderViewController.swift
//  RtooshProvider
//
//  Created by Apple on 08/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CalenderViewController: UIViewController , UITableViewDataSource , UITableViewDelegate, NVActivityIndicatorViewable {
    @IBOutlet weak var c_table_h: NSLayoutConstraint!
    var Selected_Index : Int = -1
    var Selected_Day : String = ""
    var Arr_schedule_time : NSMutableArray = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblScedule: CustomLabel_Light!
    @IBOutlet weak var SwitchVacation: UISwitch!
    @IBOutlet weak var SwitchOnline: UISwitch!
    @IBOutlet weak var SwitchSchedule: UISwitch!
    
    @IBOutlet weak var btnUpdateSch: UIButton!
    @IBOutlet weak var viewSchedule: BackView!
    
    @IBOutlet weak var txtCloseTime: UITextField!
    @IBOutlet weak var txtOpenTime: UITextField!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var bgView: UIButton!
    @IBOutlet weak var btnSave: CustomButton_Light!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(UINib.init(nibName: "ScheduleTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    
        tableView.isUserInteractionEnabled = false
        let arr = [
        [
        "day" : "Monday",
        "time":[ "open":"", "close":""   ]
        ],
        [
        "day" : "Tuesday",
        "time" : [ "open" : "","close" : "" ]
        ],
        [
        "day" : "Wednesday",
        "time" : ["open" : "","close" : ""]
        ],
        [
        "day" : "Thursday",
        "time" : ["open" : "","close" : ""]
        ],
        [
        "day" : "Friday",
        "time" : ["open" : "","close" : ""]
        ],
        [
        "day" : "Saturday",
        "time" : ["open" : "","close":""]
        ],
        [
        "day" : "Sunday",
        "time" : ["open"  : "" , "close" : ""]
        ]]
        Arr_schedule_time = NSMutableArray.init(array: arr)
        c_table_h.constant = 0
        viewSchedule.isHidden = true
        
        
        if CurrentUserData.value(forKey: "vacation_mode") as! String == "1"{
            SwitchVacation.isOn = true
			self.SwitchSchedule.isUserInteractionEnabled = false
			self.SwitchOnline.isUserInteractionEnabled = false
        }
        else{
            SwitchVacation.isOn = false
			self.SwitchSchedule.isUserInteractionEnabled = true
			self.SwitchOnline.isUserInteractionEnabled = true

			
        }
        if CurrentUserData.value(forKey: "work_online") as! String == "1"{
            SwitchOnline.isOn = true
        }
        else{
            SwitchOnline.isOn = false
            
        }
        if CurrentUserData.value(forKey: "work_schedule") as! String == "1"{
            
            if CurrentUserHours.count == 7{
            let arr = [
                [
                    "day" : (CurrentUserHours[0] as! NSDictionary).value(forKey: "day") as! String,
                    "time":[ "open":(CurrentUserHours[0] as! NSDictionary).value(forKey: "open") as! String, "close": (CurrentUserHours[0] as! NSDictionary).value(forKey: "close") as! String   ]
                ],
                [
                    "day" : (CurrentUserHours[1] as! NSDictionary).value(forKey: "day") as! String,
                    "time":[ "open":(CurrentUserHours[1] as! NSDictionary).value(forKey: "open") as! String, "close": (CurrentUserHours[1] as! NSDictionary).value(forKey: "close") as! String   ]
                ],
                [
                    "day" : (CurrentUserHours[2] as! NSDictionary).value(forKey: "day") as! String,
                    "time":[ "open":(CurrentUserHours[2] as! NSDictionary).value(forKey: "open") as! String, "close": (CurrentUserHours[2] as! NSDictionary).value(forKey: "close") as! String   ]
                ],
                [
                    "day" : (CurrentUserHours[3] as! NSDictionary).value(forKey: "day") as! String,
                    "time":[ "open":(CurrentUserHours[3] as! NSDictionary).value(forKey: "open") as! String, "close": (CurrentUserHours[3] as! NSDictionary).value(forKey: "close") as! String   ]
                ],
                [
                    "day" : (CurrentUserHours[4] as! NSDictionary).value(forKey: "day") as! String,
                    "time":[ "open":(CurrentUserHours[4] as! NSDictionary).value(forKey: "open") as! String, "close": (CurrentUserHours[4] as! NSDictionary).value(forKey: "close") as! String   ]
                ],
                [
                    "day" : (CurrentUserHours[5] as! NSDictionary).value(forKey: "day") as! String,
                    "time":[ "open":(CurrentUserHours[5] as! NSDictionary).value(forKey: "open") as! String, "close": (CurrentUserHours[5] as! NSDictionary).value(forKey: "close") as! String   ]
                ],
                [
                    "day" : (CurrentUserHours[6] as! NSDictionary).value(forKey: "day") as! String,
                    "time":[ "open":(CurrentUserHours[6] as! NSDictionary).value(forKey: "open") as! String, "close": (CurrentUserHours[6] as! NSDictionary).value(forKey: "close") as! String   ]
                ]]
            
            
            
            Arr_schedule_time = NSMutableArray.init(array: arr)
            }
            SwitchSchedule.isOn = true
            c_table_h.constant = 350
            
            viewSchedule.isHidden = false
            lblScedule.isHidden = true
        }
        else{
            SwitchSchedule.isOn = false
            c_table_h.constant = 0
            viewSchedule.isHidden = true
            lblScedule.isHidden = false
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func BAck(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyNavigationController") as! MyNavigationController
        self.present(vc , animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])

    }
    @IBAction func OpenTime(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleTimePickeropen(sender:)), for: .valueChanged)
        
        
    }
    @objc func handleTimePickeropen(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"
        
        
        
        txtOpenTime.text = dateFormatter.string(from: sender.date)
    }
    @IBAction func CloseTime(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleTimePickerClose(sender:)), for: .valueChanged)
        
        
    }
    @objc func handleTimePickerClose(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"
        
        
        
        txtCloseTime.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func SwitchSchedule(_ sender: UISwitch) {
        if sender.isOn {
           
            Schedule(status: "1")
            
        }
        else{
            
            Schedule(status: "0")
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arr_schedule_time.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScheduleTimeTableViewCell
        
        let dict = Arr_schedule_time[indexPath.row] as! NSDictionary
        
        cell.name.text = dict.value(forKey: "day") as? String
        cell.time.text = "\(String(describing: ((dict.value(forKey: "time") as? NSDictionary)?.value(forKey: "open"))!)) - \((dict.value(forKey: "time") as? NSDictionary)?.value(forKey: "close") ?? "")"
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bgView.isHidden = false
        viewTime.isHidden = false
        let dict = Arr_schedule_time[indexPath.row] as! NSDictionary
        
        Selected_Day = dict.value(forKey: "day") as! String
		if ((dict.value(forKey: "time") as? NSDictionary)?.value(forKey: "open") as! String) != ""{
        txtOpenTime.text = ((dict.value(forKey: "time") as? NSDictionary)?.value(forKey: "open") as! String)
        txtCloseTime.text = ((dict.value(forKey: "time") as? NSDictionary)?.value(forKey: "close") as! String)
		}
        Selected_Index = indexPath.row
    }
    @IBAction func BgButton(_ sender: Any) {
        bgView.isHidden = true
        viewTime.isHidden = true
       

        
    }
    @IBOutlet weak var AddTime: CustomButton_Light!
    @IBAction func Addtime(_ sender: Any) {
        if CheckTextField.Check_text(text: txtOpenTime.text!) && CheckTextField.Check_text(text: txtCloseTime.text!){
        bgView.isHidden = true
        viewTime.isHidden = true
        
        
    let dict =     [
            "day" : Selected_Day,
            "time":[ "open":txtOpenTime.text!, "close":txtCloseTime.text!   ]
        ] as [String : Any]
        
        Arr_schedule_time.replaceObject(at: Selected_Index, with: dict)
            tableView.reloadData()
        }
    }
    @IBAction func Cancel(_ sender: Any) {
        bgView.isHidden = true
        viewTime.isHidden = true
    }
    @IBAction func UpdateSchedule(_ sender: UIButton) {
        if sender.backgroundImage(for: .normal) == #imageLiteral(resourceName: "ic_action_mode_edit"){
            sender.setBackgroundImage(#imageLiteral(resourceName: "ic_action_check_red"), for: .normal)
           
            tableView.isUserInteractionEnabled = true
        }
        else{
            Update()
        }

    }
    func Update()  {
        //    http://rotsys.com/api/updateSchedule user_id, register_schedule_hours
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        var val : String = ""

        if let objectData = try? JSONSerialization.data(withJSONObject: Arr_schedule_time, options: JSONSerialization.WritingOptions(rawValue: 0)) {
            let objectString = String(data: objectData, encoding: .utf8)
            val = objectString!
        }
        
        let Dict = ["user_id" : CurrentUserID,
                    "register_schedule_hours" : val,
                    //                    "work_schedule" : ViewRating.rating,
            
            "lang" : "en" ] as [String : Any]
        print(Dict)
        
        dataModel.PostApi(Url: "apis/updateSchedule", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
					 NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
                    self.btnUpdateSch.setBackgroundImage(#imageLiteral(resourceName: "ic_action_mode_edit"), for: .normal)
                    self.tableView.isUserInteractionEnabled = false

                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
    }
    
    func OnlineMode(status : String)  {
        //     http://rotsys.com/api/updateWorkType
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        let Dict = ["user_id" : CurrentUserID,
                    "work_online" : status,
                    "work_schedule" : SwitchSchedule.isOn,
            
                    "lang" : "en" ] as [String : Any]
        print(Dict)
        
        dataModel.PostApi(Url: "apis/updateWorkType", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                if status == "0"{
                    self.SwitchOnline.isOn = true
                }
                else{
                    self.SwitchOnline.isOn = false
                    
                }
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
                     NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
                    if status == "1"{
                        self.SwitchOnline.isOn = true
                    }
                    else{
                        self.SwitchOnline.isOn = false

                    }
                   
                }
                else{
                    if status == "0"{
                        self.SwitchOnline.isOn = true
                    }
                    else{
                        self.SwitchOnline.isOn = false
                        
                    }
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
    }
    func Schedule(status : String)  {
        //      http://rotsys.com/api/apis/addFeedback?provider_id=32&user_id=31&rating=4&comment=gfgdfsgdfsg&lang=en
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        let Dict = ["user_id" : CurrentUserID,
                    "work_online" : SwitchOnline.isOn,
                                        "work_schedule" : status,
            
            "lang" : "en" ] as [String : Any]
        print(Dict)
        
        dataModel.PostApi(Url: "apis/updateWorkType", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                if status == "0"{
                    self.c_table_h.constant = 350
                    
                    self.viewSchedule.isHidden = false
                    self.lblScedule.isHidden = true
                    self.SwitchSchedule.isOn = true
                }
                else{
                    self.c_table_h.constant = 0
                    self.viewSchedule.isHidden = true
                    self.lblScedule.isHidden = false
                    self.SwitchSchedule.isOn = false
                    
                }
                
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
					 NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
                    if status == "1"{
                        self.c_table_h.constant = 350
                        
                        self.viewSchedule.isHidden = false
                        self.lblScedule.isHidden = true
                        self.SwitchSchedule.isOn = true
                    }
                    else{
                        self.c_table_h.constant = 0
                        self.viewSchedule.isHidden = true
                        self.lblScedule.isHidden = false
                        self.SwitchSchedule.isOn = false

                    }
                }
                else{
                    if status == "0"{
                        self.c_table_h.constant = 350
                        
                        self.viewSchedule.isHidden = false
                        self.lblScedule.isHidden = true
                        self.SwitchSchedule.isOn = true
                    }
                    else{
                        self.c_table_h.constant = 0
                        self.viewSchedule.isHidden = true
                        self.lblScedule.isHidden = false
                        self.SwitchSchedule.isOn = false
                        
                    }
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
    }
    func VactionMode(status : String)  {
        //   api/customers/vacationMode?user_id=94&type=1&lang=en
        
        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        let Dict = ["user_id" : CurrentUserID,
                    "type" : status,
                   
                    "lang" : "en" ] as [String : Any]
        print(Dict)
        
        dataModel.PostApi(Url: "customers/vacationMode?", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
            self.stopAnimating()
            
            if error == "Error"{
                dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")
                if status == "1"{
                    
                    
                    self.SwitchSchedule.isUserInteractionEnabled = true
                    self.SwitchOnline.isUserInteractionEnabled = true
                    self.SwitchVacation.isOn = false
                }
                else{
                    self.SwitchSchedule.isUserInteractionEnabled = false
                    self.SwitchOnline.isUserInteractionEnabled = false
                    self.SwitchVacation.isOn = true
                    
                }
            }
            else{
                if Data.value(forKey: "response") as! String == "1"{
					 NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
                    if status == "1"{
                        self.SwitchSchedule.isUserInteractionEnabled = false
                        self.SwitchOnline.isUserInteractionEnabled = false
                        self.SwitchVacation.isOn = true
                        

                    }
                    else{
                        self.SwitchSchedule.isUserInteractionEnabled = true
                        self.SwitchOnline.isUserInteractionEnabled = true
                        self.SwitchVacation.isOn = false

                    }
                    
                }
                else{
                    if status == "1"{
                      
                        
                        self.SwitchSchedule.isUserInteractionEnabled = true
                        self.SwitchOnline.isUserInteractionEnabled = true
                        self.SwitchVacation.isOn = false
                    }
                    else{
                        self.SwitchSchedule.isUserInteractionEnabled = false
                        self.SwitchOnline.isUserInteractionEnabled = false
                        self.SwitchVacation.isOn = true
                        
                    }
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
    }
    
    @IBAction func SwitchVication(_ sender: UISwitch) {
        if sender.isOn == true{
            VactionMode(status: "1")
        }
        else{
            VactionMode(status: "0")

        }
        
        
    }
    @IBAction func SwitchOnline(_ sender: UISwitch) {
        if sender.isOn == true{
            OnlineMode(status: "1")
        }
        else{
            OnlineMode(status: "0")
            
        }
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
