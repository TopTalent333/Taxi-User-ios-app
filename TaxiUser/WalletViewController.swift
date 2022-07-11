//
//  WalletViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 15/07/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController,MainCategoryProtocol {
    
    
    var showwalletdata: ShowWalletMoneyModel!
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var totalamounttext: UILabel!
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.layer.shadowColor = UIColor.gray.cgColor
        mainview.layer.shadowOpacity = 1
        mainview.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainview.layer.shadowRadius = 2
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.viewwalletmoney(UserId: Userid!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if GlobalVarible.addmoneyvalue == 1 {
           
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.viewwalletmoney(UserId: Userid!)
             GlobalVarible.addmoneyvalue = 0

        }else{
        
            
        }
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func Addmoneybtn_click(_ sender: Any) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let addmoneyviewcontroller = storyBoard.instantiateViewController(withIdentifier: "AddMoneyViewController") as! AddMoneyViewController
        
        self.present(addmoneyviewcontroller, animated:true, completion:nil)
        
        
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
        
         if(GlobalVarible.Api == "walletmoneyresponse"){
            
            showwalletdata = data as! ShowWalletMoneyModel
            
            if(showwalletdata.result == 1){
                
                totalamounttext.text =  GlobalVarible.currencysymbol + " " + (showwalletdata.msg?.walletMoney)!
            
            }else{
            
            }
            
        }
        
    }


}
