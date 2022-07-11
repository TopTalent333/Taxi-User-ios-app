 //
//  MapViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 22/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
import Firebase
import MessageUI
import GooglePlaces
import  AlamofireImage

var mapviewcontroller :  MapViewController!

class MapViewController: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate,MainCategoryProtocol,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource , UICollectionViewDelegate ,MFMailComposeViewControllerDelegate,GMSAutocompleteViewControllerDelegate {
    
    
    
    @IBOutlet weak var slidinginnerview: UIView!
    
    
    @IBOutlet weak var MapCollectionview: UICollectionView!
    
   var CarsTimedata: CarsTImeModel!
    
    var usersyncdata: CustomerSyncModel!
    
      var rentaldata: RentalModel!
    
    
    var part4: String = ""
    var part5: String = ""

    
 //   var distancedata : DistanceModel!
    
 //   var ridedata: RideEstimate!
  //
   // var customersyncdata: CustomerSyncModel!
    
    @IBOutlet weak var NoOperateview: UIView!
    
    
    @IBOutlet weak var locationmainview: UIView!
    
  
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var profilename: UILabel!
    
    @IBOutlet weak var profileemail: UILabel!
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var menutable: UITableView!
    
    var dataArray: [String] = ["Book Rides","Your Trips","Payments","Rate Card",/*"Wallet",*/"Report Issue","Customer Support","Terms & Conditions","About Us"]
    
    
    var imageArray: [String] = ["ic_book","ic_trips","ic_payment-2-1","ic_tag_us_dollar","ic_payment"/*,"icons8-Notification Filled-50"*/,"system_report","icons8-Gmail-50","ic_terms_condition","ic_about_us"]
    
    
    var Name = ""
    var email = ""
    
    var Userimage = ""
    
    var facebookimage = ""
    
    var googleimage = ""
    
    var userphone = ""
    
    @IBOutlet weak var dotaddressimage: UIImageView!
    
    @IBOutlet weak var centeraddressimage: UIImageView!
    

    
    var  collectionsize = 0
    
    var checkapirunvalue = 0
    
    
    
  //  @IBOutlet weak var topdroplocationview: UIView!
    
    @IBOutlet weak var toppicklocationview: UIView!
    
    @IBOutlet weak var bottomdroplocationview: UIView!
    
 //   @IBOutlet weak var bottompicklocatioview: UIView!
    
    
    @IBOutlet weak var bottomdroplocationtext: UILabel!
    
 //   @IBOutlet weak var bottompicklocationtext: UILabel!
    
    let imageUrl = API_URL.imagedomain

    
    var part1: String = ""
    var part2: String = ""
    var part3: String = ""
    
    @IBOutlet var slidingview: UIView!
    
    @IBOutlet weak var toppickuplocation: UILabel!
    
  //  @IBOutlet weak var topdropofflocation: UILabel!

    @IBOutlet weak var mapview: GMSMapView!
    
    
    
    var locationManager = CLLocationManager()
    
    var ref = FIRDatabase.database().reference()
    
     var ref1 = FIRDatabase.database().reference()
    
    
    var nearstDriverUserDistance  : Double!
    
    var minimumValue : Double!
    
    var timerForGetDriverLocation = Timer()
    
    var timerForGetDriverLocation1 = Timer()
    
    var movedfrom = " "
    var latermoved = ""
    
    var totaltime = ""
    
    var distanceKM  =  [Double]()
    
    var addarray = [AnyObject]()
    
    var postdata = [String]()
    
    let blackView = UIView()
    
    var i = 0
    
    var index = 0
    
    var markers = [GMSMarker]()
    
    var driverIds = [String]()
    
    var cartypeArray = [String]()
    
    var statusArray = [String]()
    
    
    var checkvaluecollectioncell = 2000
    
    
    var mapcameracheck = 0
    
    var mapcheckvaluewhenclickmap = 0
    
    var matchvalue = 1
    
    var selectvalue = 0
    
    var cartypearray = [String]()
    
    var CurrentDate = ""
    var CurrentTime = ""
    
    var textvalue = 0
    
    var movefromdemouser = ""

    
    @IBOutlet weak var ridenowview: UIView!
    
   let  Userid =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalVarible.viewcontrollerself = self
        
        self.ridenowview.isHidden = true
        
        mapviewcontroller = self
        GlobalVarible.checklocationvalue = 1
        
         bottomdroplocationtext.text = "Set your drop point"
        
        if GlobalVarible.movefromdemouser == "demouser"{
        
          self.showalert12(message: "You have Logged in as demo user, in order to test ride please select car category as MINI from bottom bar.")
        }else{
            
            
        }
        
        
         mapcameracheck = 1
        
        
        print(GlobalVarible.currencysymbol)
        
            
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showlocation),
            name: NSNotification.Name(rawValue: "location"),
            object: nil)

        
       /* profileimage.layer.borderWidth = 1
        profileimage.layer.masksToBounds = false
        profileimage.layer.borderColor = UIColor.black.cgColor
        profileimage.layer.cornerRadius =  profileimage.frame.height/2
        profileimage.clipsToBounds = true*/
        
        
        self.locationmainview.layer.borderWidth = 1.0
        self.locationmainview.layer.borderColor = UIColor.lightGray.cgColor
        self.locationmainview.layer.cornerRadius = 4
        
        /*self.toppicklocationview.layer.borderWidth = 1.0
        self.toppicklocationview.layer.borderColor = UIColor.lightGray.cgColor
        self.toppicklocationview.layer.cornerRadius = 4
        
        self.topdroplocationview.layer.borderWidth = 1.0
        self.topdroplocationview.layer.borderColor = UIColor.lightGray.cgColor
        self.topdroplocationview.layer.cornerRadius = 4*/
        
         self.toppickuplocation.text = GlobalVarible.Pickuptext
        
        Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyname)!
        
        email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyemail)!
        
        Userimage =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyimage)!
        
        userphone = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyphonenumber)!
        
       facebookimage = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.keyfacbookimage)!
        
         googleimage = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.keygoogleimage)!
        
        
        profileimage.layer.cornerRadius =  profileimage.frame.width/2
        profileimage.clipsToBounds = true
        profileimage.layer.borderWidth = 1
        profileimage.layer.borderColor = UIColor.black.cgColor
        
        
        
        
        if Userimage != ""{
            
            
            
            let newUrl =  Userimage
            let url = URL(string: newUrl)
            profileimage.af_setImage(withURL:
                url! as URL,
                                     placeholderImage: UIImage(named: "dress"),
                                     filter: nil,
                                     imageTransition: .crossDissolve(1.0))
            
            
            
            
        }else if googleimage != ""{
            
            let newUrl = googleimage
            
            
            
            let url1 = NSURL(string: newUrl)
            
            
            profileimage!.af_setImage(withURL:
                url1! as URL,
                                   placeholderImage: UIImage(named: "dress"),
                                   filter: nil,
                                   imageTransition: .crossDissolve(1.0))
            
            
            
            
        }else if facebookimage != ""{
            
            let newUrl = facebookimage
            
            
            
            let url1 = NSURL(string: newUrl)
            
            
            profileimage!.af_setImage(withURL:
                url1! as URL,
                                      placeholderImage: UIImage(named: "dress"),
                                      filter: nil,
                                      imageTransition: .crossDissolve(1.0))

            
        }else{
            
            profileimage.image = UIImage(named: "profileeee") as UIImage?
            
        }

        
        
        self.profilename.text! = Name
         self.profileemail.text! = email
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
        
        mapview.animate(toZoom: 15)
        
        
       
        
        
        if Where == "notification"{
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ViewCarsWithTime(UserCityName: GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
            
        }
        else{
            if GlobalVarible.trackbackbtnvaluematch == 0{
            
                UserDefaults.standard.setValue("0", forKey:"firebaseride_status")
                
                GlobalVarible.changeddestination = 0
                
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.UserSyncWhenAppTerminate(UserId: Userid)
                
            }else{
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.ViewCarsWithTime(UserCityName: GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
                GlobalVarible.trackbackbtnvaluematch = 0
            }
        }
        

       // GlobalVarible.trackbackbtnvaluematch = 0
        
        
        
         self.NoOperateview.layer.isHidden = true
    
        
        let date = Date()
        let formatter = DateFormatter()
        
       // formatter.dateFormat = "dd.MM.yyyy"
       // let result = formatter.string(from: date)
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateStyle = DateFormatter.Style.long
        CurrentDate = formatter.string(from: date)
         GlobalVarible.CurrentDate = CurrentDate
        
        formatter.timeStyle = DateFormatter.Style.medium
        formatter.dateStyle = DateFormatter.Style.none
        CurrentTime = formatter.string(from: date)

        
        mapview.delegate = self

        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "uber_theme", withExtension: "json") {
                mapview.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }

        
       
             
        GlobalVarible.timerForGetDriverLocation5 = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(MapViewController.checkridestatus), userInfo: nil, repeats: true)
 


        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    func checkridestatus(){
        
        
        
        
        ref1.child("RideTable").child(GlobalVarible.checkRideId).observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            
            if let rideid = value?["ride_id"]{
                
                let rideid = value?["ride_id"] as! String
                
                let ridestatus = value?["ride_status"] as! String
                
                let donerideid = value?["done_ride_id"] as! String
                
                let changedestination = value?["changed_destination"] as! String
                
                
                if GlobalVarible.changeddestination == 0{
                
                if changedestination == "1"{
                    
                    GlobalVarible.changeddestination = 1
                    
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "trackride"), object: nil, userInfo: nil)
                
                }
                    
                }
                
                self.part4 = rideid
                
                self.part5 = ridestatus
                
                let firebaseridestatus =  UserDefaults.standard.string(forKey: "firebaseride_status")
                
                
                if ridestatus == firebaseridestatus{
                    
                    
                }else{
                    // ApiManager.sharedInstance.protocolmain_Catagory = self
                    // ApiManager.sharedInstance.UserSyncWhenAppTerminate(UserId: self.Userid)
                    
                    GlobalVarible.checkRideId = rideid
                    
                    if(ridestatus == "3"){
                        
                        
                        GlobalVarible.timerForGetDriverLocation1.invalidate()
                        
                        GlobalVarible.checkridestatus = ridestatus
                        
                        self.dismiss(animated: true, completion: nil)
                        self.showalert10( message: NSLocalizedString("Your Ride is Successfully Booked!!", comment: ""))
                        
                        
                        
                    }
                    
                    if(ridestatus == "4"){
                        
                        //  self.matchvalue = 0
                        
                        
                        
                    }
                    
                    
                    if(ridestatus == "5"){
                        
                        GlobalVarible.checkridestatus = ridestatus
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "trackride"), object: nil, userInfo: nil)
                        
                        
                        
                        
                    }
                    
                    if(ridestatus == "6"){
                        
                        GlobalVarible.checkridestatus = ridestatus
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "trackride"), object: nil, userInfo: nil)
                        
                        
                    }
                    
                    if(ridestatus == "7"){
                        
                        GlobalVarible.checkridestatus = ridestatus
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "trackride"), object: nil, userInfo: nil)
                        
                       /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextController: RecieptViewController = storyboard.instantiateViewController(withIdentifier: "RecieptViewController") as! RecieptViewController
                         nextController.currentrideid = donerideid
                        
                        if let window = self.view.window{
                            window.rootViewController = nextController
                        }*/
                        
                       /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextController: RecieptViewController = storyboard.instantiateViewController(withIdentifier: "RecieptViewController") as! RecieptViewController
                        
                        nextController.currentrideid = donerideid
                        
                        
                        self.present(nextController, animated: true, completion: nil)*/

                        

                 
                        
                    }
                    
                     if(ridestatus == "11"){
                        
                        GlobalVarible.timerForGetDriverLocation1.invalidate()
                          GlobalVarible.checkridestatus = ridestatus
                        
                         self.dismiss(animated: true, completion: nil)
                        
                        self.showalert11( message: NSLocalizedString("Your Ride is Successfully Booked!!", comment: ""))

                        
                    }
                    
                     if(ridestatus == "12"){
                        
                        GlobalVarible.checkridestatus = ridestatus
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rentaltrackride"), object: nil, userInfo: nil)
                        

                        
                    }
                    
                    
                     if(ridestatus == "13"){
                        GlobalVarible.checkridestatus = ridestatus
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rentaltrackride"), object: nil, userInfo: nil)
                        

                        
                        
                    }
                    
                    
                     if(ridestatus == "14"){
                        
                        
                        
                    }
                    
                     if(ridestatus == "16"){
                        
                        GlobalVarible.checkridestatus = ridestatus
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rentaltrackride"), object: nil, userInfo: nil)
                        

                        
                        
                    }
                    
                    
               }
                
                
                
                print(rideid)
                print(ridestatus)
                
                
            }else{
                
                print("hello")
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
             
        
    }

    
    func showalert10(message:String)  {
        
      //  DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let TrackViewController = storyBoard.instantiateViewController(withIdentifier: "TrackRideViewController") as! TrackRideViewController
                // TrackViewController.mydatapage = self.driverdata
                TrackViewController.Currentrideid = self.part4
                TrackViewController.currentStatus = self.part5
                //TrackViewController.currentmessage = self.part1
                self.present(TrackViewController, animated:true, completion:nil)
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                
            }
            
            
       // })
        
    }
    
    
    func showalert11(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let TrackViewController = storyBoard.instantiateViewController(withIdentifier: "RentalTrackRideViewController") as! RentalTrackRideViewController
                // TrackViewController.mydatapage = self.driverdata
                TrackViewController.Currentrideid = self.part4
                TrackViewController.currentStatus = self.part5
               // TrackViewController.currentmessage = self.part1
                self.present(TrackViewController, animated:true, completion:nil)
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    func showalert12(message:String)  {
        
         DispatchQueue.main.async(execute: {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
            
          GlobalVarible.movefromdemouser = ""
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            
        }
        
        
         })
        
    }


    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showlocation(notification: NSNotification){
        
        
        if(GlobalVarible.UserDropLocationText == NSLocalizedString("No drop off point", comment: "")){

        
        self.locationManager.startUpdatingLocation()
        
        mapview.animate(toZoom: 15)
            
        }else{
            
            
        }
        
    }
    
       
    override func viewWillAppear(_ animated: Bool) {
        if(GlobalVarible.checklocationvalue == 2){
             if(GlobalVarible.UserDropLocationText == NSLocalizedString("No drop off point", comment: "")){
                                
                 bottomdroplocationtext.text = "Set your drop point"
                
               
                
             }else{
            
            
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            bottomdroplocationtext.text = GlobalVarible.UserDropLocationText
            mapview.settings.myLocationButton = false
            //  defaultmarkerimage.hidden = true
            
            
            let position = CLLocationCoordinate2DMake(GlobalVarible.UserDropLat, GlobalVarible.UserDropLng)
            // self.setuplocationMarker(position)
            mapview.animate(toLocation: position)
            
            //   ApiManager.sharedInstance.protocolmain_Catagory = self
            //   ApiManager.sharedInstance.FindDistance()
            }
            
        }
        
        if(GlobalVarible.checklocationvalue == 3){
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            toppickuplocation.text = GlobalVarible.Pickuptext
            mapview.settings.myLocationButton = false
            //  defaultmarkerimage.hidden = true
            
            
            let position = CLLocationCoordinate2DMake(Double(GlobalVarible.PickUpLat)!, Double(GlobalVarible.PickUpLng)!)
            // self.setuplocationMarker(position)
            mapview.animate(toLocation: position)
            
            //   ApiManager.sharedInstance.protocolmain_Catagory = self
            //   ApiManager.sharedInstance.FindDistance()
            
            
        }
        
         if(GlobalVarible.checklocationvalue == 1){
            
            self.locationManager.startUpdatingLocation()
            
            mapview.animate(toZoom: 15)
        }
        
        
        
       
        
        self.slidingview.alpha = 0
        self.blackView.alpha = 0
        
        
        
        Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyname)!
        
        email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyemail)!
        
        Userimage =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyimage)!
        
         userphone = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyphonenumber)!
        
        
        facebookimage = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.keyfacbookimage)!
        
        googleimage = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.keygoogleimage)!
        
        
    
        
        
        
        if Userimage != ""{
            
            
            
            
            let newUrl =  Userimage
            let url = URL(string: newUrl)
            profileimage.af_setImage(withURL:
                url! as URL,
                                     placeholderImage: UIImage(named: "dress"),
                                     filter: nil,
                                     imageTransition: .crossDissolve(1.0))

            
            
            
            
        }else if googleimage != ""{
            
            let newUrl = googleimage
            
            
            
            let url1 = NSURL(string: newUrl)
            
            
            profileimage!.af_setImage(withURL:
                url1! as URL,
                                      placeholderImage: UIImage(named: "dress"),
                                      filter: nil,
                                      imageTransition: .crossDissolve(1.0))
            
            
            
            
        }else if facebookimage != ""{
            
            let newUrl = facebookimage
            
            
            let url1 = NSURL(string: newUrl)
            
            
            profileimage!.af_setImage(withURL:
                url1! as URL,
                                      placeholderImage: UIImage(named: "dress"),
                                      filter: nil,
                                      imageTransition: .crossDissolve(1.0))
        }else{
            
            profileimage.image = UIImage(named: "profileeee") as UIImage?
            
        }
        

        
        self.profilename.text! = Name
        
        self.profileemail.text! = email
        
        
        
        
        
       // dropofflocation.text = GlobalVarible.UserDropLocationText
        
        
        
    }
    
    @IBAction func currentlocationbtn(_ sender: Any) {
        
        
        
        self.locationManager.startUpdatingLocation()
        
        mapview.animate(toZoom: 15)
            
       
        
    }
    
    
    
    
    @IBAction func profilebtn(_ sender: Any) {
        
        self.slidingview.alpha = 0
        self.blackView.alpha = 0
        
          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let mapViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
         
         self.present(mapViewController, animated:true, completion:nil)

    }
    
    
    
    
    @IBAction func ridelaterbtn(_ sender: Any) {
        
        
     if GlobalVarible.car_type_id == ""{
        
        self.showalert(message: "Please select car First")
     }else{
        
            if(GlobalVarible.UserDropLocationText == NSLocalizedString("No drop off point", comment: "")){
                
                self.showalert(message: NSLocalizedString("Please Enter Drop Location First!!!", comment: ""))
                
                
            }else{
                
                ref.child("Drivers_A").removeAllObservers()

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myModalViewController = storyboard.instantiateViewController(withIdentifier: "TimePickerViewController")as! TimePickerViewController
        myModalViewController.modalPresentationStyle = .overCurrentContext
        self.present(myModalViewController, animated: true, completion: nil)
                
                
            }
        /*}
        else{
            self.showalert(message: NSLocalizedString("Please Select Car First!!!", comment: ""))
            
        }*/

        }
        
    }
    
    
    @IBAction func ridenowbtn(_ sender: Any) {
        
        
        if GlobalVarible.car_type_id == ""{
            
            self.showalert(message: NSLocalizedString("Please select car First", comment: ""))
        }else{

        
        
        if(GlobalVarible.UserDropLocationText == NSLocalizedString("No drop off point", comment: "")){
            
            let refreshAlert = UIAlertController(title:  NSLocalizedString("Set Your Drop Point", comment: ""), message: NSLocalizedString("Do You Want To Continue WithOut Drop Off Point ?", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
                
                self.ref.child("Drivers_A").removeAllObservers()
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let paymentviewcontroller = storyBoard.instantiateViewController(withIdentifier: "RideNowViewController") as! RideNowViewController
                paymentviewcontroller.viewcontrollerself = self
                paymentviewcontroller.checkdroppointyesno = 1
                paymentviewcontroller.modalPresentationStyle = .overCurrentContext
                // paymentviewcontroller.modalPresentationStyle = .Popover
                self.present(paymentviewcontroller, animated:true, completion:nil)
                
                
                
            }))
            
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                
                refreshAlert .dismiss(animated: true, completion: nil)
                
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }else{
            
            
            ref.child("Drivers_A").removeAllObservers()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let paymentviewcontroller = storyBoard.instantiateViewController(withIdentifier: "RideNowViewController") as! RideNowViewController
            paymentviewcontroller.viewcontrollerself = self
            paymentviewcontroller.checkdroppointyesno = 2
            paymentviewcontroller.modalPresentationStyle = .overCurrentContext
            // paymentviewcontroller.modalPresentationStyle = .Popover
            self.present(paymentviewcontroller, animated:true, completion:nil)
            
            
        }
        
    

        
        }
     
        
        
    }
    
    @IBAction func toppickuplocationbtn(_ sender: Any) {
        
        
        if textvalue == 0 {
            
            GlobalVarible.checklocationvalue = 3
            
            toppickuplocation.textColor = UIColor.black
            bottomdroplocationtext.textColor = UIColor.lightGray
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            mapview.settings.myLocationButton = false
            // self.i = 1
            //  defaultmarkerimage.hidden = true
          //  let position = CLLocationCoordinate2DMake(GlobalVarible.UserDropLat, GlobalVarible.UserDropLng)
            
            let position = CLLocationCoordinate2DMake(Double(GlobalVarible.PickUpLat)!, Double(GlobalVarible.PickUpLng)!)
            // self.setuplocationMarker(position)
            mapview.animate(toLocation: position)
            
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            present(autocompleteController, animated: true, completion: nil)
            
            dotaddressimage.image = UIImage(named: "pickupaddress") as UIImage?
            centeraddressimage.image = UIImage(named: "Record-25 (1)") as UIImage?
        
        
        }else{
            
             GlobalVarible.checklocationvalue = 3
            
             let position = CLLocationCoordinate2DMake(Double(GlobalVarible.PickUpLat)!, Double(GlobalVarible.PickUpLng)!)
            // self.setuplocationMarker(position)
            mapview.animate(toLocation: position)
            mapview.animate(toZoom: 15)
            
             toppickuplocation.textColor = UIColor.black
             bottomdroplocationtext.textColor = UIColor.lightGray
            
            dotaddressimage.image = UIImage(named: "pickupaddress") as UIImage?
            centeraddressimage.image = UIImage(named: "Record-25 (1)") as UIImage?
        
            textvalue = 0
        
        }
        
        
        
        
        
    }
    
   /* @IBAction func topdropofflocationbtn(_ sender: Any) {
        
        GlobalVarible.checklocationvalue = 2
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapview.settings.myLocationButton = false
        
      //  self.i = 1
        //  defaultmarkerimage.hidden = true
        let position = CLLocationCoordinate2DMake(GlobalVarible.UserDropLat, GlobalVarible.UserDropLng)
        // self.setuplocationMarker(position)
        mapview.animate(toLocation: position)
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
        
    }*/
    
    @IBAction func bottomdroplocationbtn(_ sender: Any) {
        
        
        
        if(GlobalVarible.UserDropLocationText == NSLocalizedString("No drop off point", comment: "")){
            
            GlobalVarible.checklocationvalue = 2
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
            
          //  self.i = 1
            
            bottomdroplocationtext.text = GlobalVarible.UserDropLocationText
            toppickuplocation.text = GlobalVarible.Pickuptext
            bottomdroplocationtext.textColor = UIColor.black
             toppickuplocation.textColor = UIColor.lightGray
            textvalue = 1
            
          // self.topdroplocationview.isHidden = false
          //  self.bottompicklocatioview.isHidden = false
          //  self.toppicklocationview.isHidden = true
          //  self.bottomdroplocationview.isHidden = true
           // self.topdroplocationview.slidebottom()
            
             dotaddressimage.image = UIImage(named: "dropoffaddress") as UIImage?
            centeraddressimage.image = UIImage(named: "Record-25") as UIImage?
        }
    else{
            
            
            if textvalue == 1{
                
                
                
                GlobalVarible.checklocationvalue = 2
                let autocompleteController = GMSAutocompleteViewController()
                autocompleteController.delegate = self
                present(autocompleteController, animated: true, completion: nil)
                
                //  self.i = 1
                
                bottomdroplocationtext.text = GlobalVarible.UserDropLocationText
                toppickuplocation.text = GlobalVarible.Pickuptext
                bottomdroplocationtext.textColor = UIColor.black
                toppickuplocation.textColor = UIColor.lightGray
                textvalue = 1

                
               
            
            
            
            }else{
                
                toppickuplocation.textColor = UIColor.lightGray
                bottomdroplocationtext.textColor = UIColor.black
                textvalue = 1
            
            self.i = 1
            
    GlobalVarible.checklocationvalue = 2
    bottomdroplocationtext.text = GlobalVarible.UserDropLocationText
    toppickuplocation.text = GlobalVarible.Pickuptext
  //  self.topdroplocationview.isHidden = false
  //  self.bottompicklocatioview.isHidden = false
  //  self.toppicklocationview.isHidden = true
   // self.bottomdroplocationview.isHidden = true
   // self.topdroplocationview.slidebottom()
            dotaddressimage.image = UIImage(named: "dropoffaddress") as UIImage?
            centeraddressimage.image = UIImage(named: "Record-25") as UIImage?
    
    print(GlobalVarible.UserDropLat)
    print(GlobalVarible.UserDropLng)
    let position = CLLocationCoordinate2DMake(GlobalVarible.UserDropLat, GlobalVarible.UserDropLng)
    // self.setuplocationMarker(position)
    mapview.animate(toLocation: position)
    mapview.animate(toZoom: 15)
    
    }
            
        }

    
    
    }

  /*  @IBAction func bottompicklocationbtn(_ sender: Any) {
        
        bottomdroplocationtext.text = GlobalVarible.UserDropLocationText
        toppickuplocation.text = GlobalVarible.Pickuptext
        self.topdroplocationview.isHidden = true
        self.bottompicklocatioview.isHidden = true
        self.toppicklocationview.isHidden = false
        self.bottomdroplocationview.isHidden = false
      //  self.toppicklocationview.slidebottom()
        
        dotaddressimage.image = UIImage(named: "pickupaddress") as UIImage?
        centeraddressimage.image = UIImage(named: "Record-25 (1)") as UIImage?
       self.i = 1
        GlobalVarible.checklocationvalue = 1
        let position = CLLocationCoordinate2DMake(Double(GlobalVarible.PickUpLat)!, Double(GlobalVarible.PickUpLng)!)
        // self.setuplocationMarker(position)
        mapview.animate(toLocation: position)
        mapview.animate(toZoom: 15)
        

        
        
        
    }*/
    
    
    @IBAction func menubtn(_ sender: Any) {
        
        if(GlobalVarible.UserDropLocationText == NSLocalizedString("No drop off point", comment: "")){

        
        GlobalVarible.checklocationvalue = 1
            
        }else{
        
        }
        
          self.eventAnimationPopUp()
    }
    
    
    
   
    
    func eventAnimationPopUp(){
        
        //  slidinginnerview.layer.cornerRadius = 5
        
        slidingview.layer.cornerRadius = 5
        slidingview.clipsToBounds = true
        
        if let window = UIApplication.shared.keyWindow{
            print(window.frame)
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            let lefswipe = (UISwipeGestureRecognizer(target: self, action:#selector(slideToRightWithGestureRecognizer)))
            lefswipe.direction = .left
            self.blackView.addGestureRecognizer(lefswipe)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(slidingview)
            slidingview.frame = CGRect(x: 15, y: 15, width: window.frame.width-100, height: window.frame.height-30)
            blackView.frame = window.frame
            blackView.alpha = 0
            //self.sligingview.alpha = 1
            
            slidingview.slideLeft()
            self.slidingview.alpha = 1
            blackView.alpha = 1
            //sligingview.slideLeft()
            
        }
    }
    func handleDismiss() {
        //sligingview.slideLeft()
        slidingview.slideRight()
        self.slidingview.alpha = 0
        self.blackView.alpha = 0
        //self.blackView.removeFromSuperview()
        //self.sligingview.removeFromSuperview()
    }
    func slideToRightWithGestureRecognizer(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped right")
                slidingview.slideRight()
                self.slidingview.alpha = 0
                self.blackView.alpha = 0
            default:
                break
            }
        }
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([GlobalVarible.ContactEmail])
        mailComposerVC.setSubject(NSLocalizedString("Report Issue Regarding Tag Your Ride", comment: ""))
        mailComposerVC.setMessageBody(NSLocalizedString("Sending e-mail in-app is not so bad!", comment: ""), isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: NSLocalizedString("Could Not Send Email", comment: ""), message: NSLocalizedString("Your device could not send e-mail.  Please check e-mail configuration and try again.", comment: ""), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return dataArray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = menutable.dequeueReusableCell(withIdentifier: "MenuTable1", for: indexPath)
        
        
        
        let imageview :UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        let label : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        let labelshow : UILabel = (cell.contentView.viewWithTag(3) as? UILabel)!
        
        if indexPath.row == 5{
            labelshow.isHidden = false
                
                
        }else  {
            labelshow.isHidden = true
        }
        
        let image = UIImage(named: imageArray[indexPath.row])
        
        imageview.image = image
        label.text = dataArray[indexPath.row]
        
        imageview.image = imageview.image!.withRenderingMode(.alwaysTemplate)
        imageview.tintColor = UIColor(red:75/256, green: 25/256, blue: 76/256, alpha: 0.8)
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        menutable.deselectRow(at: indexPath as IndexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        
        
       if(indexPath.row == 0){
            
            //   self.dismissViewControllerAnimated(true, completion: nil)
            
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
        
        
    
        
            // self.revealViewController().revealToggleAnimated(true)
            
        }
        
        if(indexPath.row == 1)
        {
            
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
                     
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let yourViewController = storyBoard.instantiateViewController(withIdentifier: "YourRideViewController") as! YourRideViewController
            
            self.present(yourViewController, animated:true, completion:nil)
            
            
            
            
            
            
        }
        
        
        if(indexPath.row == 2)
        {
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let selectcardviewcontroller = storyBoard.instantiateViewController(withIdentifier: "SelectCardViewController") as! SelectCardViewController
            
            self.present(selectcardviewcontroller, animated:true, completion:nil)
                        
            
        }
        
        if(indexPath.row == 3)
        {
            
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mapViewController = storyBoard.instantiateViewController(withIdentifier: "RateCardViewController") as! RateCardViewController
            
            self.present(mapViewController, animated:true, completion:nil)
            
            // self.revealViewController().revealToggleAnimated(true)
            
            
            
        }
        
        if(indexPath.row == 4)
        {
            /*
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mapViewController = storyBoard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
            
            self.present(mapViewController, animated:true, completion:nil)
            
            
                       //   self.revealViewController().revealToggleAnimated(true)
            
            */
            
        }
        
        
         if(indexPath.row == 5){
            
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mapViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            
            self.present(mapViewController, animated:true, completion:nil)
            

            
            
        }
        
        if(indexPath.row == 6){
                
                self.slidingview.alpha = 0
                self.blackView.alpha = 0
                let mailComposeViewController = configuredMailComposeViewController()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    self.showSendMailErrorAlert()
                }

          
            
            
            //  UIApplication.sharedApplication().openURL(NSURL(string : "tel://\(GlobalVarible.ContactTelephone)")!)
            //  self.revealViewController().revealToggleAnimated(true)
            
        }
        
        if(indexPath.row == 7){
            
           /* self.slidingview.alpha = 0
            self.blackView.alpha = 0
            if let url = NSURL(string: "telprompt://\(GlobalVarible.ContactTelephone)") {
                UIApplication.shared.openURL(url as URL)
            }*/
            
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: CustomerSupportViewController = storyboard.instantiateViewController(withIdentifier: "CustomerSupportViewController") as! CustomerSupportViewController
            self.present(nextController, animated: true, completion: nil)
            

            
            
            
            
            
        }
        
        if(indexPath.row == 8){
            
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let termsViewController = storyBoard.instantiateViewController(withIdentifier: "TemsConditionsViewController") as! TemsConditionsViewController
            self.present(termsViewController, animated:true, completion:nil)
            //  self.revealViewController().revealToggleAnimated(true)

            
            
        }
        if(indexPath.row == 9){
        
            self.slidingview.alpha = 0
            self.blackView.alpha = 0
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let aboutViewController = storyBoard.instantiateViewController(withIdentifier: "AboutusViewController") as! AboutusViewController
            self.present(aboutViewController, animated:true, completion:nil)
            //  self.revealViewController().revealToggleAnimated(true)

        
        }
        
        
       
    }
    
    
   /* override func viewDidAppear(_ animated: Bool) {
        //auto selected 1st item
        let indexPathForFirstRow = IndexPath(row: 0, section: 0)
        self.MapCollectionview?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: .top)
         self.GetDatafromfirebase()
    }*/
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionsize
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MapCollectionview.dequeueReusableCell(withReuseIdentifier: "Mapcollectioncell", for: indexPath) as! CarCollectionViewCell
      
        cell.container.layer.shadowColor = UIColor.gray.cgColor
        cell.container.layer.shadowOpacity = 1
        cell.container.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.container.layer.shadowRadius = 2
        
          //  .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        let newString = CarsTimedata.details![indexPath.row].carTypeImage!
        print(newString)
        
        let url = imageUrl + newString
        
        let url1 = NSURL(string: url)
        
        cell.carimage!.af_setImage(withURL:
            url1! as URL,
            placeholderImage: UIImage(named: "dress"),
            filter: nil,
            imageTransition: .crossDissolve(1.0))
        
        
        if(checkvaluecollectioncell == indexPath.row)
        {
            
            
           // cell.container.layer.backgroundColor =  (UIColor(red: 179.0/255.0, green: 191.0/255.0, blue: 191.0/255.0, alpha: 1.0) as! CGColor)
         //   cell.container.layer.backgroundColor = UIColor.lightGray.cgColor
            
            cell.container.backgroundColor = UIColor(red:147.0/255.0, green:165.0/255.0, blue:165.0/255.0, alpha:1.0)
            
          //  cell.carname.textColor = UIColor.white
            cell.cartime.textColor = UIColor.white
            
            // cell.checkRadioBtn.image = UIImage(named: "Circled Dot-35 (1)")
            
        }else{
            
            cell.container.backgroundColor = UIColor.white
           // cell.carname.textColor = UIColor(red:147.0/255.0, green:165.0/255.0, blue:165.0/255.0, alpha:1.0)
            cell.cartime.textColor = UIColor(red:55.0/255.0, green:0.0/255.0, blue:57.0/255.0, alpha:1.0)
            // cell.checkRadioBtn.image = UIImage(named: "Circle Thin-35 (1)")
            
        }
        
        
        cell.cartime.text = CarsTimedata.details![indexPath.row].carTypeName!
        
      //  cell.cartime.text = CarsTimedata.details![indexPath.row].baseFare!
        
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //   let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CarCollectionViewCell
        //   cell.container.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        
        checkvaluecollectioncell = indexPath.row
        
        self.selectvalue = 1
        
        self.markers.removeAll()
        self.driverIds.removeAll()
        
        
        
        
       if(UserDefaults.standard.object(forKey: "PreferredLanguage") as! String == "en"){
            
            GlobalVarible.firstcarname = CarsTimedata.details![indexPath.row].carTypeName!
            GlobalVarible.cartypename = CarsTimedata.details![indexPath.row].carTypeName!
        }else{
            GlobalVarible.firstcarname = CarsTimedata.details![indexPath.row].carTypeName!
            GlobalVarible.cartypename = CarsTimedata.details![indexPath.row].carTypeName!
        }
        
        GlobalVarible.car_type_id = CarsTimedata.details![indexPath.row].carTypeId!
        
        
        GlobalVarible.cartypeid = CarsTimedata.details![indexPath.row].carTypeId!
        
        GlobalVarible.Cityid = CarsTimedata.details![indexPath.row].cityId!
             
        GlobalVarible.cartypeimage = CarsTimedata.details![indexPath.row].carTypeImage!
        
        
        if CarsTimedata.details![indexPath.row].rideMode == "2"{
            
            print("ridemode2")
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.SelectRentalCar(CityID: GlobalVarible.Cityid)
            
        }else{
            self.mapview.clear()
             self.postdata.removeAll()
            self.datagetfromgeofire()
           // self.GetDatafromfirebase()
            
        }
        
        
        MapCollectionview.reloadData()
        
        
    }
    
    
    
    func datagetfromgeofire(){
        
        
       
    
    
        let geofireRef = self.ref.child("geofire")
        
        let geoFire = GeoFire(firebaseRef: geofireRef)
        
        let center = CLLocation(latitude: Double(GlobalVarible.PickUpLat)!, longitude: Double(GlobalVarible.PickUpLng)!)
      
        let circleQuery = geoFire?.query(at: center, withRadius: 5.0)
        
        
        let queryHandle = circleQuery?.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            print("Key '\(key)' entered the search area and is at location '\(location)'")
            
            
            self.postdata.append(key!)
            
             print(self.postdata)
            
        })
        
        
        circleQuery?.observeReady({
            
        for postId in self.postdata {
            
            
            self.ref.child("Drivers_A").child(postId).observe(.value, with: { (snapshot) in
                
                
               /* GlobalVarible.Counter = "yes"
                self.latermoved = "RideLaterMove"
                //   self.markers.removeAll()
                //   self.driverIds.removeAll()
                self.cartypeArray.removeAll()
                // self.statusArray.removeAll()
                self.mapview.clear()
                self.movedfrom = "CarSelectHello"
                self.distanceKM.removeAll()
                self.addarray.removeAll()
                //self.seatnolabel.text = "No driver"*/
                // self.seatnolabel.text = " "
                
                let value = snapshot.value as? NSDictionary
                
                
                
                
                var cartypeid = ""
                var status = ""
                
                if(value?["driver_car_type_id"] as! String != ""){
                
                    cartypeid = value?["driver_car_type_id"] as! String
                    status = value?["driver_online_offline_status"] as! String
                
                }
                
                if(cartypeid == GlobalVarible.car_type_id ){
                    
                    self.movedfrom = "CarSelect"

                     if(value?["driver_current_latitude"]  as! String as! String != "") {
                        
                        
                        let latitude =   value?["driver_current_latitude"]  as! String
                        
                        let longitude =     value?["driver_current_longitude"] as! String
                        
                        
                        let bearningdegree =   value?["bearingfactor"] as! String
                        
                        let status =   value?["driver_online_offline_status"] as! String
                        
                        var distanceInMeter = 0.0
                        
           
                        if(self.selectvalue == 1 && status == "1"){
                            
                            
                            let coordinateTo = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
                            
                            // let coordinateFrom = CLLocation(latitude: 28.4198, longitude: 77.0382)
                            
                            let pickuplat = Double(GlobalVarible.PickUpLat)
                            let pickuplng = Double(GlobalVarible.PickUpLng)
                            
                            let coordinateFrom = CLLocation(latitude: pickuplat! , longitude: pickuplng!)
                            
                            distanceInMeter =  coordinateFrom.distance(from: coordinateTo)
                            
                            let distanceInKilometer =  distanceInMeter * 0.001
                            
                            print(distanceInKilometer)
                            
                            
                            
                            self.distanceKM.append(distanceInKilometer)
                            
                            self.addarray.append(postId as AnyObject)
                            
                            
                            self.minimumValue = self.distanceKM.min()
                            

                    
                }
                        
                         mapviewcontroller.setMarkers(driverId: postId, lat: Double(latitude)!, long: Double(longitude)! ,status: Int(status)! , cartypeid: cartypeid ,BearningFactor: bearningdegree)

                
              
                            
                            
                        }
                        
                        
                        
                    }else{
                        
                        
                    }
                    

         
            
            }) { (error) in
                print(error.localizedDescription)
            }
            
            }
        
        
        
        
        })
        
       
    
    
    
    }
    
    
    
    func GetDatafromfirebase(){
    
    
    
        ref.child("Drivers_A").observe(.value, with: { (snapshot) in
            
            
            GlobalVarible.Counter = "yes"
            self.latermoved = "RideLaterMove"
            //   self.markers.removeAll()
            //   self.driverIds.removeAll()
            self.cartypeArray.removeAll()
            // self.statusArray.removeAll()
            self.mapview.clear()
            self.movedfrom = "CarSelectHello"
            self.distanceKM.removeAll()
            self.addarray.removeAll()
            //self.seatnolabel.text = "No driver"
            // self.seatnolabel.text = " "
            
            
            
            for items in snapshot.children
            {
                
                
                var cartypeid = ""
                var status = ""
                
               /*  if let city = ((items as AnyObject).childSnapshot(forPath: "driver_car_type_id").value) {
                    let cartype = (items as AnyObject).childSnapshot(forPath: "driver_car_type_id").value
                    print(cartype ?? "nil")
                    print("hellocity")
                    
                 }else{*/
                
             if((items as AnyObject).childSnapshot(forPath: "driver_car_type_id").value as! String != ""){
                    
                    cartypeid = (items as AnyObject).childSnapshot(forPath: "driver_car_type_id").value as! String
                    status = (items as AnyObject).childSnapshot(forPath: "driver_online_offline_status").value as! String
                    
                    
                }
            
            
                if(cartypeid == GlobalVarible.car_type_id ){
                    
                    self.movedfrom = "CarSelect"
                    
                    if  (items as AnyObject).childSnapshot(forPath: "driver_current_latitude").value as! String != "" {
                        
                       /* if let driverlat = (items as AnyObject).childSnapshot(forPath: "driver_current_latitude").value {
                            
                            
                        }else{*/
                    
                        
                      //    if((items as AnyObject).value(forKey: "driver_current_latitude")  as! String != "") {
                        
                        let latitude =   (items as AnyObject).childSnapshot(forPath: "driver_current_latitude").value as! String
                        
                        let longitude =     (items as AnyObject).childSnapshot(forPath: "driver_current_longitude").value as! String
                        
                        
                        let bearningdegree =   (items as AnyObject).childSnapshot(forPath: "bearingfactor").value as! String
                        
                        let status =   (items as AnyObject).childSnapshot(forPath: "driver_online_offline_status").value as! String
                        
                        var distanceInMeter = 0.0
                        
                        
                        
                        if(self.selectvalue == 1 && status == "1"){
                            
                            
                            let coordinateTo = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
                            
                            // let coordinateFrom = CLLocation(latitude: 28.4198, longitude: 77.0382)
                            
                            let pickuplat = Double(GlobalVarible.PickUpLat)
                            let pickuplng = Double(GlobalVarible.PickUpLng)
                            
                            let coordinateFrom = CLLocation(latitude: pickuplat! , longitude: pickuplng!)
                            
                             distanceInMeter =  coordinateFrom.distance(from: coordinateTo)
                            
                            let distanceInKilometer =  distanceInMeter * 0.001
                            
                            print(distanceInKilometer)
                            
                            
                            
                            self.distanceKM.append(distanceInKilometer)
                            
                            self.addarray.append(items as AnyObject)
                            
                            
                            self.minimumValue = self.distanceKM.min()
                            
                            if distanceInMeter < 5000 {
                                
                                mapviewcontroller.setMarkers(driverId: (items as AnyObject).key!, lat: Double(latitude)!, long: Double(longitude)! ,status: Int(status)! , cartypeid: cartypeid ,BearningFactor: bearningdegree)
                            }

                            
                        }
                        
                       // mapviewcontroller.setMarkers(driverId: (items as AnyObject).key!, lat: Double(latitude)!, long: Double(longitude)! ,status: Int(status)! , cartypeid: cartypeid ,BearningFactor: bearningdegree)
                        
                        
                    }
                    
                
                
                }else{
                    
                    
                }
                
            }
            
            if(self.selectvalue == 1){
                /* for (index , items )  in  self.distanceKM.enumerated()
                 {
                 
                 
                 if self.minimumValue ==  items
                 {
                 self.nearstDriverUserDistance =  items
                 let latitude = self.addarray[index].value["driver_current_latitude"] as! String
                 let longitude = self.addarray[index].value["driver_current_longitude"] as! String
                 
                 ApiManager.sharedInstance.protocolmain_Catagory = self
                 ApiManager.sharedInstance.FindDistance1(latitude,DriverLong: longitude)
                 self.selectvalue = 0
                 
                 break
                 }
                 
                 else
                 {
                 
                 }
                 
                 }*/
                
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
       
    }
    
    
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            
            locationManager.startUpdatingLocation()
            mapview.animate(toZoom: 15)
           // mapview.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            
            reverseGeocodeCoordinate(coordinate: location.coordinate)
            mapview.animate(toLocation: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            mapview.animate(toZoom: 15)
            self.locationManager.stopUpdatingLocation()

            
        }
    
    
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        self.ridenowview.isHidden = true
        
       // reverseGeocodeCoordinate(coordinate: position.target)
        
        
        
    }
    
    
   
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        if mapcameracheck == 1 {
            
         mapcameracheck = 0
        }else{
            if(GlobalVarible.checklocationvalue == 2){
                
            }else{
             self.mapview.clear()
            self.postdata.removeAll()
            self.datagetfromgeofire()
                
            }
            
        reverseGeocodeCoordinate(coordinate: position.target)
        
        }
        
        
        //self.ridenowview.hidden = false
       
        
        print(position.target.latitude)
        print(position.target.longitude)
        
    }
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                self.ridenowview.isHidden = false
                
                
                // let lines = address.lines
                
                
                
                if(GlobalVarible.checklocationvalue == 1){
                    
                    
                    if(self.i == 1){
                        self.toppickuplocation.text =  GlobalVarible.Pickuptext
                        self.i = 0
                        
                    }else{

                        let lines = address.lines
                        self.toppickuplocation.text = lines!.joined(separator: "\n")
                        GlobalVarible.Pickuptext = lines!.joined(separator: "\n")
                        
                       

                    print(GlobalVarible.Pickuptext)
                    GlobalVarible.PickUpLat  = String(coordinate.latitude)
                    GlobalVarible.PickUpLng = String(coordinate.longitude)
                    GlobalVarible.k = 0
                        
                        
                        
                        if let city = address.locality{
                            
                            GlobalVarible.usercityname1  = String(city)
                            
                        }
                        else{
                            GlobalVarible.usercityname1 = "Dummy City"
                            
                        }

                        
                        if (GlobalVarible.usercityname == GlobalVarible.usercityname1){
                            
                            
                        }else{
                            
                            
                            GlobalVarible.usercityname = GlobalVarible.usercityname1
                            ApiManager.sharedInstance.protocolmain_Catagory = self
                            ApiManager.sharedInstance.ViewCarsWithTime(UserCityName: GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
                        }
                        
                        
                    }
                }
                
                
                if(GlobalVarible.checklocationvalue == 3){
                    
                    
                    if(self.i == 1){
                        self.toppickuplocation.text =  GlobalVarible.Pickuptext
                        self.i = 0
                        
                        
                        if let city = address.locality{
                            
                            GlobalVarible.usercityname1  = String(city)
                            
                        }
                        else{
                            GlobalVarible.usercityname1 = "Dummy City"
                            
                        }
                        
                        
                        if (GlobalVarible.usercityname == GlobalVarible.usercityname1){
                            
                            
                        }else{
                            
                            GlobalVarible.usercityname = GlobalVarible.usercityname1
                            
                            ApiManager.sharedInstance.protocolmain_Catagory = self
                            ApiManager.sharedInstance.ViewCarsWithTime(UserCityName: GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
                        }
                        

                        
                    }else{
                        
                        let lines = address.lines
                        self.toppickuplocation.text = lines!.joined(separator: "\n")
                        GlobalVarible.Pickuptext = lines!.joined(separator: "\n")
                        
                       
                        print(GlobalVarible.Pickuptext)
                        GlobalVarible.PickUpLat  = String(coordinate.latitude)
                        GlobalVarible.PickUpLng = String(coordinate.longitude)
                        GlobalVarible.k = 0
                        
                        
                        if let city = address.locality{
                            
                            GlobalVarible.usercityname1  = String(city)
                            
                        }
                        else{
                            GlobalVarible.usercityname1 = "Dummy City"
                            
                        }
                        
                        
                        if (GlobalVarible.usercityname == GlobalVarible.usercityname1){
                            
                            
                        }else{
                            
                            GlobalVarible.usercityname = GlobalVarible.usercityname1
                            
                            ApiManager.sharedInstance.protocolmain_Catagory = self
                            ApiManager.sharedInstance.ViewCarsWithTime(UserCityName: GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
                        }

                        
                    }
                }

                
                if(GlobalVarible.checklocationvalue == 2){
                    
                    
                    if(self.i == 1){
                        self.bottomdroplocationtext.text =  GlobalVarible.UserDropLocationText
                        self.i = 0
                        
                    }else{
                        

                        let lines = address.lines
                        self.bottomdroplocationtext.text = lines!.joined(separator: "\n")
                        GlobalVarible.UserDropLocationText = lines!.joined(separator: "\n")
                        
                    GlobalVarible.UserDropLat = coordinate.latitude
                    GlobalVarible.UserDropLng = coordinate.longitude
                  
                    }
                }
                
                //  MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                if(self.matchvalue == 0){
                    
                    ApiManager.sharedInstance.protocolmain_Catagory = self
                    ApiManager.sharedInstance.ViewCarsWithTime(UserCityName: GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
                    self.matchvalue = 1
                    
                }else{
                    
                    
                }
                
                
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
                
            }
            
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
        
        if(GlobalVarible.Api == "CarsTimeModel"){
            CarsTimedata = data as! CarsTImeModel
            
            
        //    print(CarsTimedata.msg?.count ?? <#default value#>)
            if(CarsTimedata.status == 0){
                
                self.ridenowview.layer.isHidden = true
                self.NoOperateview.layer.isHidden = false

                self.matchvalue = 0
                collectionsize = 0
                
            }else{
                
                
                
                self.ridenowview.layer.isHidden = false
                self.NoOperateview.layer.isHidden = true

                collectionsize = (CarsTimedata.details?.count)!
                
                if CarsTimedata.currencyUnicode == "0"{
                
                    GlobalVarible.currencysymbol = CarsTimedata.currencyIsoCode!
                
                }else{
                    
                    let charAsString = CarsTimedata.currencyUnicode
                    
                    let charAsInt = Int(charAsString!, radix: 16)!
                    let uScalar = UnicodeScalar(charAsInt)!
                    
                    print("\(uScalar)")
                    
                     GlobalVarible.currencysymbol = "\(uScalar)"
                
                
                }
                
                
                
                let indexPathForFirstRow = IndexPath(row: 0, section: 0)
               // self.MapCollectionview?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: .top)
                
              self.collectionView(MapCollectionview, didSelectItemAt: indexPathForFirstRow)
              //  self.GetDatafromfirebase()
                
            }
            
            MapCollectionview.reloadData()
            
            
            
        }
        
        if( GlobalVarible.Api == "RentalModel"){
            
            rentaldata = data as! RentalModel
            
            if(rentaldata.status == 0){
                
                self.showalert(message: rentaldata.message!)
                
            }else{
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let bookrentalviewcontroller = storyBoard.instantiateViewController(withIdentifier: "BookYourRentalViewController") as! BookYourRentalViewController
                // bookrentalviewcontroller.viewcontrollerself = self
                bookrentalviewcontroller.rentaldata = self.rentaldata
                
                bookrentalviewcontroller.modalPresentationStyle = .overCurrentContext
                //  paymentviewcontroller.modalPresentationStyle = .Popover
                self.present(bookrentalviewcontroller, animated:true, completion:nil)
                
                
            }
            
            
            
        }

        
        if(GlobalVarible.Api == "usersyncwhenappterminate"){
            
            usersyncdata = data as! CustomerSyncModel
            
                   
            if(usersyncdata.result == 0){
                
                self.matchvalue = 0
                
             //   self.showalert1(message: "Your Notification has been expired!!")
                
                
            }else
            {
                
                if(usersyncdata.details?.rideStatus == "3"){
                    
                  // self.matchvalue = 0
                    
                     GlobalVarible.timerForGetDriverLocation1.invalidate()
                    
                    GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!
                    
                  let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: TrackRideViewController = storyboard.instantiateViewController(withIdentifier: "TrackRideViewController") as! TrackRideViewController
                    nextController.Currentrideid = (usersyncdata.details?.rideId)!
                    nextController.currentStatus = (usersyncdata.details?.rideStatus)!
                    self.present(nextController, animated: true, completion: nil)
                    
                }
                
                if(usersyncdata.details?.rideStatus == "4"){
                    
                    self.matchvalue = 0
                    
                    
                    
                }
                
               
                if(usersyncdata.details?.rideStatus == "5"){
                    
                   // self.matchvalue = 0
                    
                    GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!

                    
                   let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: TrackRideViewController = storyboard.instantiateViewController(withIdentifier: "TrackRideViewController") as! TrackRideViewController
                    nextController.Currentrideid = (usersyncdata.details?.rideId)!
                    nextController.currentStatus = (usersyncdata.details?.rideStatus)!
                    self.present(nextController, animated: true, completion: nil)
                }
                
                if(usersyncdata.details?.rideStatus == "6"){
                    
                   // self.matchvalue = 0
                    
                    GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!

                    
                   let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: TrackRideViewController = storyboard.instantiateViewController(withIdentifier: "TrackRideViewController") as! TrackRideViewController
                    nextController.Currentrideid = (usersyncdata.details?.rideId)!
                    nextController.currentStatus = (usersyncdata.details?.rideStatus)!
                    self.present(nextController, animated: true, completion: nil)
                
                    
                }
                if(usersyncdata.details?.rideStatus == "7"){
                    
                  //  GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!

                    
                   let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: NewPaymentViewController = storyboard.instantiateViewController(withIdentifier: "NewPaymentViewController") as! NewPaymentViewController
                    
                    nextController.currentrideid = (usersyncdata.details?.rideId)!
                    
                    
                   self.present(nextController, animated: true, completion: nil)
                    
                }
                  if(usersyncdata.details?.rideStatus == "11"){
                    
                    
                     GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: RentalTrackRideViewController = storyboard.instantiateViewController(withIdentifier: "RentalTrackRideViewController") as! RentalTrackRideViewController
                    nextController.Currentrideid = (usersyncdata.details?.rideId)!
                    nextController.currentStatus = (usersyncdata.details?.rideStatus)!
                    self.present(nextController, animated: true, completion: nil)
                    
                }
                
                if(usersyncdata.details?.rideStatus == "12"){
                    
                     GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: RentalTrackRideViewController = storyboard.instantiateViewController(withIdentifier: "RentalTrackRideViewController") as! RentalTrackRideViewController
                    nextController.Currentrideid = (usersyncdata.details?.rideId)!
                    nextController.currentStatus = (usersyncdata.details?.rideStatus)!
                    self.present(nextController, animated: true, completion: nil)
                    
                }
                
                if(usersyncdata.details?.rideStatus == "13"){
                    
                     GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: RentalTrackRideViewController = storyboard.instantiateViewController(withIdentifier: "RentalTrackRideViewController") as! RentalTrackRideViewController
                    nextController.Currentrideid = (usersyncdata.details?.rideId)!
                    nextController.currentStatus = (usersyncdata.details?.rideStatus)!
                    self.present(nextController, animated: true, completion: nil)
                    
                }
                
                if(usersyncdata.details?.rideStatus == "16"){
                    
                     GlobalVarible.checkRideId = (usersyncdata.details?.rideId)!
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: RentalRecieptViewController = storyboard.instantiateViewController(withIdentifier: "RentalRecieptViewController") as! RentalRecieptViewController
                    
                    nextController.currentrideid = (usersyncdata.details?.rideId)!
                    
                     self.present(nextController, animated: true, completion: nil)
                }


        
        
        
        }

        
    }
    

    }

    


}

extension MapViewController {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print(place)
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        print("Place attributions: \(place.coordinate.latitude)")
        print("Place attributions: \(place.coordinate.longitude)")
      //  manualloactioncheck = "manual"
        if GlobalVarible.checklocationvalue == 3{
            self.i = 1
           // GlobalVarible.Pickuptext = place.formattedAddress!
            GlobalVarible.Pickuptext = place.name
            GlobalVarible.PickUpLat = String(place.coordinate.latitude)
            GlobalVarible.PickUpLng = String(place.coordinate.longitude)

        }
        
        if GlobalVarible.checklocationvalue == 2{
            self.i = 1
           // GlobalVarible.UserDropLocationText = place.formattedAddress!
             GlobalVarible.UserDropLocationText = place.name
            GlobalVarible.UserDropLat = place.coordinate.latitude
            GlobalVarible.UserDropLng = place.coordinate.longitude
            
        }

        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension MapViewController
    
{
    
    func setMarkers(driverId: String ,lat:Double , long: Double , status: Int , cartypeid: String,BearningFactor: String)
    {
        
        
        var Index = -10
        
        for (index , items) in driverIds.enumerated()
        {
            if items == driverId
            {
                
                Index = index
                print(index)
                break
            }
            else
            {
                Index = -10
            }
            
        }
        
        
        print(Index)
        if Index != -10
        {
            
            //  self.seatnolabel.text = totaltime
            print(status)
            
            // let oldLocationCenter = CLLocation(latitude:  Double(GlobalVarible.PickUpLat)!, longitude:  Double(GlobalVarible.PickUpLng)!)
            
            //  let location = CLLocation(latitude: lat, longitude: long)
            
            self.updateMarker(index: Index ,driverId: driverId , lat: lat , long: long , status: status , cartypeid: cartypeid , degrees: Double(BearningFactor)! , duration: 1.0)
            //  self.updateMarker(Index ,driverId: driverId , lat: lat , long: long , status: status , cartypeid: cartypeid)
            
        }
        
        if Index == -10 // Means Marker Not Added
        {
            
            if status == 2 {
                
                
                return
                
                
                
            }
                
            else
            {
                
                self.driverIds.append(driverId)
                let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let marker = GMSMarker(position: coordinates)
                
                /*  let url1 = NSURL(string: markerimageurl)
                 
                 let data:NSData = NSData.init(contentsOfURL: url1!)!
                 
                 marker.icon = UIImage.init(data: data)*/
               
                
                if cartypeid == "1"{
                    
                    marker.icon = UIImage(named: "marker_blue@80")
                    //ic_car_green
                }else if cartypeid == "2"{
                    
                    marker.icon = UIImage(named: "marker_yellow@80")
                }else if cartypeid == "3"{
                    
                    marker.icon = UIImage(named: "marker_red@80")
                    // ic_luxurycar_30
                }else if cartypeid == "4"{
                    
                    marker.icon = UIImage(named: "marker_gray@80")
                }else if cartypeid == "5"{
                    marker.icon = UIImage(named: "marker_blue@80")
                    
                }else if cartypeid == "6"{
                    marker.icon = UIImage(named: "marker_gray@80")
                    
                }else{
                    
                    marker.icon = UIImage(named: "marker_blue@80")
                }
                
                
                
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(1.0)
                marker.rotation = Double(BearningFactor)!
                CATransaction.commit()
                
                // marker.icon = UIImage(named: "car_30")
                
                
                // Setting Tags to marker for get Positions
                marker.accessibilityLabel = driverId
                marker.accessibilityValue = String(status)
                
                self.markers.append(marker)
                self.setMarker()
                
                
            }
            
            
            
        }
        
    }
    
    
    
   
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        print("hello")
        
        let index:Int! = Int(marker.accessibilityLabel!)
        
        print(index)
        
        
    }
    
    
    
}

extension MapViewController
{
    func setMarker()
    {
        self.mapview.clear()
        for items in self.markers
        {
            
            
            items.map = mapview
            
        }
        
    }
    
    
    
    func updateMarker(index: Int , driverId: String ,lat:Double , long: Double , status: Int , cartypeid: String, degrees: CLLocationDegrees, duration: Double)
        // {
        
        // func updateMarker(index: Int , driverId: String ,lat:Double , long: Double , status: Int , cartypeid: String)
    {
        
        
        if status == 2  // Offline
        {
            self.markers.remove(at: index)
            self.driverIds.remove(at: index)
            self.setMarker()
        }
            
        else  // Online
        {
            
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let marker = GMSMarker(position: coordinates)
            
            
            /*  let url1 = NSURL(string: markerimageurl)
             
             
             
             //  var url:NSURL = NSURL.URLWithString("http://myURL/ios8.png")!
             
             let data:NSData = NSData.init(contentsOfURL: url1!)!
             
             marker.icon = UIImage.init(data: data)*/
            
            
            
            
          
            
            if cartypeid == "1"{
                
                marker.icon = UIImage(named: "marker_blue@80")
                //ic_car_green
            }else if cartypeid == "2"{
                
                marker.icon = UIImage(named: "marker_yellow@80")
            }else if cartypeid == "3"{
                
                marker.icon = UIImage(named: "marker_red@80")
                // ic_luxurycar_30
            }else if cartypeid == "4"{
                
                marker.icon = UIImage(named: "marker_gray@80")
            }else if cartypeid == "5"{
                marker.icon = UIImage(named: "marker_blue@80")
                
            }else if cartypeid == "6"{
                marker.icon = UIImage(named: "marker_gray@80")
                
            }else{
                
                marker.icon = UIImage(named: "marker_blue@80")
            }
            
            
            
           
            
            marker.accessibilityLabel = driverId
            marker.accessibilityValue = String(status)
            
            print(degrees)
            CATransaction.begin()
            CATransaction.setAnimationDuration(1.0)
            marker.rotation = degrees
            CATransaction.commit()
            
            // Movement
            CATransaction.begin()
            CATransaction.setAnimationDuration(duration)
            marker.position = coordinates
            
        
            
            CATransaction.commit()
            
         
            self.markers[index] = marker
            self.setMarker()
            
        }
        
        
}

}
