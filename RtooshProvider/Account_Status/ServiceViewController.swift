//
//  ServiceViewController.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var txtDuration: SimpleTextField!
    @IBOutlet weak var txtPreice: SimpleTextField!
    @IBOutlet weak var txtDescription: SimpleTextField!
    @IBOutlet weak var txtService_name: SimpleTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ViewAddService: BackView!
    @IBOutlet weak var bgView: UIView!
    var Arr_Header = ["Hair", "Makeup" , "Nails"]
    var Arr_Header_image = [#imageLiteral(resourceName: "ic_profile_hair"), #imageLiteral(resourceName: "ic_profile_makeup") , #imageLiteral(resourceName: "ic_profile_nailpaints")]
    var Selected_Index : Int = -1
    var Arr_Hair : NSMutableArray = []
    var Arr_MakeUp : NSMutableArray = []
    var Arr_Nails : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "SreviceListTableViewCell", bundle: nil) , forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveService(_ sender: Any) {
        ViewAddService.isHidden = true
        bgView.isHidden = true
        
        let dict = ["Service_name" : txtService_name.text!,
                    "Price" : txtPreice.text!,
                    "Duration" : txtDuration.text!,
                    "Description" : txtDescription.text!]
        
        switch Selected_Index {
        case 0:
            Arr_Hair.add(dict)
        case 1:
            Arr_MakeUp.add(dict)

        default:
            Arr_Nails.add(dict)

        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Arr_Header.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let vie = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        vie.backgroundColor = UIColor.clear
       let main_view = UIView.init(frame: CGRect.init(x: 8, y: 4, width: tableView.frame.size.width - 16, height: 42))
        main_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        main_view.layer.cornerRadius = 4
        main_view.layer.borderWidth = 2
        main_view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        main_view.layer.masksToBounds = true
        
        
        let bgImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 42, height: 42))
        bgImg.image = #imageLiteral(resourceName: "nav_barHome")
        main_view.addSubview(bgImg)
     
        let LogoImg = UIImageView.init(frame: CGRect.init(x: 8, y: 8, width: 42 - 16, height: 42 - 16))
        LogoImg.image = Arr_Header_image[section]
        main_view.addSubview(LogoImg)
        
        let lbl_title = UILabel.init(frame: CGRect.init(x: 50, y: 0, width: 100, height: 42))
        lbl_title.text = Arr_Header[section]
//        lbl_title.font =  UIFont.init(name: "Bold", size: 15)!
        main_view.addSubview(lbl_title)
        
        let line_view = UIView.init(frame: CGRect.init(x: main_view.frame.size.width - 43, y: 6, width: 1, height: 30))
        line_view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        main_view.addSubview(line_view)

        
        let AddBtn = UIButton.init(frame: CGRect.init(x: main_view.frame.size.width - 43, y: 0, width: 40, height: 40))
//        AddBtn.titleLabel?.font = UIFont.init(name: "avenir-lt-65-medium-5969f31f07372", size: 15)!
        AddBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        AddBtn.setTitle("+", for: .normal)
        AddBtn.setTitleColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), for: .normal)
        AddBtn.addTarget(self, action: #selector(self.Add(_:)), for: .touchDown)
        AddBtn.tag = section
        main_view.addSubview(AddBtn)
        
        vie.addSubview(main_view)
        return vie
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Arr_Hair.count
        case 1:
            return Arr_MakeUp.count
        default:
            return Arr_Nails.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SreviceListTableViewCell
        cell.selectionStyle = .none
        let dict : NSDictionary!
        switch indexPath.section {
        case 0:
            dict = Arr_Hair[indexPath.row] as! NSDictionary
            
        case 1:
            dict = Arr_MakeUp[indexPath.row] as! NSDictionary


        default:
            dict = Arr_Nails[indexPath.row] as! NSDictionary


        }
        cell.lblCost.text = "$\((dict.value(forKey: "Price") as? String)!)"
        cell.lbltitle.text = dict.value(forKey: "Service_name") as? String
        cell.lblDuration.text = "Duration : \((dict.value(forKey: "Duration") as? String)!)"
        cell.lblDetail.text = dict.value(forKey: "Description") as? String

        
        return cell
    }
    @IBAction func Add(_ sender: UIButton) {
        ViewAddService.isHidden = false
        bgView.isHidden = false
        Selected_Index = sender.tag
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
