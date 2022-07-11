//
//  PeachPaymentViewController.swift
//  TagYourRide
//
//  Created by Piyush Kumar on 11/6/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class PeachPaymentViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var Webview: UIWebView!
    
    var checkoptionvalue = 0
    
    var walletamount = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let  Userid =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)!
        
        if checkoptionvalue == 0 {
        
              let url1 = ("http://www.tyradmin.co.za/api/wallet_checkout_id.php?amount=\(walletamount)&currency=ZAR&paymentType=DB&user_id=\(Userid)")
        
            Webview.delegate = self
            
            let escapedString = url1.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            
            let searchURL : NSURL = NSURL(string: escapedString!)!
            print(searchURL)
            
            let request = URLRequest(url: searchURL as URL)
            
            ActivityIndicator.startAnimating()
            ActivityIndicator.hidesWhenStopped = true
            
            Webview.loadRequest(request)

            
        }
        
        else {
        let url = ("http://www.tyradmin.co.za/api/webview.php?amount=\(GlobalVarible.TotalPayableamount)&currency=ZAR&paymentType=DB&ride_id=\(GlobalVarible.RideId)")
        
            Webview.delegate = self
            
            let escapedString = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            
            let searchURL : NSURL = NSURL(string: escapedString!)!
            print(searchURL)
            
            let request = URLRequest(url: searchURL as URL)
            
            ActivityIndicator.startAnimating()
            ActivityIndicator.hidesWhenStopped = true
            
            Webview.loadRequest(request)            
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        ActivityIndicator.stopAnimating()
    
        let yourTargetUrl = Webview.request?.url
        
          let urlString: String = yourTargetUrl!.absoluteString
        
        print(yourTargetUrl)
        
         if urlString.contains("http://www.tyradmin.co.za/api/Thankyou.php")
         {
            GlobalVarible.PeachPaymentVar = 1
            
        self.dismiss(animated: true, completion: nil)
        }
    
        
         if urlString.contains("http://www.tyradmin.co.za/api/Wallet_Thankyou.php")
         {
             GlobalVarible.PeachWalletVar = 1
            self.dismiss(animated: true, completion: nil)
        }
    
    }


}
