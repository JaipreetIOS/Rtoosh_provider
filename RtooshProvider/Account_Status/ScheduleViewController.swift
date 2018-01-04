

//
//  ScheduleViewController.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit


var Register_Schedule : NSMutableDictionary! = [:]



class ScheduleViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {

    let Arr_title = ["Maximum persons per order" , "Maximum service per order"]
    let Arr_detail = ["How much persons you want to surve per order" ,  "How much services you want to provide per order"]
    let Arr_person = ["Person" ,  "Service"]
    
    let Arr_count : NSMutableArray = [1 ,  1]

    @IBOutlet weak var txtMin: SimpleTextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "SceduleTableViewCell", bundle: nil) , forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    @IBAction func Add(_ sender: UIButton) {
        var i = Arr_count[sender.tag] as! Int

        i += 1

        Arr_count.replaceObject(at: sender.tag, with: i)
        tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        
        
        
    }
    @IBAction func Sub(_ sender: UIButton) {
        var i = Arr_count[sender.tag] as! Int
        if i != 1{
        i -= 1
        
        Arr_count.replaceObject(at: sender.tag, with: i)
        tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Register_Schedule.setValue(txtMin.text!, forKey: "min_order")

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
