//
//  ServiceViewController.swift
//  RtooshProvider
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SDWebImage

var Main_ServiceArray : NSMutableArray = []


class ServiceViewController: UIViewController, UITableViewDataSource , UITableViewDelegate , NVActivityIndicatorViewable{

    @IBOutlet weak var txtDuration: SimpleTextField!
    @IBOutlet weak var txtPreice: SimpleTextField!
    @IBOutlet weak var txtDescription: SimpleTextField!
    @IBOutlet weak var txtService_name: SimpleTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ViewAddService: BackView!
    @IBOutlet weak var bgView: UIView!
    
    var isEdit : Bool = false
    
    var TempServiceArray : NSMutableArray = []

    var Arr_Header : NSMutableArray = []
    var Arr_Header_image = [#imageLiteral(resourceName: "ic_profile_hair"), #imageLiteral(resourceName: "ic_profile_makeup") , #imageLiteral(resourceName: "ic_profile_nailpaints")]
    var Selected_Index : Int = -1
    var Arr_Hair : NSMutableArray = []
    var Arr_MakeUp : NSMutableArray = []
    var Arr_Nails : NSMutableArray = []
    var Arr_duration : NSMutableArray = []


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "SreviceListTableViewCell", bundle: nil) , forCellReuseIdentifier: "Cell")
        GetServiceList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func GetServiceList()  {
        let Dict = [
                    "lang" : "en"
                  ]
//        self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
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
                    self.tableView.reloadData()
                    
                    
                    
                }
                else{
                    dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)
                    
                }
            }
        })
        
        
    }
    @IBAction func SaveService(_ sender: Any) {
        ViewAddService.isHidden = true
        bgView.isHidden = true
        
        let dict = ["service_name" : txtService_name.text!,
                    "description" : txtDescription.text!,
                    "price" : txtPreice.text!,
                    "duration" : txtDuration.text!]
        
        let temp_dict = (Arr_Header[Selected_Index] as! NSDictionary).value(forKey: "Category") as! NSDictionary

        
        let temp_dic = [temp_dict.value(forKey: "id") as! String : dict]
        let temp_Arr = temp_dic
        


        if isEdit == true{
        Main_ServiceArray.replaceObject(at: Selected_Index, with: temp_Arr)
            isEdit = false

        }
        else{
            Main_ServiceArray.add(temp_Arr)

        }

        print(Main_ServiceArray)
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
        AddBtn.addTarget(self, action: #selector(self.Add(_:)), for: .touchDown)
        AddBtn.tag = section
        main_view.addSubview(AddBtn)
        
        vie.addSubview(main_view)
        return vie
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return Arr_Hair.count
//        case 1:
//            return Arr_MakeUp.count
//        default:
//            return Arr_Nails.count
//        }
        
        
        let dict_return : NSMutableDictionary = [:]
        var arr_return : NSMutableArray = []
        
        for i in Main_ServiceArray{
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SreviceListTableViewCell
        cell.selectionStyle = .none

        
        let dict_return : NSMutableDictionary = [:]
        var arr_return : NSMutableArray = []
        
        for i in Main_ServiceArray{
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
        
        for i in 0..<Main_ServiceArray.count {
            let dict = Main_ServiceArray[i] as! NSDictionary
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
        print(main_index)
        cell.btnDelete.tag = main_index

        
        cell.lblCost.text = "\(dict_show.value(forKey: "price") as! String) SAR"
        cell.lbltitle.text = dict_show.value(forKey: "service_name") as? String
        cell.lblDuration.text = "Duration : \(dict_show.value(forKey: "duration") as! String)"
        cell.lblDetail.text = dict_show.value(forKey: "description") as? String

        
        return cell
    }
    @IBAction func Add(_ sender: UIButton) {
        ViewAddService.isHidden = false
        bgView.isHidden = false
        Selected_Index = sender.tag
        txtDuration.text = ""
        txtDescription.text = ""
        txtPreice.text = ""
        txtService_name.text = ""
        
    }
    @IBAction func Edit(_ sender: UIButton) {
        let temp_dict = Main_ServiceArray[sender.tag] as! NSDictionary
        let dict_key_arr = temp_dict.allKeys
        let dict_i = dict_key_arr[0] as! String
        isEdit = true
        let dict = temp_dict.value(forKey: dict_i) as! NSDictionary
        
        
        txtDuration.text = dict.value(forKey: "duration") as? String
        txtDescription.text = dict.value(forKey: "description") as? String
        txtPreice.text = dict.value(forKey: "price") as? String
        txtService_name.text = dict.value(forKey: "service_name") as? String
        ViewAddService.isHidden = false
        bgView.isHidden = false
        Selected_Index = sender.tag

        
       
    }
    @IBAction func Delete(_ sender: UIButton) {
        
        Main_ServiceArray.removeObject(at: sender.tag)
        tableView.reloadData()
       
    }
    
    @IBAction func Duration(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .countDownTimer
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .allEvents)
        
        
    }
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        
        
        
        txtDuration.text = dateFormatter.string(from: sender.date)
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
