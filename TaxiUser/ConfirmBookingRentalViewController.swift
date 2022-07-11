//
//  ConfirmBookingRentalViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 28/06/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import Firebase

class ConfirmBookingRentalViewController: UIViewController,MainCategoryProtocol,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var carimage: UIImageView!
    
    @IBOutlet weak var carname: UILabel!
    
    var rentalridesyncdata: RentalRideSyncModel!
    
    var part1: String = ""
    var part2: String = ""
    var part3: String = ""
    
    @IBOutlet weak var rentalconfirmtable: UITableView!
    
    
     var ref = FIRDatabase.database().reference()
    
   // @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var cardetailtext: UILabel!
    
    @IBOutlet weak var selectpackagetext: UILabel!
    
    @IBOutlet weak var basefaretext: UILabel!
    
    @IBOutlet weak var additionalkmfare: UILabel!
   
    @IBOutlet weak var additionalhourfaretext: UILabel!
    
    
   // @IBOutlet weak var descriptiontext: UITextView!
    
      let imageUrl = API_URL.imagedomain
    
    var firstindex = 0
    
    var secondindex = 0
    
    var rentaldata : RentalModel!
    
    var rentalbookdata : RentalBookModel!
    
    var  confirmridedata : ConfirmRideModel!
    
    var cancel60secrideid = ""
   // var timerForGetDriverLocation1 = Timer()
    
    @IBOutlet weak var selectpaymentmethodtext: UILabel!
    
    
    @IBOutlet weak var applycoupontext: UILabel!

    
    
    @IBOutlet weak var basefareprice: UILabel!
    
    @IBOutlet weak var additionalkmfareprice: UILabel!
    
    @IBOutlet weak var additionalhourfareprice: UILabel!
    
    
    
    @IBOutlet weak var textview: UITextView!
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
     var renttypeid = ""
    
    var cartypeid = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       selectpackagetext.text = rentaldata.details![firstindex].rentalCategory!
        
        carname.text = rentaldata.details![firstindex].rentalPakageCar![secondindex].carTypeName
        
        let newString = rentaldata.details![firstindex].rentalPakageCar![secondindex].carTypeImage!
        
       /* do {
            let str = try NSAttributedString(data: (rentaldata.details![firstindex].rentaldescription)!.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
             descriptiontext.attributedText =  str
            
        } catch {
            print(error)
        }*/

        
        rentalconfirmtable.reloadData()
        
        print(newString)
        
        let url = imageUrl + newString
        
        let url1 = NSURL(string: url)
        
        carimage.af_setImage(withURL:
            url1! as URL,
                              placeholderImage: UIImage(named: "dress"),
                              filter: nil,
                              imageTransition: .crossDissolve(1.0))
        
        basefaretext.text = "includes " + rentaldata.details![firstindex].rentalCategoryHours! + " hours " + rentaldata.details![firstindex].rentalCategoryKilometer!
        
        additionalkmfare.text = "After First " + rentaldata.details![firstindex].rentalCategoryKilometer!
        
        additionalhourfaretext.text = "After First " + rentaldata.details![firstindex].rentalCategoryHours! + " Hours"
        
        
        basefareprice.text = GlobalVarible.currencysymbol + " " + rentaldata.details![firstindex].rentalPakageCar![secondindex].price!
        additionalkmfareprice.text = GlobalVarible.currencysymbol + " " + rentaldata.details![firstindex].rentalPakageCar![secondindex].pricePerKms!

        additionalhourfareprice.text = GlobalVarible.currencysymbol + " " + rentaldata.details![firstindex].rentalPakageCar![secondindex].pricePerHrs!

        renttypeid = rentaldata.details![firstindex].rentalPakageCar![secondindex].rentcardId!
        
        cartypeid = rentaldata.details![firstindex].rentalPakageCar![secondindex].carTypeId!
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showDialog),
            name: NSNotification.Name(rawValue: "show"),
            object: nil)
        
      //  scrollview.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideDialog),
            name: NSNotification.Name(rawValue: "hide1"),
            object: nil)
        
        
      GlobalVarible.checkdialogcancelbtn = 0
 

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(GlobalVarible.paymentmethod)
        selectpaymentmethodtext.text = GlobalVarible.paymentmethod
        
        
        if(GlobalVarible.checkdialogcancelbtn == 1){
            
            
            
          //  self.dismiss(animated: true, completion: nil)
            
            GlobalVarible.timerForGetDriverLocation1.invalidate()
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.CancelRide60Sec(RideID: cancel60secrideid)
            
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

            
           /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            
            if let window = self.view.window{
                window.rootViewController = nextController
            }*/
            
            
            GlobalVarible.checkdialogcancelbtn = 0
        }

        
        if(GlobalVarible.couponcodevalue == 1){
            applycoupontext.text = "Coupon Applied  " +   GlobalVarible.CouponCode
            GlobalVarible.couponcodevalue = 0
            
        }
        
    }
    
    @IBAction func selectpaymentmethodbtn(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let paymentviewcontroller = storyBoard.instantiateViewController(withIdentifier: "SelectPaymentViewController") as! SelectPaymentViewController
        paymentviewcontroller.viewcontrollerself = self
        paymentviewcontroller.modalPresentationStyle = .overCurrentContext
        //  paymentviewcontroller.modalPresentationStyle = .Popover
        self.present(paymentviewcontroller, animated:true, completion:nil)

    }
    
    
    
    
    @IBAction func applycouponbtn(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let couponcodeviewcontroller = storyBoard.instantiateViewController(withIdentifier: "CouponsCodeViewController") as! CouponsCodeViewController
        couponcodeviewcontroller.viewcontrollerself = self
        couponcodeviewcontroller.modalPresentationStyle = .overCurrentContext
        //  paymentviewcontroller.modalPresentationStyle = .Popover
        self.present(couponcodeviewcontroller, animated:true, completion:nil)

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rentalconfirmcell", for: indexPath)
        
        
        let decriptiontext : UITextView = (cell.contentView.viewWithTag(1) as? UITextView)!
        
        do {
            let str = try NSAttributedString(data: (rentaldata.details![firstindex].rentaldescription)!.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            decriptiontext.attributedText =  str
            
        } catch {
            print(error)
        }
        

        
     return cell
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        //self.dismiss(animated: true, completion: nil)
       /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        if let window = self.view.window{
            window.rootViewController = nextController
        }*/
        
    }

    @IBAction func selectpackagedropdownbtn(_ sender: Any) {
        
         self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func couponbtnclick(_ sender: Any) {
        
        
        
    }
    
    @IBAction func bookforlaterbtnclick(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myModalViewController = storyboard.instantiateViewController(withIdentifier: "TimePickerViewController")as! TimePickerViewController
        myModalViewController.matchstring = "FromRental"
        myModalViewController.cartypeid = self.cartypeid
        myModalViewController.renttypeid = self.renttypeid
        myModalViewController.modalPresentationStyle = .overCurrentContext
        self.present(myModalViewController, animated: true, completion: nil)

    }
    
    @IBAction func ridenowbtnclick(_ sender: Any) {
        
        
      /*  let dic=[ RideNowUrl1:"\("2")",
            RideNowUrl2:"\("1")",
            RideNowUrl3:"\(self.Userid!)",
            RideNowUrl4:"\(GlobalVarible.CouponCode)",
            RideNowUrl5:"\(GlobalVarible.PickUpLat)",
            RideNowUrl6:"\(GlobalVarible.PickUpLng)",
            RideNowUrl7:"\(GlobalVarible.Pickuptext)",
            RideNowUrl8:"\("")",
            RideNowUrl9:"\("")",
            RideNowUrl10:"\("")",
            RideNowUrl11:"\(self.cartypeid)",
            RideNowUrl12:"\(GlobalVarible.CardId)",
            RideNowUrl13:"\(GlobalVarible.PaymentOptionId)",
            RideNowUrl14:"\(self.renttypeid)",
            RideNowUrl15:"\("")",
            RideNowUrl16:"\("")",
            RideNowUrl17:"\(GlobalVarible.languageid)"
            
            
        ]
        print(dic)
        

        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ConfirmRide(dictonary: dic as NSDictionary, url: RideNowUrl)*/

        
       ApiManager.sharedInstance.protocolmain_Catagory = self
      ApiManager.sharedInstance.RentalBookRide(USERID: self.Userid!, USERCURRENTLAT: GlobalVarible.PickUpLat, USERCURRENTLONG: GlobalVarible.PickUpLng, CURRENTADDRESS: GlobalVarible.Pickuptext, CARTYPEID: self.cartypeid, RentCardId: self.renttypeid,COUPONCODE: GlobalVarible.CouponCode,PaymentOPtionId: GlobalVarible.PaymentOptionId)
                
        
        
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
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let TrackViewController = storyBoard.instantiateViewController(withIdentifier: "RentalTrackRideViewController") as! RentalTrackRideViewController
                // TrackViewController.mydatapage = self.driverdata
                TrackViewController.Currentrideid = self.part2
                TrackViewController.currentStatus = self.part3
                TrackViewController.currentmessage = self.part1
                self.present(TrackViewController, animated:true, completion:nil)
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    func showalert2(message:String)  {
        
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
        
        
        if(GlobalVarible.Api == "rentalconfirmridebook"){
            
            rentalbookdata = data as! RentalBookModel
            // confirmridedata = data as! ConfirmRideModel
            
            
            if(rentalbookdata.status == 1){
                
                cancel60secrideid = (rentalbookdata.details?.rentalBookingId)!
                
                
                GlobalVarible.checkRideId = cancel60secrideid
                
                //  MBProgressHUD.hide(for: self.view, animated: true)
                
                let Message: NSDictionary = ["changed_destination": "0","ride_id": cancel60secrideid,"ride_status": "10","done_ride_id": ""]
                
                self.ref.child("RideTable").child(cancel60secrideid).setValue(Message)
                

                
                print(cancel60secrideid)
                
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "show"), object: nil)
                
               GlobalVarible.timerForGetDriverLocation1 = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(ConfirmBookingRentalViewController.getDriverLocation), userInfo: nil, repeats: true)
                
                
                
            }else{
                
               // hiddenview.isHidden = true
                self.showalert(message: rentalbookdata.message!)
                print("Ride Book Unsuccessfully")
            }
            
            
        }
        
        
        
        if(GlobalVarible.Api == "rentalridesync"){
            
            rentalridesyncdata = data as! RentalRideSyncModel
            
            
            if(rentalridesyncdata.status == 0){
                
                //  MBProgressHUD.hide(for: self.view, animated: true)
                
                self.dismiss(animated: true, completion: nil)
              /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:MapViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                
                self.present(revealViewController, animated:true, completion:nil)*/
                
               /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                
                if let window = self.view.window{
                    window.rootViewController = nextController
                }*/
                
                
                 self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                
            }else
            {
                if(rentalridesyncdata.details?.bookingStatus == "11"){
                    // MBProgressHUD.hide(for: self.view, animated: true)
                    self.dismiss(animated: true, completion: nil)
                    DispatchQueue.main.async(execute: {
                        
                        self.showalert1( message: NSLocalizedString("Your Ride is Successfully Booked!!", comment: ""))
                        
                    })
                    
                    GlobalVarible.MatchStringforCancel = "HideCancelButton"
                    
                    
                    
                }
                
                if(rentalridesyncdata.details?.bookingStatus == "14"){
                    
                    // MBProgressHUD.hide(for: self.view, animated: true)
                    self.dismiss(animated: true, completion: nil)
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.showalert2(message: NSLocalizedString("Your Ride has been Rejected!!", comment: ""))
                        
                        
                    })
                    
                    
                }
                
                
                if(rentalridesyncdata.details?.bookingStatus == "12"){
                    
                    GlobalVarible.CurrentRideStatus = part3
                    
                }
                       
                
            }
            
            
            
        }

        
    }
    
    
    func getDriverLocation(timer : Timer){
        
     
        self.dismiss(animated: true, completion: nil)
        
        GlobalVarible.timerForGetDriverLocation1.invalidate()
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.CancelRide60Sec(RideID: cancel60secrideid)
        
        
        self.showalert(message: NSLocalizedString("Driver Not available", comment : ""))
    }
    
    
    
    func showDialog(notification: NSNotification){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let dialogviewcontroller = storyBoard.instantiateViewController(withIdentifier: "DialogViewController") as! DialogViewController
        dialogviewcontroller.modalPresentationStyle = .overCurrentContext
         dialogviewcontroller.viewcontrollerself = self
        //  paymentviewcontroller.modalPresentationStyle = .Popover
        self.present(dialogviewcontroller, animated:true, completion:nil)
        
        
    }
    
    
    func hideDialog(notification: NSNotification){
        
        GlobalVarible.timerForGetDriverLocation1.invalidate()
        
        
        print("Driver Accepted")
        
        
        let totalvalue = notification.userInfo!
        
        print(totalvalue)
        
        
        
        if let aps = totalvalue["aps"] as? NSDictionary {
            
            if let alert = aps["alert"] as? NSString {
                //Do stuff
                part1 = alert as String
                print("Part 1: \(part1)")
                
                
                part2 = aps["ride_id"] as! String
                print("Part 2: \(part2)")
                
                part3 = aps["ride_status"] as! String
                print("Part 3: \(part3)")
                
                
              //  ApiManager.sharedInstance.protocolmain_Catagory = self
               // ApiManager.sharedInstance.RentalUserSync(RentalBookindId: part2)
              //  ApiManager.sharedInstance.RentalUserSync(BookindId: part2)
                
                
            }
            
        }
        
        
    }
    


    

    

}
