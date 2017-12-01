

//
//  ScheduleViewController.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    let Arr_title = ["Maximum persons per order" , "Maximum service per order"]
    let Arr_detail = ["How much persons you want to surve per order" ,  "How much services you want to provide per order"]
    let Arr_person = ["Person" ,  "Service"]
    
    let Arr_count = [0 ,  0]

    
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
        return cell
        
        
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
