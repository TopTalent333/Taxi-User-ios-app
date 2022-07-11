//
//  RideLaterViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 29/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class RideLaterViewController: UIViewController,MainCategoryProtocol {
    
    
     var timer = Timer()
    
    
    var markerList = [GMSMarker]()
    
   
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    
    
    var originCoordinate: CLLocationCoordinate2D!
    
    var destinationCoordinate: CLLocationCoordinate2D!
    
    var polyline = GMSPolyline()
    var animationPolyline = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()
    var i: UInt = 0

     let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    
    @IBOutlet weak var locationview: UIView!
    
    @IBOutlet weak var selectpaymentmethodtext: UILabel!
    
    
    @IBOutlet weak var applycoupontext: UILabel!
    
    @IBOutlet weak var mapview: GMSMapView!
    
    @IBOutlet weak var bottomview: UIView!
    
    let imageUrl = API_URL.imagedomain
    
    @IBOutlet weak var pickuplocationtext: UILabel!
    
    @IBOutlet weak var droplocationtext: UILabel!
    
    @IBOutlet weak var droplocationview: UIView!
    
    @IBOutlet weak var imagecircleview: UIView!
    
    @IBOutlet weak var selectimage: UIImageView!
    
    
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
    
    @IBOutlet weak var selectedtimetext: UILabel!
    
    @IBOutlet weak var selecteddatetext: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickuplocationtext.text = GlobalVarible.Pickuptext
        droplocationtext.text = GlobalVarible.UserDropLocationText
        
        
        droplocationview.layer.borderWidth = 1
        droplocationview.layer.cornerRadius = 3
        droplocationview.layer.borderColor = UIColor.lightGray.cgColor
        
        mapview.layer.borderWidth = 1
        mapview.layer.cornerRadius = 3
        mapview.layer.borderColor = UIColor.lightGray.cgColor
        
        imagecircleview.layer.borderWidth = 1
        imagecircleview.layer.masksToBounds = false
        imagecircleview.layer.borderColor = UIColor.black.cgColor
        imagecircleview.layer.cornerRadius = imagecircleview.frame.height/2
        imagecircleview.clipsToBounds = true
        
         GlobalVarible.couponcodevalue = 0
        
       // GlobalVarible.PaymentOptionId = ""
        GlobalVarible.MatchCardSelect = 0

        selecteddatetext.text = GlobalVarible.SelectDate
        selectedtimetext.text = GlobalVarible.SelectTime
        
        let origin = GlobalVarible.PickUpLat + "," + GlobalVarible.PickUpLng
        let destination = String(GlobalVarible.UserDropLat) + "," + String(GlobalVarible.UserDropLng)
        
        self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
        
        
        let position = CLLocationCoordinate2DMake(Double(GlobalVarible.PickUpLat)!, Double(GlobalVarible.PickUpLng)!)
        // self.setuplocationMarker(position)
        mapview.animate(toLocation: position)
        mapview.animate(toZoom: 14)
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        if(GlobalVarible.cartypeimage == " "){
            //carnametext.text = "null"
        }else{
            let newUrl = imageUrl + GlobalVarible.cartypeimage
            //    let url = "http://apporio.co.uk/apporiotaxi/\(GlobalVarible.cartypeimage)"
            
            let url1 = NSURL(string: newUrl)
            selectimage!.af_setImage(withURL:
                url1! as URL,
                                     placeholderImage: UIImage(named: "dress"),
                                     filter: nil,
                                     imageTransition: .crossDissolve(1.0))
            
        }
        
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
        
        
        
        
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
        spinnerActivity.detailsLabel.text = NSLocalizedString("Please Wait!!", comment: "")
        spinnerActivity.isUserInteractionEnabled = false

        



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(GlobalVarible.paymentmethod)
        selectpaymentmethodtext.text = GlobalVarible.paymentmethod
        
        if(GlobalVarible.couponcodevalue == 1){
            applycoupontext.text = "Coupon Applied  " +   GlobalVarible.CouponCode
            GlobalVarible.couponcodevalue = 0
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      //  self.timer.invalidate()
    }
    
    func getDirections(origin: String!, destination: String!, waypoints: Array<String>!, travelMode: AnyObject!){
        if let originLocation = origin {
            if let destinationLocation = destination {
                let directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation + "&key=" + GlobalVarible.googlemapkeys
                
                //  directionsURLString = directionsURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                
                let directionsURL = NSURL(string: directionsURLString)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    let directionsData = NSData(contentsOf: directionsURL! as URL)
                    
                    
                    
                    do {
                        
                        let dictonary:Dictionary<String, Any> = try JSONSerialization.jsonObject(with: directionsData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        self.drawRoute(routeDict: dictonary)
                        
                    } catch {
                        NSLog("One or more of the map styles failed to load. \(error)")
                    }
                    
                    
                })
            }
            else {
                //  completionHandler("Destination is nil.", false)
            }
        }
        else {
            // completionHandler("Origin is nil", false)
        }
        
        
    }
    
    
    func drawRoute(routeDict: Dictionary<String, Any>) {
        
        let routesArray = routeDict["routes"] as! NSArray
        
        
        
        var bounds = GMSCoordinateBounds()
        if (routesArray.count > 0)
        {
            let routeDict = routesArray[0] as! Dictionary<String, Any>
            let routeOverviewPolyline = routeDict["overview_polyline"] as! Dictionary<String, Any>
            let points = routeOverviewPolyline["points"]
            
            self.originCoordinate = CLLocationCoordinate2DMake(Double(GlobalVarible.PickUpLat)!, Double(GlobalVarible.PickUpLng)!)
            
            originMarker = GMSMarker(position: self.originCoordinate)
            
                     
            
            
            self.markerList.append(originMarker)
            
            
            
            originMarker.icon = GMSMarker.markerImage(with: UIColor.red)
            //   originMarker.iconView = driverView
            
            
            originMarker.map = self.mapview
            
            
            self.destinationCoordinate = CLLocationCoordinate2DMake(GlobalVarible.UserDropLat , GlobalVarible.UserDropLng)
            
            destinationMarker = GMSMarker(position: self.destinationCoordinate)
            
            self.markerList.append(destinationMarker)
            
            
            destinationMarker.icon = GMSMarker.markerImage(with: UIColor.green)
            
            
            destinationMarker.map = self.mapview
            
            
            for marker in markerList {
                bounds = bounds.includingCoordinate(marker.position)
            }
            
            self.path = GMSPath.init(fromEncodedPath: points as! String)!
            
            self.polyline.path = path
           // self.polyline.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.polyline.strokeColor = UIColor.black
            self.polyline.strokeWidth = 3.0
            self.polyline.map = self.mapview
            let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsetsMake(50, 60, 50, 60))
            mapview.animate(with: update)
            
          //  self.timer = Timer.scheduledTimer(timeInterval: 0.020, target: self, selector: #selector(animatePolylinePath), userInfo: nil, repeats: true)
             MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func animatePolylinePath() {
        if (self.i < self.path.count()) {
            self.animationPath.add(self.path.coordinate(at: self.i))
            self.animationPolyline.path = self.animationPath
            self.animationPolyline.strokeColor = UIColor.black
            self.animationPolyline.strokeWidth = 3
            self.animationPolyline.map = self.mapview
            self.i += 1
        }
        else {
            self.i = 0
            self.animationPath = GMSMutablePath()
            self.animationPolyline.map = nil
        }
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmbtn(_ sender: Any) {
        
       /* if(GlobalVarible.PaymentOptionId == ""){
            
            self.showalert(message: "First Select Payment Method")
            
            
        }else{*/
            
            let Droplat = String(GlobalVarible.UserDropLat)
            let DropLng = String(GlobalVarible.UserDropLng)
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RideLaterConfirm(USERID: Userid!, COUPONCODE: GlobalVarible.CouponCode, USERCURRENTLAT: GlobalVarible.PickUpLat, USERCURRENTLONG: GlobalVarible.PickUpLng, CURRENTADDRESS: GlobalVarible.Pickuptext, DROPLAT: Droplat, DROPLNG: DropLng, DropLOCATION: GlobalVarible.UserDropLocationText, SELECTTIME: GlobalVarible.SelectTime, SELECTDATE: GlobalVarible.SelectDate, RIDETYPE: "2", RIDESTATUS: "1", CARTYPEID: GlobalVarible.cartypeid,PaymentOPtionId: GlobalVarible.PaymentOptionId,CardId: GlobalVarible.CardId)
     //   }
        
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
                //self.dismiss(animated: true, completion: nil)
                self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)

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
        
        if(GlobalVarible.Api == "RideLaterBook"){
            
            
            if(JSON(data)["result"] == 1){
                
                
                self.showalert1(message: NSLocalizedString("Your ride has been schedule.Driver details will be shared 15 min before your pickup time.", comment : ""))
                
                
                
            }else{
                
               self.showalert(message: NSLocalizedString("Please try Again!!!", comment : ""))
                
            }
            
            
            
            
            
        }
        

    }
    

    

}
