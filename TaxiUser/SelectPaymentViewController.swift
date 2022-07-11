//
//  SelectPaymentViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 23/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class SelectPaymentViewController: UIViewController,MainCategoryProtocol,UITableViewDelegate,UITableViewDataSource  {
    
    var mydata : ViewPaymentModel!
    
    var viewcontrollerself : UIViewController!
    
    
    @IBOutlet weak var outerview: UIView!
    
    
    var check = 1000
    
    var Size = 0
    
    var selectvalue = ""
    
    //  @IBOutlet weak var donebtn: UIButton!
    
    @IBOutlet weak var tableview: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        outerview.layer.cornerRadius = 5
        outerview.clipsToBounds = true
        
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ViewPaymentOption()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if(GlobalVarible.MatchCardSelect == 1){
            GlobalVarible.MatchCardSelect = 0
            self.dismiss(animated: true, completion: nil)
            self.viewcontrollerself.viewWillAppear(true)
        }else{
            
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return Size
        
        
        
    }
    

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableview.dequeueReusableCell(withIdentifier: "paymentcell", for: indexPath)
            
        
        let titlename :UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        
        // let imageview : UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        
        titlename.text = mydata.msg![indexPath.row].paymentOptionName
        
               
        return cell
        
        
    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        check = indexPath.row
        
        selectvalue = mydata.msg![indexPath.row].paymentOptionId!
        GlobalVarible.paymentmethod = mydata.msg![indexPath.row].paymentOptionName!
        
        
        if(selectvalue == "3"){
            GlobalVarible.PaymentOptionId = selectvalue
            
            //  self.dismissViewControllerAnimated(true, completion: nil)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let selectcardviewcontroller = storyBoard.instantiateViewController(withIdentifier: "SelectCardViewController") as! SelectCardViewController
            
            self.present(selectcardviewcontroller, animated:true, completion:nil)
            
            //self.dismissViewControllerAnimated(true, completion: nil)
            
            
        }else{
            GlobalVarible.PaymentOptionId = selectvalue
            self.dismiss(animated: true, completion: nil)
            self.viewcontrollerself.viewWillAppear(true)
            
        }
        
        
        
        //  print(mydata.msg![indexPath.row].paymentOptionId)
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

        mydata = data as! ViewPaymentModel
        
        if(mydata.result == 0){
            Size = 0
            
        }else{
            
            Size = (mydata.msg?.count)!
            
            tableview.reloadData()
            
        }
        
        
        
    }


    

  

}
