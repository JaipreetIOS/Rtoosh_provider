//
//  ScheduleTimeViewController.swift
//  RtooshProvider
//
//  Created by Apple on 01/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit



class ScheduleTimeViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var txtCloseTime: UITextField!
    @IBOutlet weak var txtOpenTime: UITextField!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var bgView: UIButton!
    @IBOutlet weak var btnSave: CustomButton_Light!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let day_Arr = ["Monday", "Tuesday", "Wednesday" , "Thursday" , "Friday" , "Saturday" , "Sunday"]
    let Time_Arr : NSMutableArray = ["-", "-", "-" , "-" , "-" , "-" , "-"]
    var Selected_Index : Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ScheduleTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
        bgView.isHidden = true
        viewTime.isHidden = true
        
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
        Register_Schedule_Time = NSMutableArray.init(array: arr)
        
        viewTime.layer.cornerRadius = 8
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any) {
        
        
        ScRegisteheduleTimeRegister = Register_Schedule_Time
        
        dismiss(animated: true, completion: nil)

        
    }
    @IBOutlet weak var Save: CustomButton_Light!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Register_Schedule_Time.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScheduleTimeTableViewCell
        
        let dict = Register_Schedule_Time[indexPath.row] as! NSDictionary
        
        cell.name.text = dict.value(forKey: "day") as? String
        cell.time.text = "\(String(describing: ((dict.value(forKey: "time") as? NSDictionary)?.value(forKey: "open"))!)) - \((dict.value(forKey: "time") as? NSDictionary)?.value(forKey: "close") ?? "")"

        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bgView.isHidden = false
        viewTime.isHidden = false
        Selected_Index = indexPath.row
    }
    @IBAction func BgButton(_ sender: Any) {
        bgView.isHidden = true
        viewTime.isHidden = true
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func CancelTime(_ sender: Any) {
        bgView.isHidden = true
        viewTime.isHidden = true
        txtOpenTime.text = ""
        txtCloseTime.text = ""

    }
    @IBAction func AddTime(_ sender: Any) {
        bgView.isHidden = true
        viewTime.isHidden = true
        
        
        let dict = Register_Schedule_Time[Selected_Index] as! NSDictionary
        
        let dict_temp = ["day" : dict.value(forKey: "day") as! String,
                         "time" : ["open"  : "\(txtOpenTime.text!)" , "close" : "\(txtCloseTime.text!)"]] as [String : Any]

        
        
        
        Register_Schedule_Time.replaceObject(at: Selected_Index, with: dict_temp)
        tableView.reloadData()
        
        
    }
    @IBAction func ClosingTime(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)
        
        
    }
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"

        
        
        txtCloseTime.text = dateFormatter.string(from: sender.date)
    }
    @IBAction func OpeningTime(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleTimePickerClose(sender:)), for: .valueChanged)
        
        
    }
    @objc func handleTimePickerClose(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"
        
        
        
        txtOpenTime.text = dateFormatter.string(from: sender.date)
    }
}
