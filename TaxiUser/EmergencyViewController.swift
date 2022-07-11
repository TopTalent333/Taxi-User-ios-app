//
//  EmergencyViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 23/08/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import DropDown

class EmergencyViewController: UIViewController,MainCategoryProtocol {
    
    
    var emergencycontactdata: EmergencyResponseModel!
    
    @IBOutlet weak var selectemergencytext: UILabel!
    
    @IBOutlet weak var dropdownview: UIView!
    let dropDown = DropDown()
    
    
    
    @IBOutlet weak var callyouremergencytext: UILabel!
    
    let  Userid =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)!
    
    @IBOutlet weak var closebtnview: UIView!
    
    var PhoneNumber = ""
    
    var emergencylistarray = [String]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.closebtnview.layer.borderWidth = 1.0
        self.closebtnview.layer.cornerRadius = 4
        self.closebtnview.layer.backgroundColor = UIColor.lightGray.cgColor
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.EmergencyContactUrl()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SelectEmergencybtn_click(_ sender: Any) {
        
        dropDown.anchorView = dropdownview
        dropDown.topOffset = CGPoint(x:0, y: self.dropdownview.bounds.height)
        
        self.dropDown.width = 200
        self.dropDown.cellHeight = 50
        
        
        self.dropDown.show()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.PhoneNumber = self.emergencycontactdata!.details![index].sosNumber!
            
            
            self.selectemergencytext.text = self.emergencycontactdata!.details![index].sosNumber!
            
            self.callyouremergencytext.text = self.emergencycontactdata!.details![index].sosName!
            
            print(self.PhoneNumber)
            
            
            self.dropDown.hide()
        }
        
        
    }
    
    
    
    @IBAction func callPoliceControl_btn(_ sender: Any) {
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.EmergencyContactMessageUrl(RideId: GlobalVarible.RideId, DriverId: GlobalVarible.DRIVERID, UserId: self.Userid, SOSNUMBER: "100",Latitude: GlobalVarible.emergencylatitude,Longitude: GlobalVarible.emergencylongitude)
        
        
        if let url = URL(string: "telprompt://\("100")") {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func callyouremergency_btn(_ sender: Any) {
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.EmergencyContactMessageUrl(RideId: GlobalVarible.RideId, DriverId: GlobalVarible.DRIVERID, UserId: self.Userid, SOSNUMBER: self.PhoneNumber,Latitude: GlobalVarible.emergencylatitude,Longitude: GlobalVarible.emergencylongitude)
        
        if let url = URL(string: "telprompt://\(self.PhoneNumber)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func Close_btn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showalert(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    func onProgressStatus(value: Int) {
        if(value == 0 ){
            MBProgressHUD.hide(for: self.view, animated: true)
        }else if (value == 1){
            let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
            spinnerActivity.detailsLabel.text = NSLocalizedString("Please Wait!!", comment: "")
            spinnerActivity.isUserInteractionEnabled = false
            
        }
    }
    
    func onSuccessExecution(msg: String) {
        print("\(msg)")
    }
    
    
    func onerror(msg : String) {
        MBProgressHUD.hide(for: self.view, animated: true)
        
        self.showalert(message: msg)
        
    }
    
    
    
    func onSuccessParse(data: AnyObject) {
        
        self.emergencycontactdata = data as! EmergencyResponseModel
        
        if self.emergencycontactdata.status == 1 {
            
            emergencylistarray.removeAll()
            
            for items in  self.emergencycontactdata.details!
            {
                
                
                emergencylistarray.append(items.sosName!)
                
                
                dropDown.dataSource = emergencylistarray
                
            }
        }
        
        
    }
    
    

    

   
}
