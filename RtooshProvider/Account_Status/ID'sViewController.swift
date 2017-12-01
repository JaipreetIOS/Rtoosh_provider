//
//  ID'sViewController.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ID_sViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
   
    
    @IBOutlet weak var btnOnline: RadioButton!
    @IBOutlet weak var btnAddSchedule: SelectButton!
    @IBOutlet weak var txtIdNumber: SimpleTextField!
    @IBOutlet weak var TxtIdType: SimpleTextField!
    @IBOutlet weak var txtIssueDate: SimpleTextField!
    var pickerView = UIPickerView()
    var pickOption = ["one", "two", "three", "seven", "fifteen"]

    @IBOutlet weak var btnUploadImage: SelectButton!
    @IBOutlet weak var btnSchedule: RadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddSchedule.isHidden = true

        pickerView.delegate = self
        
        
        
//        txtIssueDate.inputView = UIDatePicker()
        

        TxtIdType.inputView = pickerView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func IssueDate(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)


    }
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        
        
        
        txtIssueDate.text = dateFormatter.string(from: sender.date)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    private func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TxtIdType.text = pickOption[row]
    }
    @IBAction func ScheduleTime(_ sender: Any) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScheduleTimeViewController") as! ScheduleTimeViewController
        present(vc, animated: true, completion: nil)
        
 
        
    }
    @IBAction func Online(_ sender: Any) {
        btnOnline.Selected_Image = #imageLiteral(resourceName: "ic_check_service")
        btnSchedule.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")
        btnAddSchedule.isHidden = true

    }
    @IBAction func Schedule(_ sender: Any) {
        btnOnline.Selected_Image = #imageLiteral(resourceName: "ic_register_uncheck_service")
        btnSchedule.Selected_Image = #imageLiteral(resourceName: "ic_check_service-1")
        
        btnAddSchedule.isHidden = false
    }
    
    @IBAction func upload(_ sender: Any) {
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
