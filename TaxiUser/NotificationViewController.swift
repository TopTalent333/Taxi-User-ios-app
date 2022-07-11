//
//  NotificationViewController.swift
//  Apporio Taxi
//
//  Created by AppOrio on 04/09/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MainCategoryProtocol {
    
    
    var notificationdata: NotificationModel!
    
     let imageUrl = API_URL.imagedomain
    var size = 0
    
    @IBOutlet weak var newnotificationtable: UITableView!
    
    var toastLabel : UILabel!
    
    let  Userid =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-300, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(toastLabel)
        toastLabel.text =  NSLocalizedString("No Notification!!", comment: "")
        
        toastLabel.isHidden = true
        

        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ShowAllNotification(UserId: self.Userid)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return size
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationcell", for: indexPath) as! NotficationTableViewCell
        
        
        cell.labeltext.text = notificationdata.details![indexPath.row].pushMessage
        
        cell.headinglabel.text = notificationdata.details![indexPath.row].pushMessageHeading
        
        let newString = notificationdata.details![indexPath.row].pushImage!
        
        
        if newString == ""{
            
            cell.imageviewheight.constant = 0
        
        }else{
      
        
        let url = imageUrl + newString
        
        let url1 = NSURL(string: url)
        
        cell.imageview!.af_setImage(withURL:
            url1! as URL,
                                   placeholderImage: UIImage(named: "dress"),
                                   filter: nil,
                                   imageTransition: .crossDissolve(1.0))

        
            }
        
        
     return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        newnotificationtable.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        if (notificationdata.details![indexPath.row].pushWebUrl == "")
        {
            
        
        }else{
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myModalViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController")as! WebViewController
           myModalViewController.weblinkurl = notificationdata.details![indexPath.row].pushWebUrl!
            self.present(myModalViewController, animated: true, completion: nil)
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
        
       notificationdata = data as! NotificationModel
        if(notificationdata.status == 1){
        
            toastLabel.isHidden = true
            newnotificationtable.isHidden = false
            
         
            
            if(notificationdata.status == 0){
                
                size = 0
                
            }else{
                size = (notificationdata.details?.count)!
                
            }
            
            newnotificationtable.reloadData()

        }else{
        
            toastLabel.isHidden = false
            newnotificationtable.isHidden = true
            

        
        }
        

    }
    

   
}
