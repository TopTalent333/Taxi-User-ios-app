//
//  CreateDemoDriverViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 26/07/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class CreateDemoDriverViewController: UIViewController,MainCategoryProtocol {
    
    
    
    @IBOutlet weak var innerview: UIView!
    
  
    var logindata : SignupLoginResponse!

    var drivername = ""
    var driverphone = ""
    
    @IBOutlet weak var enterdrivername: UITextField!
    
    @IBOutlet weak var enterdriveremailphone: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerview.layer.cornerRadius = 5
        innerview.clipsToBounds = true
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbtn(_ sender: Any) {
       
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okbtn_click(_ sender: Any) {
        
        drivername = enterdrivername.text!
        driverphone = enterdriveremailphone.text!
        
         let uniqueid =  UserDefaults.standard.string(forKey: "unique_number")
        
        let dic=[ DemoUserUrl1:"\(driverphone)",
            DemoUserUrl2:"\(driverphone)",
            DemoUserUrl3:"\(drivername)",
            DemoUserUrl4:"\(uniqueid!)",
            
            ]
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.postData(dictonary: dic as NSDictionary, url: DemoUserUrl)
        
       
        
    }
    
    @IBAction func Skipbtn_click(_ sender: Any) {
        
        drivername = enterdrivername.text!
        driverphone = enterdriveremailphone.text!
        
        let uniqueid =  UserDefaults.standard.string(forKey: "unique_number")
        
        let dic=[ DemoUserUrl1:"\(driverphone)",
            DemoUserUrl2:"\(driverphone)",
            DemoUserUrl3:"\(drivername)",
            DemoUserUrl4:"\(uniqueid!)",
            DemoUserUrl5:"\(GlobalVarible.languagecode)"
            
        ]
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.postData(dictonary: dic as NSDictionary, url: DemoUserUrl)

        
       
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
        
        logindata = data as! SignupLoginResponse
        
       
            
            if logindata.result == 1{
                
                let userid = logindata.details!.userId
                
                let UserDeviceKey = UserDefaults.standard.string(forKey: "device_key")
                
                
                print(UserDeviceKey!)
                
                let uniqueid =  UserDefaults.standard.string(forKey: "unique_number")
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.UserDeviceId(USERID: userid!, USERDEVICEID: UserDeviceKey! , FLAG: "1",UNIQUEID: uniqueid!)
                
                
                
                NsUserDekfaultManager.SingeltionInstance.loginuser(user_id: self.logindata.details!.userId!,name: self.logindata.details!.userName!, image: (self.logindata.details?.userImage)!, email: self.logindata.details!.userEmail!, phonenumber: (self.logindata.details?.userPhone!)!, status: self.logindata.details!.status!,password: self.logindata.details!.userPassword!,facbookimage: (self.logindata.details?.facebookImage!)!, googleimage: (self.logindata.details?.googleImage)!)
                
                
                
                GlobalVarible.movefromdemouser = "demouser"
                /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let revealViewController:MapViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                 
                 self.present(revealViewController, animated:true, completion:nil)*/
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                
                if let window = self.view.window{
                    window.rootViewController = nextController
                }
                
                
                
            }else{
                self.showalert(message: logindata.message!)
                
            }
            
        }
        
    

   
}
