//
//  CouponsCodeViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 29/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class CouponsCodeViewController: UIViewController,MainCategoryProtocol {
    
    var mydata : Coupons!
    
     var viewcontrollerself : UIViewController!
    
    @IBOutlet var mainview: UIView!
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var entercouponcode: UITextField!
    
    @IBOutlet weak var simpleview: UIView!
    
    @IBOutlet weak var invalidtextshowview: UIView!
    
     var Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func applycouponbtn(_ sender: Any) {
        
        if(entercouponcode.text!.characters.count == 0)
            
        {
            invalidtextshowview.isHidden = false
            simpleview.isHidden = true
        }
        else{
        
        GlobalVarible.CouponCode = self.entercouponcode.text!
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.getcoupons(CouponCode: self.entercouponcode.text!,USERID: Userid!)

        }
        
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
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
                
                 GlobalVarible.CouponCode = self.entercouponcode.text!
               
                GlobalVarible.couponcodevalue = 1
                self.dismiss(animated: true, completion: nil)
                 self.viewcontrollerself.viewWillAppear(true)
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
        
        mydata = data as! Coupons
        
        if(mydata.result == 0){
            GlobalVarible.CouponCode = ""
          invalidtextshowview.isHidden = false
            simpleview.isHidden = true
            
        }else{
            GlobalVarible.CouponCode = self.entercouponcode.text!
            self.showalert1( message: mydata.msg!)
            
        }

        
    }
    

    
}
