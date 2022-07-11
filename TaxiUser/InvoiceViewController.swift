//
//  InvoiceViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 25/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class InvoiceViewController: UIViewController {
    
    @IBOutlet weak var ratinginnerview: UIView!
    
      var invoicedata : DoneRideModel!
    
    var invoicenumber = ""
    
   // @IBOutlet weak var scrollview: UIScrollView!
    
    
    
    @IBOutlet weak var invoicenumbertext: UILabel!
    
    @IBOutlet weak var datetext: UILabel!
    
    
    @IBOutlet weak var topview: UIView!
    
    @IBOutlet weak var customerdriverinfoview: UIView!
    
    @IBOutlet weak var driverphonelabel: UILabel!
    
    @IBOutlet weak var drivernamelabel: UILabel!
    
    @IBOutlet weak var customernamelabel: UILabel!
    
    @IBOutlet weak var customerphonelabel: UILabel!
    
    @IBOutlet weak var bottomview: UIView!
    
    @IBOutlet weak var totalfareview: UIView!
    
    @IBOutlet weak var totalfarepricetext: UILabel!
    
    @IBOutlet weak var totaldistanclabel: UILabel!
    
    @IBOutlet weak var totalwaittimelabel: UILabel!
    
    @IBOutlet weak var waitingchargetext: UILabel!
    
    @IBOutlet weak var couponappliedtext: UILabel!
    
    @IBOutlet weak var paymentmethodtext: UILabel!
    
    @IBOutlet weak var ratingbuttonview: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        topview.layer.shadowColor = UIColor.gray.cgColor
        topview.layer.shadowOpacity = 1
        topview.layer.shadowOffset = CGSize(width: 0, height: 2)
        topview.layer.shadowRadius = 3
        
        customerdriverinfoview.layer.shadowColor = UIColor.gray.cgColor
        customerdriverinfoview.layer.shadowOpacity = 1
        customerdriverinfoview.layer.shadowOffset = CGSize(width: 0, height: 2)
        customerdriverinfoview.layer.shadowRadius = 3

        
        bottomview.layer.shadowColor = UIColor.gray.cgColor
        bottomview.layer.shadowOpacity = 1
        bottomview.layer.shadowOffset = CGSize(width: 0, height: 2)
        bottomview.layer.shadowRadius = 3
        
      
        
        totalfareview.layer.shadowColor = UIColor.gray.cgColor
        totalfareview.layer.shadowOpacity = 1
        totalfareview.layer.shadowOffset = CGSize(width: 0, height: 2)
        totalfareview.layer.shadowRadius = 2
        
        ratingbuttonview.layer.borderWidth = 5
        ratingbuttonview.layer.cornerRadius = 5
        ratingbuttonview.layer.borderColor = UIColor.clear.cgColor
        
        ratinginnerview.layer.borderWidth = 5
        ratinginnerview.layer.cornerRadius = 5
        ratinginnerview.layer.borderColor = UIColor.clear.cgColor

       
        
        invoicenumbertext.text = "INVOICE NO.  " + invoicenumber
        
        datetext.text = invoicedata.msg?.rideDate
        
        drivernamelabel.text = invoicedata.msg?.driverName
        
        customernamelabel.text = invoicedata.msg?.username
        customerphonelabel.text = invoicedata.msg?.userPhone
        
        totalfarepricetext.text = GlobalVarible.currencysymbol + " " + (invoicedata.msg?.totalAmount)!
        
        totaldistanclabel.text = "Total Distance : " + "  " + (invoicedata.msg?.distance)! 
        
        totalwaittimelabel.text = "Total Wait Time : " + "  " + (invoicedata.msg?.waitingTime)!
        
        waitingchargetext.text = GlobalVarible.currencysymbol + " " + (invoicedata.msg?.waitingPrice)!
        
        couponappliedtext.text = invoicedata.msg?.couponsCode
        
        paymentmethodtext.text = invoicedata.msg?.paymentOptionName
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 0
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        return cell
        
    }
    

    @IBAction func ratebtnclick(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newratingViewController = storyBoard.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        newratingViewController.movefrom = ""
        newratingViewController.modalPresentationStyle = .overCurrentContext
        self.present(newratingViewController, animated:true, completion:nil)
        

        
    }
  
}
