//
//  WalletPaymentOptionViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 15/07/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class WalletPaymentOptionViewController: UIViewController {
    
    
     var viewcontrollerself : UIViewController!
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var selectcardimageview: UIImageView!
    
    @IBOutlet weak var withnewcardimageview: UIImageView!

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
    
    @IBAction func backbtn(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func UserSelect_btn(_ sender: Any) {
        
        GlobalVarible.Walletcheck = 1
        selectcardimageview.image = UIImage(named: "Circled Dot-35 (1)")
         withnewcardimageview.image = UIImage(named: "Circle Thin-35 (1)")
    
    }

    @IBAction func WithNewCard_btn(_ sender: Any) {
        
         GlobalVarible.Walletcheck = 2
        
        selectcardimageview.image = UIImage(named: "Circle Thin-35 (1)")
        withnewcardimageview.image = UIImage(named: "Circled Dot-35 (1)")
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
    
    @IBAction func Done_btn_click(_ sender: Any) {
        
        if GlobalVarible.Walletcheck == 0{
        
        self.showalert(message: NSLocalizedString("Please select Any option first", comment : ""))
            
        }else{
        
        self.dismiss(animated: true, completion: nil)
        self.viewcontrollerself.viewWillAppear(true)
            
        }
        
        
    }
  

}
