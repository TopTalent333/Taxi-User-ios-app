//
//  RentalTrackRideViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 18/07/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import GoogleMaps
import AlamofireImage
import SwiftyJSON
import Alamofire
import StarryStars
import MapKit
import CoreLocation
import Firebase

class RentalTrackRideViewController: UIViewController,MainCategoryProtocol {
    
    
    @IBOutlet weak var markericonimage: UIImageView!
    
    
    var rentaldriverinformationdata: RentalDriverInformationModel!
    
    var Currentrideid = ""
    
    var currentStatus = ""
    var currentmessage = ""
    
     let imageUrl = API_URL.imagedomain
    
     var ref = FIRDatabase.database().reference()
    
    var driverid = ""
    
    @IBOutlet weak var drivernameview: UIView!
    
    @IBOutlet weak var cancelbuttonview: UIView!
    
     @IBOutlet weak var driverratingresult: UILabel!
    
    @IBOutlet weak var cancelbtn: UIButton!
    
    @IBOutlet weak var ridestatustoplabel: UILabel!
    
    @IBOutlet weak var ratingview: UIView!
    
    @IBOutlet weak var driverimageview: UIImageView!
    
    @IBOutlet weak var drivername: UILabel!
    
    @IBOutlet weak var carimagecircleview: UIView!
    
    @IBOutlet weak var carimage: UIImageView!
    
    @IBOutlet weak var carname: UILabel!
    
    @IBOutlet weak var carnumber: UILabel!
    
    @IBOutlet weak var carmodelname: UILabel!
    
    
    @IBOutlet weak var greenmarkerlocation: UILabel!
    
    var startlat = ""
    var startlng = ""
    var destinationlat = ""
    var destinationlng = ""
    
    var temparorylat = ""
    var temparorylong = ""
    
    var marker = GMSMarker()
    
     var markerList = [GMSMarker]()
    
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    
    var temparoryvalue = 1
    
    var temparoryvalue1 = 1
    
    var markervalue = 1
    
    var polyline = GMSPolyline()
    var animationPolyline = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()
    var i: UInt = 0
    var timer1: Timer!
    
    var originCoordinate: CLLocationCoordinate2D!
    
    var destinationCoordinate: CLLocationCoordinate2D!
    
    private let googleMapsKey = "AIzaSyAwdw2gOgLTM_lAjEtVvIH87xHx3RTKEUQ"
    private let baseURLString = "https://maps.googleapis.com/maps/api/directions/json?"
    
    let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    


    
    @IBOutlet weak var mapview: GMSMapView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        drivernameview.layer.borderWidth = 1.0
        drivernameview.layer.cornerRadius = 4
        
        
      //  trackrideviewcontroller = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showtrack),
            name: NSNotification.Name(rawValue: "rentaltrackride"),
            object: nil)
        

        
        
        carimagecircleview.layer.borderWidth = 1
        carimagecircleview.layer.masksToBounds = false
        carimagecircleview.layer.borderColor = UIColor.black.cgColor
        carimagecircleview.layer.cornerRadius =  carimagecircleview.frame.height/2
        carimagecircleview.clipsToBounds = true
        
        GlobalVarible.rideendstopupdatelocation = 0
        
        ratingview.layer.borderWidth = 1
        ratingview.layer.masksToBounds = false
        ratingview.layer.borderColor = UIColor.black.cgColor
        ratingview.layer.cornerRadius =  carimagecircleview.frame.height/2
        ratingview.clipsToBounds = true
        
        
        driverimageview.layer.borderWidth = 1
        driverimageview.layer.masksToBounds = false
        driverimageview.layer.borderColor = UIColor.black.cgColor
        driverimageview.layer.cornerRadius =  carimagecircleview.frame.height/2
        driverimageview.clipsToBounds = true
        
        mapview.isUserInteractionEnabled =  true
        
        // mapview.myLocationEnabled = true
        
        //    GlobalSelcetvaluue = 1
        
        
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
        
        
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RentalDriverInformation(RentalBookindId:  GlobalVarible.checkRideId)
        
        //ApiManager.sharedInstance.DriverInformation(RIDEID: Currentrideid)
        
        //  self.starttimer()
        
        GlobalVarible.StringMatchPayment = "hellohi"
        
       // mapview.delegate = self
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showtrack(notification: NSNotification){

        if(GlobalVarible.checkridestatus == "11"){
            
            currentStatus = GlobalVarible.checkridestatus
            
            UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
            
            markericonimage.isHidden = true
            
            
            self.starttimer()
            ridestatustoplabel.text = "Arriving Now"
            
        }
        
        if(GlobalVarible.checkridestatus == "12"){
            
            currentStatus = GlobalVarible.checkridestatus
            
            UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
            
            markericonimage.isHidden = false
            
            
            mapview.animate(toLocation: CLLocationCoordinate2D(latitude: Double(GlobalVarible.PickUpLat)!, longitude: Double(GlobalVarible.PickUpLng)!))
            mapview.animate(toZoom: 15)

            mapview.clear()
            
            ridestatustoplabel.text = "Driver Arrived"
            
            cancelbtn.isHidden = true
            cancelbuttonview.isHidden = true
            
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
            
            
            
                        
            
        }
        
        if(GlobalVarible.checkridestatus == "13"){
            
            currentStatus = GlobalVarible.checkridestatus
            
            UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
            
            
            markericonimage.isHidden = false
            
            
            mapview.animate(toLocation: CLLocationCoordinate2D(latitude: Double(GlobalVarible.PickUpLat)!, longitude: Double(GlobalVarible.PickUpLng)!))
            mapview.animate(toZoom: 15)
            
             mapview.clear()
            ridestatustoplabel.text = "Riding Now"
            
            cancelbtn.isHidden = true
            cancelbuttonview.isHidden = true
            
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
            
            
            
        }
            
            
        if(GlobalVarible.checkridestatus == "16"){
            
            
         UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
        
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.RentalDriverInformation(RentalBookindId:  GlobalVarible.checkRideId)

        
        }
        else{
          
            
        }

        
        
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        GlobalVarible.trackbackbtnvaluematch = 1
        
       
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        if let window = self.view.window{
            window.rootViewController = nextController
        }

        
        
        
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewController(withIdentifier: "ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        next.movefrom = "Rentaltype"
        self.present(next, animated: true, completion: nil)
        
        
        
    }
    
    
    
    func starttimer(){
        
        
        
        ref.child("Drivers_A").child(driverid).observe(.value, with: { (snapshot) in
            
            print(self.driverid)
            
            
            //  if let currentData = (snapshot.value! as! NSDictionary).object(forKey: self.driverid) as? [String:AnyObject]{
            
            let value = snapshot.value as? NSDictionary
            
            
            
            let latitude =   value?["driver_current_latitude"]  as! String
            
            
            
            let longitude = value?["driver_current_longitude"] as! String
            
            
            let bearningdegree = value?["bearingfactor"] as! String
            
            print(latitude)
            print(bearningdegree)
            
            self.startlat = GlobalVarible.PickUpLat
            self.startlng = GlobalVarible.PickUpLng
            
            
            self.destinationlat = latitude
            self.destinationlng = longitude
            
            let origin = self.startlat + "," + self.startlng
            let destination = self.destinationlat + "," + self.destinationlng
            
            
            
            if self.temparoryvalue == 1 {
                // self.createRoute()
                 self.mapview.clear()
                self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
                self.temparorylat = latitude
                self.temparorylong = longitude
                self.temparoryvalue = 0
                
            }
            
            
            let coordinateTo = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
            
            // let coordinateFrom = CLLocation(latitude: 28.4198, longitude: 77.0382)
            
            let pickuplat = Double(self.temparorylat)
            let pickuplng = Double(self.temparorylong)
            
            let coordinateFrom = CLLocation(latitude: pickuplat! , longitude: pickuplng!)
            
            let distanceInMeter =  coordinateFrom.distance(from: coordinateTo)
            
            print(distanceInMeter)
            
            if distanceInMeter < 200{
                
                
            }else{
                
                self.mapview.clear()
                self.temparorylat = latitude
                self.temparorylong = longitude
                self.temparoryvalue = 1
                self.markervalue = 1
                // self.createRoute()
                self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
            }
            
           // self.cresterootviatrack(lat: latitude, long: longitude,BearningFactor: bearningdegree)
            
            
            //  }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        
    }
    
    
    func cresterootviatrack(lat: String , long: String ,BearningFactor : String){
        
        // func cresterootviatrack(lat: String , long: String){
        
        
        let coordinates = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        
        if markervalue == 1 {
            marker = GMSMarker(position: coordinates)
            marker.icon = UIImage(named: "ic_minicar_30")
            
            markervalue = 0
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        marker.rotation = Double(BearningFactor)!
        CATransaction.commit()
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        marker.position =  coordinates
        CATransaction.commit()
        marker.map = mapview
        
        
        
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
            
            
            // let legs = routeDict["legs"] as! Dictionary<String, Any>
            //  let startLocationDictionary = routeDict["legs"][0]["start_location"] as! Dictionary<String, Any>
            
            self.originCoordinate = CLLocationCoordinate2DMake(Double(self.startlat)!, Double(self.startlng)!)
            
            originMarker = GMSMarker(position: self.originCoordinate)
            
            
            
            self.markerList.append(originMarker)
            
            
             originMarker.icon = UIImage(named: "driver_icon")
         //   originMarker.icon = GMSMarker.markerImage(with: UIColor.red)
            
            
            
            originMarker.map = self.mapview
            
            
            self.destinationCoordinate = CLLocationCoordinate2DMake(Double(self.destinationlat)! , Double(self.destinationlng)!)
            
            destinationMarker = GMSMarker(position: self.destinationCoordinate)
            
            
            self.markerList.append(destinationMarker)
            
            
            
           // destinationMarker.icon = GMSMarker.markerImage(with: UIColor.green)
            
             destinationMarker.icon = UIImage(named: "pick_point")
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
            
           // self.timer1 = Timer.scheduledTimer(timeInterval: 0.010, target: self, selector: #selector(animatePolylinePath), userInfo: nil, repeats: true)
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
        
        
         if(GlobalVarible.Api == "rentaldriverinfomation"){
            
            rentaldriverinformationdata = data as! RentalDriverInformationModel
            
            
            if(rentaldriverinformationdata.status == 1){
                
                //  k = 1
                
                
              
                
                self.greenmarkerlocation.text = rentaldriverinformationdata.details!.pickupLocation
                
                
                //PickupLoc = (rentaldriverinformationdata.details!.pickupLocation)!
                
              //  currentStatus = (rentaldriverinformationdata.details?.bookingStatus)!
                
                //  UserDefaults.standard.setValue(currentStatus, forKey:"firebaseride_status")
                
                currentStatus = (rentaldriverinformationdata.details!.bookingStatus)!
                
                UserDefaults.standard.setValue(currentStatus, forKey:"firebaseride_status")

               
                
                GlobalVarible.RideId = (rentaldriverinformationdata.details!.rentalBookingId)!
                GlobalVarible.driverphonenumber = (rentaldriverinformationdata.details!.driverPhone)!
                drivername.text = rentaldriverinformationdata.details!.driverName
                
                carname.text = rentaldriverinformationdata.details!.carTypeName
                carmodelname.text = rentaldriverinformationdata.details!.carModelName
                
                carnumber.text = rentaldriverinformationdata.details!.carNumber
                
             //   let driverlat = Double((rentaldriverinformationdata.details!.driverLat)!)!
             //   let driverlng = Double((rentaldriverinformationdata.details!.driverLong)!)!
                
                
             //   DRIVERLAT  = String(format:"%f", driverlat)
              //  DRIVERLNG  = String(format:"%f", driverlng)
                
                driverid = (rentaldriverinformationdata.details?.driverId)!
                
                
                mapview.animate(toLocation: CLLocationCoordinate2D(latitude: Double(GlobalVarible.PickUpLat)!, longitude: Double(GlobalVarible.PickUpLng)!))
                mapview.animate(toZoom: 15)
                
                driverratingresult.text = rentaldriverinformationdata.details?.rating
                
                
                let driverratingvalue = rentaldriverinformationdata.details?.rating
                
                
                if driverratingvalue == ""{
                    print("hjjk")
                }else{
                    
                    // ratingview.rating = Float(driverratingvalue!)!
                    
                }
                
                let drivertypeimage = rentaldriverinformationdata.details!.driverImage
                
                print(drivertypeimage!)
                
                if(drivertypeimage == ""){
                    driverimageview.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    let newUrl = imageUrl + drivertypeimage!
                    
                    // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                    // print(url)
                    
                    let url1 = NSURL(string: newUrl)
                    driverimageview!.af_setImage(withURL:
                        url1! as URL,
                                                 placeholderImage: UIImage(named: "dress"),
                                                 filter: nil,
                                                 imageTransition: .crossDissolve(1.0))
                }
                
                currentStatus = (rentaldriverinformationdata.details?.bookingStatus)!
                
                
                if(currentStatus == "11"){
                    
                    markericonimage.isHidden = true
                    
                    
                    self.starttimer()
                    ridestatustoplabel.text = "Arriving Now"
                    
                }
                
                if(currentStatus == "12"){
                    
                    markericonimage.isHidden = false
                    
                      ridestatustoplabel.text = "Driver Arrived"
                    
                    cancelbtn.isHidden = true
                    cancelbuttonview.isHidden = true
                    
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
                    

                    
                 /*   k = 0
                    // self.Timer.invalidate()
                    ref.child("Drivers_A").removeAllObservers()
                    
                    cancelbutton.isHidden = true
                    cancelbuttonview.isHidden = true
                    x = 1
                    startlat = mydatapage.details!.pickupLat!
                    startlng = mydatapage.details!.pickupLong!
                    
                    ridestatustoplabel.text = "Ride Arrived"
                    destinationlat = mydatapage.details!.dropLat!
                    destinationlng = mydatapage.details!.dropLong!
                    
                    
                    let origin = startlat + "," + startlng
                    let destination = destinationlat + "," + destinationlng
                    
                    self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)*/
                    
                    //   self.createRoute()
                    
                    // showTextToast(currentmessage)
                    //   self.showalert1(currentmessage)
                    
                    
                }
                
                if(currentStatus == "13"){
                    
                    
                     markericonimage.isHidden = false
                    
                     ridestatustoplabel.text = "Riding Now"
                    
                    cancelbtn.isHidden = true
                    cancelbuttonview.isHidden = true
                    
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
                    

                  
                    
                }
                
                  if(currentStatus == "16"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: RentalRecieptViewController = storyboard.instantiateViewController(withIdentifier: "RentalRecieptViewController") as! RentalRecieptViewController
                nextController.currentrideid = (rentaldriverinformationdata.details?.rentalBookingId)!
                
                self.present(nextController, animated: true, completion: nil)
   
                
                  }
                    
                else{
                    //  k = 0
                    //  self.Timer.invalidate()
                    
                    
                    //  googlemapnavigationbtn.hidden = true
                    // googlebtnimageview.hidden = true
                    
                }
                
                
                
                
            }else{
                
                print("Hello")
                
                
            }

            
            
        }

    }
   

}
