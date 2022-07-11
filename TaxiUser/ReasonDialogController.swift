//
//  ReasonDialogController.swift
//  TaxiUser
//
//  Created by AppOrio on 24/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import Firebase

class ReasonDialogController: UIViewController,UITableViewDataSource,UITableViewDelegate,MainCategoryProtocol  {
    
    var reasonData: ReasonModel!
    
    var usercanceldata: BookingCancelled!
    
    var rentalcanceldata: RentalRideCancelModel!
    
   
     var ref = FIRDatabase.database().reference()
    
  
    var SIZE = 0
    
    var check = 1000
    
     var movefrom = ""
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cancel_btn: UIButton!
    
    @IBOutlet weak var notCancel_btn: UIButton!
    
    
    @IBOutlet weak var selectreasonlabel: UILabel!
    
     let  Userid =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)!


    override func viewDidLoad() {
        super.viewDidLoad()

        
        selectreasonlabel.text = NSLocalizedString("Select Reason", comment: "")
        
        //   NSLocalizedString("Cancel", comment: "")
        
        self.cancel_btn.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        
        self.notCancel_btn.setTitle(NSLocalizedString("Don't Cancel", comment: ""), for: .normal)
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        cancel_btn.isEnabled = false
        cancel_btn.layer.backgroundColor = ReasonDialogController.getColorFromHex(hexString: "#979897").cgColor
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.reasonCancel()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func getColorFromHex(hexString:String)->UIColor{
        
        var rgbValue : UInt32 = 0
        let scanner:Scanner =  Scanner(string: hexString)
        
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    @IBAction func donotcancelclickbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelclickbtn(_ sender: Any) {
        
        if movefrom == "Rentaltype"{
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.RentalUserCancel(RentalBookindId: GlobalVarible.RideId, UserId: self.Userid)

        
        }else{
            
            
        ApiManager.sharedInstance.protocolmain_Catagory = self
        
        ApiManager.sharedInstance.CancelRide(RIDEID: GlobalVarible.RideId, RIDESTATUS: "2")
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return SIZE
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reasonCell", for: indexPath) as! ReasonCell
        cell.selectionStyle = .none
        cell.reasonText.text = self.reasonData.msg![indexPath.row].reasonName!
        
        if(check == indexPath.row)
        {
            
            cell.checkRadioBtn.image = UIImage(named: "Circled Dot-35 (1)")
            
        }else{
            cell.checkRadioBtn.image = UIImage(named: "Circle Thin-35 (1)")
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
       // let cells = tableView.cellForRow(at: indexPath) as! ReasonCell
        let row = indexPath.row
        check = indexPath.row
        print("Row:\(row)")
        cancel_btn.isEnabled = true
        GlobalVarible.cancelId = self.reasonData.msg![row].reasonId!
        print(GlobalVarible.cancelId)
        cancel_btn.layer.backgroundColor = ReasonDialogController.getColorFromHex(hexString: "#370039").cgColor
        tableView.reloadData()
        
        
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
    
    
    func showalert1(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
                
               /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:MapViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                
                self.present(revealViewController, animated:true, completion:nil)*/
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                
                if let window = self.view.window{
                    window.rootViewController = nextController
                }

                
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
        
        if(GlobalVarible.Api == "cancelreason"){
            
            reasonData = data as! ReasonModel
            
            if reasonData.result == 1{
                
                if let size = reasonData.msg?.count
                {
                    SIZE = size
                    
                }
                
                self.tableView.reloadData()
                
                
            }

        }
        if(GlobalVarible.Api == "Cancelbyuser"){
            
            usercanceldata = data as! BookingCancelled
            
            if(usercanceldata.result == 1){
                
                GlobalVarible.checkRideId = "0"
                
                UserDefaults.standard.setValue("0", forKey:"firebaseride_status")
                
                
                let Message: NSDictionary = ["changed_destination": "0","ride_id": GlobalVarible.RideId,"ride_status": "2","done_ride_id": ""]
                
                self.ref.child("RideTable").child(GlobalVarible.RideId).setValue(Message)
                
                

                
                self.showalert1(message: self.usercanceldata.msg!)
                
              
                
                //self.dismissViewControllerAnimated(true, completion: nil)
                
            }else{
                
                self.showalert(message: self.usercanceldata.msg!)
            }
            
        
        }
        
        if(GlobalVarible.Api == "rentalCancelbyuser"){
            
            rentalcanceldata = data as! RentalRideCancelModel
            
            if(self.rentalcanceldata.status == 1){
                
                
                
                let Message: NSDictionary = ["changed_destination": "0","ride_id": GlobalVarible.RideId,"ride_status": "15","done_ride_id": ""]
                
                self.ref.child("RideTable").child(GlobalVarible.RideId).setValue(Message)
                

            
            self.showalert1(message: self.rentalcanceldata.message!)
                
            }else{
                
            self.showalert(message: self.rentalcanceldata.message!)
            }
            
        
        
        }

        
    }


}
