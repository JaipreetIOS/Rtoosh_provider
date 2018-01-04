//
//  SpecialOfferViewController.swift
//  RtooshProvider
//
//  Created by Apple on 27/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SpecialOfferViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , NVActivityIndicatorViewable {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var bgButton: UIButton!
	@IBOutlet weak var viewSpecial: UIView!
	@IBOutlet weak var txtCost: UITextField!
	var TempServiceArray : NSMutableArray = []
	var HasSpecial : Bool = false
	var service_id : String = ""
	var SelectedIndex : Int = -1
	@IBOutlet weak var btnAddSpecial: CustomButton_Light!
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.register(UINib.init(nibName: "SpecialOfferTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
		tableView.separatorStyle = .none
//		GetServiceList()
		print(CurrentUserServices)
        // Do any additional setup after loading the view.
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
					 self.TempServiceArray = NSMutableArray.init(array: Data.value(forKey: "data") as!  NSArray)





					print(self.TempServiceArray)
					self.tableView.reloadData() 



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
	@IBAction func Back(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	@IBAction func BGButton(_ sender: Any) {
		bgButton.isHidden = true
		viewSpecial.isHidden = true

	}

	@IBAction func AddSpecial(_ sender: Any) {

//
		if CheckTextField.Check_text(text: txtCost.text!){

		if btnAddSpecial.title(for: .normal) == "Remove Special"{
			AddSpecial(Service_id : service_id , special : "0")
		}
		else{
			AddSpecial(Service_id : service_id , special : "1")
		}
		}

	}
	override func viewDidDisappear(_ animated: Bool) {
   NotificationCenter.default.post(name: Notification.Name(NotificationUserGetData), object: nil, userInfo: [:])
	}
	func AddSpecial(Service_id : String , special : String)  {
//		user_id, service_id, price, special
		let Dict = [
			"user_id" : CurrentUserID,
			"service_id" : Service_id,
			"price" : txtCost.text!,
			"special" : special,

			"lang" : "en"
		]
		self.startAnimating(CGSize(width: 30, height:30), message: "Loading..", type: NVActivityIndicatorType.ballClipRotateMultiple)
		print(Dict)
		dataModel.GEtApi(Url: "apis/addSpecial", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
			self.stopAnimating()

			if error == "Error"{
				self.stopAnimating()

				dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")

			}
			else{
				if Data.value(forKey: "response") as! String != "0"{
					print(Data)
					self.bgButton.isHidden = true
					self.viewSpecial.isHidden = true

					self.HasSpecial = false

					let dict = NSMutableDictionary.init(dictionary:  CurrentUserServices[self.SelectedIndex] as! NSDictionary)

					dict.removeObject(forKey: "special")
					dict.setValue(special, forKey: "special")


					dict.removeObject(forKey: "price")
					dict.setValue(self.txtCost.text!, forKey: "price")

					CurrentUserServices.replaceObject(at: self.SelectedIndex, with: dict)

					self.tableView.reloadData()
//					self.GetUserData()

				}
				else{

					dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

				}
			}
		})


	}
	func GetUserData()  {
		//      apis/getUser?user_id=66&lang=en




		let Dict = ["user_id" : CurrentUserID, "lang" : "en"]
		//            print(Dict)
		//            name=Himanshu kumar&email=himanshukumar@gmail.com&password=123456

		dataModel.PostApi(Url: "apis/getUser", dict: Dict as NSDictionary, withCompletionHandler: { (Data, error) in
			self.stopAnimating()

			if error == "Error"{
				dataModel.ToastAlertController(Message: "", alertMsg: "Something worng!, Try after sometime")

			}
			else{
				if Data.value(forKey: "response") as! String == "1"{
					print("Data=== \(Data)")
					let dict = Data.value(forKey: "data") as!  NSDictionary
					let dataservies  = dict.value(forKey: "Service") as!  NSArray



					CurrentUserServices = NSMutableArray.init(array:  dataservies)

					self.tableView.reloadData()





				}
				else{
					dataModel.ToastAlertController(Message: "", alertMsg: Data.value(forKey: "mesg") as! String)

				}
			}
		})




	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return CurrentUserServices.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 236
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpecialOfferTableViewCell
		cell.selectionStyle = .none

		let data = CurrentUserServices[indexPath.row] as! NSDictionary
		let dict = data.value(forKey: "Category") as! NSDictionary
//
		cell.NAME.text = data.value(forKey: "service_name") as? String
		cell.CatName.text = data.value(forKey: "service_name") as? String
		cell.img.sd_setImage(with: URL.init(string: dict.value(forKey: "image") as! String), placeholderImage: #imageLiteral(resourceName: "nav_barHome"))
		cell.liteName.text = data.value(forKey: "description") as? String
		cell.duration.text = data.value(forKey: "duration") as? String

		cell.cost.text = "\(data.value(forKey: "price") as! String) SAR"
		if data.value(forKey: "special") as! String == "1"{
			cell.bgView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.1098039216, blue: 0.1411764706, alpha: 1)
			cell.bgView.layer.borderWidth = 1
			HasSpecial = true
		}
		else{
			cell.bgView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			cell.bgView.layer.borderWidth = 1


		}


		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let data = CurrentUserServices[indexPath.row] as! NSDictionary
		SelectedIndex = indexPath.row

		if data.value(forKey: "special") as! String == "1"{
			btnAddSpecial.setTitle("Remove Special", for: .normal)
		bgButton.isHidden = false
		viewSpecial.isHidden = false
			txtCost.text = data.value(forKey: "price") as? String
			service_id = data.value(forKey: "id") as! String
			return
		}
		if HasSpecial == false {
			btnAddSpecial.setTitle("Add Special", for: .normal)
			bgButton.isHidden = false
			viewSpecial.isHidden = false
			txtCost.text = data.value(forKey: "price") as? String

			service_id = data.value(forKey: "id") as! String

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
