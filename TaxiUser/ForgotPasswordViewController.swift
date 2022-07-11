//
//  ForgotPasswordViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 22/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,MainCategoryProtocol {
    
    var changepasswordresponse : ForgotPasswordModel!

    var Emailenter : String = ""
    
    var emailValid=false
    
    @IBOutlet weak var UserEmail: UITextField!

    @IBOutlet var changePasswordButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backbtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onChangePassword(_ sender: Any) {
        
        Emailenter = UserEmail.text!
        
        let enteredEmail=self.UserEmail.text!
        
        if enteredEmail.isEmail{
            
            self.emailValid=true
        }
        else {
            
            self.emailValid=false
            
        }

        if self.emailValid {
            
            let dic=[ changePassword2:"\(Emailenter)"]
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.postData1(dictonary: dic as NSDictionary, url: changePassword)
        }
    }
    
    
    func showalert(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    func showalert1(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self.present(revealViewController, animated:true, completion:nil)
                
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
        
        changepasswordresponse = data as! ForgotPasswordModel
        
        
        if(changepasswordresponse.result == 1){
            
            showalert1(message: "Your password has been sent to registered mail.")
            
           
            
            
        }else{
            
            self.showalert(message: changepasswordresponse.message!)
            
        }
        
    }
  
}
