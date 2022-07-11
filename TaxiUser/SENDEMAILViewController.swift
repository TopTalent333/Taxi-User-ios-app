//
//  SENDEMAILViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 26/07/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class SENDEMAILViewController: UIViewController,MainCategoryProtocol {
    
    
    @IBOutlet weak var enteremailtext: UITextField!
    
      var mailinvoicedata: MailInvoiceModel!
    
    var donerideid = ""
    
    @IBOutlet weak var innerview: UIView!
    
    var useremail = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        useremail = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyemail)!
        
        enteremailtext.text! = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyemail)!
        
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
    

    @IBAction func cancelbtn_click(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func sendbtn_click(_ sender: Any) {
        
        useremail = enteremailtext.text!
        
        if useremail == ""{
        
        showalert(message: NSLocalizedString("Please enter email first", comment : ""))
            
        }else{
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.Mailinvoice(DoneRideId: donerideid, UserEmail: useremail)
            
        }
        
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
                self.dismiss(animated: true, completion: nil)
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
        
        if(GlobalVarible.Api == "mailinvoice"){
            
            mailinvoicedata = data as! MailInvoiceModel
            
            if (mailinvoicedata.result == 1){
                
                showalert1(message: mailinvoicedata.msg!)
                
            }else{
                
                showalert(message: mailinvoicedata.msg!)
                
            }
            
            
            
        }

    }
}
