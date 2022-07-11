//
//  TrackRideViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 24/05/17.
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
import GooglePlaces

var trackrideviewcontroller : TrackRideViewController!


class TrackRideViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,MainCategoryProtocol,GMSAutocompleteViewControllerDelegate {
    
    var part1: String = ""
    var part2: String = ""
    var part3: String = ""
    
    var changedata: DropChange!
    
    var ridesharedata: RideShareModel!
    
    
    //  var driverdata: DriverInfo!
    // var trackdata: DriveTrackModel!
    // var Doneridedata : DoneRideModel!
    
    //  var drivertrackdata : DriveTrackModel!
    
    @IBOutlet weak var drivernameview: UIView!
    
    @IBOutlet weak var cancelbuttonview: UIView!
    
    @IBOutlet weak var driverratingresult: UILabel!
    
    @IBOutlet weak var sosbtn: UIButton!
    
    
    let imageUrl = API_URL.imagedomain
    
    var timer = Timer()
    
    var totaldistance = 3000
    
    var markerList = [GMSMarker]()
    
    var driverid = ""
    
    var timerForGetDriverLocation = Timer()
    
    @IBOutlet weak var cancelbutton: UIButton!
    
    var radiansBearing : Double = 0.0
    
    
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    //   var routePolyline: GMSPolyline!
    
    var Currentrideid = ""
    
    var currentStatus = ""
    var currentmessage = ""
    var startlat = ""
    var startlng = ""
    var destinationlat = ""
    var destinationlng = ""
    
    var temparorylat = ""
    var temparorylong = ""
    
    var marker = GMSMarker()
    
    var temparoryvalue = 1
    
    var temparoryvalue1 = 1
    
    var markervalue = 1
    
    var originCoordinate: CLLocationCoordinate2D!
    
    var destinationCoordinate: CLLocationCoordinate2D!
    
    
    
    var polyline = GMSPolyline()
    var animationPolyline = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()
    var i: UInt = 0
    var timer1: Timer!
    
    var ref = FIRDatabase.database().reference()
    
    var ref1 = FIRDatabase.database().reference()
    
    var Lat = ""
    var Lng = ""
    
    
    var x = 0
    var k = 0
    
    var DRIVERLAT = " "
    var DRIVERLNG = " "
    var PickupLoc = ""
    var Drivercurrentaddress = ""
    var Driverdroplocation = ""
    
    var mydatapage: DriverInfo!
    let locationManager = CLLocationManager()
    
    private let googleMapsKey = "AIzaSyAwdw2gOgLTM_lAjEtVvIH87xHx3RTKEUQ"
    private let baseURLString = "https://maps.googleapis.com/maps/api/directions/json?"
    
    let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    
    var dropchange = 0
    
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
    
    @IBOutlet weak var redmarkerlocation: UILabel!
    
    @IBOutlet weak var mapview: GMSMapView!
    
    @IBOutlet weak var selectimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cancelbutton.layer.borderWidth = 1.0
        //   cancelbutton.layer.backgroundColor = (UIColor(red:147.0/255.0, green:165.0/255.0, blue:165.0/255.0, alpha:1.0) as! CGColor)
        
        //  cancelbutton.layer.cornerRadius = 4
        
        let newUrl = imageUrl + GlobalVarible.cartypeimage
        //    let url = "http://apporio.co.uk/apporiotaxi/\(GlobalVarible.cartypeimage)"
        
        let url1 = NSURL(string: newUrl)
        selectimage!.af_setImage(withURL:
            url1! as URL,
                                 placeholderImage: UIImage(named: "dress"),
                                 filter: nil,
                                 imageTransition: .crossDissolve(1.0))
        
        
        
        if(GlobalVarible.changeddestination == 1){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.DriverInformation(RIDEID: GlobalVarible.checkRideId)
            
            
            let Message: NSDictionary = ["changed_destination": "0","ride_id": GlobalVarible.checkRideId,"ride_status": GlobalVarible.checkridestatus,"done_ride_id": ""]
            
            self.ref.child("RideTable").child(GlobalVarible.checkRideId).setValue(Message)
            
            GlobalVarible.changeddestination = 0
            
        }
        
        
        drivernameview.layer.borderWidth = 1.0
        drivernameview.layer.cornerRadius = 4
        
        print(GlobalVarible.checkRideId)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showtrack),
            name: NSNotification.Name(rawValue: "trackride"),
            object: nil)
        
        
        
        trackrideviewcontroller = self
        dropchange = 0
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
        ApiManager.sharedInstance.DriverInformation(RIDEID: GlobalVarible.checkRideId)
        
        //  self.starttimer()
        
        GlobalVarible.StringMatchPayment = "hellohi"
        
        mapview.delegate = self
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func showtrack(notification: NSNotification){
        
        // ApiManager.sharedInstance.protocolmain_Catagory = self
        //  ApiManager.sharedInstance.DriverInformation(RIDEID: Currentrideid)
        
        
        if(GlobalVarible.changeddestination == 1){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.DriverInformation(RIDEID: GlobalVarible.checkRideId)
            
            
            let Message: NSDictionary = ["changed_destination": "0","ride_id": GlobalVarible.checkRideId,"ride_status": currentStatus,"done_ride_id": ""]
            
            self.ref.child("RideTable").child(GlobalVarible.checkRideId).setValue(Message)
            
            GlobalVarible.changeddestination = 0
            
            
        }
        
        
        
        if(GlobalVarible.checkridestatus == "3"){
            
            print(DRIVERLAT)
            print(DRIVERLNG)
            
            currentStatus = GlobalVarible.checkridestatus
            
            UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
            //  let origin = GlobalVarible.PickUpLat + "," + GlobalVarible.PickUpLng
            //   let destination = DRIVERLAT + "," + DRIVERLNG
            
            //   self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
            
            self.starttimer()
            ridestatustoplabel.text = "Arriving Now"
            
            sosbtn.isHidden = true
            
        }
        
        if(GlobalVarible.checkridestatus == "5"){
            
            k = 0
            // self.Timer.invalidate()
            currentStatus = GlobalVarible.checkridestatus
            
            mapview.clear()
            
            UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
            
            ref.child("Drivers_A").removeAllObservers()
            
            cancelbutton.isHidden = true
            cancelbuttonview.isHidden = true
            sosbtn.isHidden = true
            x = 1
            startlat = GlobalVarible.PickUpLat
            startlng = GlobalVarible.PickUpLng
            
            ridestatustoplabel.text = "Ride Arrived"
            destinationlat = String(GlobalVarible.UserDropLat)
            destinationlng = String(GlobalVarible.UserDropLng)
            
            
            let origin = startlat + "," + startlng
            let destination = destinationlat + "," + destinationlng
            
            self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
            
            //   self.createRoute()
            
            // showTextToast(currentmessage)
            //   self.showalert1(currentmessage)
            
            
        }
        
        if(GlobalVarible.checkridestatus == "6"){
            
            k = 0
            //  self.Timer.invalidate()
            
            
            mapview.clear()
            
            currentStatus = GlobalVarible.checkridestatus
            
            UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
            
            self.temparoryvalue = 1
            
            startlat = GlobalVarible.PickUpLat
            startlng = GlobalVarible.PickUpLng
            
            // GlobalVarible.UserDropLat =  Double(mydatapage.details!.dropLat!)!
            //GlobalVarible.UserDropLng = Double(mydatapage.details!.dropLong!)!
            
            
            destinationlat = String(GlobalVarible.UserDropLat)
            destinationlng =  String(GlobalVarible.UserDropLng)
            
            
            ridestatustoplabel.text = "Riding Now"
            
            Driverdroplocation = (mydatapage.details!.dropLocation)!
            
            //   self.showalert1(currentmessage)
            
            
            self.starttimer2()
            
            x = 1
            cancelbutton.isHidden = true
            cancelbuttonview.isHidden = true
            sosbtn.isHidden = false
            mapview.clear()
            
            
            
        }
        
        
        if(GlobalVarible.checkridestatus == "7"){
            
            
            UserDefaults.standard.setValue(GlobalVarible.checkridestatus, forKey:"firebaseride_status")
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.DriverInformation(RIDEID: GlobalVarible.checkRideId)
            
            /*  let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let nextController: RecieptViewController = storyboard.instantiateViewController(withIdentifier: "RecieptViewController") as! RecieptViewController
             
             nextController.currentrideid = mydatapage.details!.doneRideId!
             
             
             self.present(nextController, animated: true, completion: nil)*/
            
            
        }
            
            
        else{
            
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sosbtnclick(_ sender: Any) {
        
        
        
        let refreshAlert = UIAlertController(title:  NSLocalizedString("EMERGENCY FOR CALL", comment: ""), message: NSLocalizedString("Are You in problem ?", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: EmergencyViewController = storyboard.instantiateViewController(withIdentifier: "EmergencyViewController") as! EmergencyViewController
            self.present(next, animated: true, completion: nil)
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
            refreshAlert .dismiss(animated: true, completion: nil)
            
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        // self.timer1.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // self.timer1.invalidate()
        if self.dropchange == 1{
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.changeDrop(droplat: String(GlobalVarible.UserDropLat), droplong: String(GlobalVarible.UserDropLng), droplocation: GlobalVarible.UserDropLocationText, rideid: GlobalVarible.checkRideId)
        }
    }
    
    
    @IBAction func edit_drop_location_click(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        GlobalVarible.trackbackbtnvaluematch = 1
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        if let window = self.view.window{
            window.rootViewController = nextController
        }
        
        
        /*  self.dismiss(animated: true, completion: nil)
         
         if(currentStatus == "5"){
         
         self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
         
         }
         
         if(currentStatus == "6"){
         
         self.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
         
         }*/
        
        
        
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewController(withIdentifier: "ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        next.movefrom = ""
        self.present(next, animated: true, completion: nil)
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            
            locationManager.startUpdatingLocation()
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            if GlobalVarible.rideendstopupdatelocation == 0
            {
                
            }else{
                
                self.locationManager.stopUpdatingLocation()
            }
            
            print(location)
            
            reverseGeocodeCoordinate(coordinate: location.coordinate)
            
        }
        
        
    }
    
    
    
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                if self.currentStatus == "6" {
                    
                    self.Lat = String(coordinate.latitude)
                    self.Lng = String(coordinate.longitude)
                    
                    self.getBearing(toPoint: coordinate)
                    
                    self.starttimer2()
                    
                    
                }
                
            }
            
        }
        
    }
    
    
    func getBearing(toPoint point: CLLocationCoordinate2D) {
        
        
        func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
        func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
        
        let lat1 = degreesToRadians(degrees: Double(Lat)!)
        let lon1 = degreesToRadians(degrees: Double(Lng)!)
        
        print(Lat)
        
        let lat2 = degreesToRadians(degrees: point.latitude);
        let lon2 = degreesToRadians(degrees: point.longitude);
        
        print(point.latitude)
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        
        let radiansBearing1 = atan2(y, x);
        
        radiansBearing = (radiansToDegrees(radians: radiansBearing1))
        
        // return radiansToDegrees(radiansBearing)
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
            
            self.startlat = latitude
            self.startlng = longitude
            
            
            self.destinationlat = GlobalVarible.PickUpLat
            self.destinationlng = GlobalVarible.PickUpLng
            
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
            
            let totaldistancevalue = Double(self.totaldistance/30)
            
            print(totaldistancevalue)
            
            if distanceInMeter > 0.5{
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
    
    
    
    
    func starttimer2(){
        
        
        ref.child("Drivers_A").child(driverid).observe(.value, with: { (snapshot) in
            
            print(self.driverid)
            
            
            
            let value = snapshot.value as? NSDictionary
            
            
            
            let latitude1 =   value?["driver_current_latitude"]  as! String
            
            
            
            let longitude1 = value?["driver_current_longitude"] as! String
            
            GlobalVarible.emergencylatitude = value?["driver_current_latitude"]  as! String
            
            GlobalVarible.emergencylongitude =  value?["driver_current_longitude"] as! String
            
            
            
            let bearningdegree = value?["bearingfactor"] as! String
            
            print(latitude1)
            print(bearningdegree)
            
            
            
            let latitude = latitude1
            
            let longitude = longitude1
            
            // let bearningdegree = String(bearningdegree)
            
            self.startlat = latitude1
            self.startlng = longitude1
            
            self.destinationlat = String(GlobalVarible.UserDropLat)
            self.destinationlng = String(GlobalVarible.UserDropLng)
            
            
            let origin = self.startlat + "," + self.startlng
            let destination = self.destinationlat + "," + self.destinationlng
            
            
            
            
            if self.temparoryvalue1 == 1 {
                //  self.createRoute()
                self.mapview.clear()
                self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
                self.temparorylat = latitude
                self.temparorylong = longitude
                self.temparoryvalue1 = 0
                
            }
            
            
            let coordinateTo = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
            
            // let coordinateFrom = CLLocation(latitude: 28.4198, longitude: 77.0382)
            
            let pickuplat = Double(self.temparorylat)
            let pickuplng = Double(self.temparorylong)
            
            let coordinateFrom = CLLocation(latitude: pickuplat! , longitude: pickuplng!)
            
            let distanceInMeter =  coordinateFrom.distance(from: coordinateTo)
            
            print(distanceInMeter)
            
            
            let totaldistancevalue = Double(self.totaldistance/30)
            
            print(totaldistancevalue)
            
            if distanceInMeter > 0.5{
                self.mapview.clear()
                self.temparorylat = latitude
                self.temparorylong = longitude
                self.temparoryvalue1 = 1
                self.markervalue = 1
                //self.createRoute()
                self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
            }
            
            //  self.cresterootviatrack(lat: latitude, long: longitude,BearningFactor: bearningdegree)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    func cresterootviatrack(lat: String , long: String ,BearningFactor : String){
        
        // func cresterootviatrack(lat: String , long: String){
        
        
        let coordinates = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        
        if markervalue == 1 {
            marker = GMSMarker(position: coordinates)
            marker.icon = UIImage(named: "driver_icon")
            
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
                
                
                print(directionsURLString)
                
                //  directionsURLString = directionsURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                
                let directionsURL = NSURL(string: directionsURLString)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    let directionsData = NSData(contentsOf: directionsURL! as URL)
                    
                    
                    
                    do {
                        
                        let dictonary:Dictionary<String, Any> = try JSONSerialization.jsonObject(with: directionsData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        
                        let status = dictonary["status"] as! String
                        
                        let json = JSON(data: directionsData! as Data)
                        
                        
                        
                        if status == "OK" {
                            
                            self.totaldistance = json["routes"][0]["legs"][0]["distance"]["value"].int!
                            
                            print(self.totaldistance)
                            
                        }
                        
                        
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
        
        
        
        
        
        
        markerList.removeAll()
        
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
            
            if(currentStatus == "3"){
                
                originMarker.icon = UIImage(named: "driver_icon")
                //  originMarker.icon = GMSMarker.markerImage(with: UIColor.red)
            }else if(currentStatus == "6"){
                
                originMarker.icon = UIImage(named: "driver_icon")
                
                
            }else{
                originMarker.icon = UIImage(named: "pickup")
            }
            originMarker.map = self.mapview
            
            
            self.destinationCoordinate = CLLocationCoordinate2DMake(Double(self.destinationlat)! , Double(self.destinationlng)!)
            
            destinationMarker = GMSMarker(position: self.destinationCoordinate)
            
            
            self.markerList.append(destinationMarker)
            
            
            if(currentStatus == "3"){
                destinationMarker.icon = UIImage(named: "pick_point")
                // destinationMarker.icon = GMSMarker.markerImage(with: UIColor.green)
                
            }else{
                destinationMarker.icon = UIImage(named: "droppoint")
            }
            
            destinationMarker.map = self.mapview
            
            
            for marker in markerList {
                bounds = bounds.includingCoordinate(marker.position)
            }
            
            self.path = GMSPath.init(fromEncodedPath: points as! String)!
            
            self.polyline.path = path
            //  self.polyline.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.polyline.strokeColor = UIColor.black
            self.polyline.strokeWidth = 3.0
            self.polyline.map = self.mapview
            let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsetsMake(50, 60, 50, 60))
            mapview.animate(with: update)
            
            if(currentStatus == "5"){
                
                //  self.timer1 = Timer.scheduledTimer(timeInterval: 0.080, target: self, selector: #selector(animatePolylinePath), userInfo: nil, repeats: true)
                
            }
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
    
    
    
    
    @IBAction func drivercallbtn(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string : "tel://\(GlobalVarible.driverphonenumber)")! as URL)
        
    }
    
    @IBAction func sharedetailsbtn(_ sender: Any) {
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RideShareDetails(RideId: GlobalVarible.RideId)
        
        
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
        
        if(GlobalVarible.Api == "DriverInformation"){
            
            mydatapage = data as! DriverInfo
            
            if(mydatapage.result == 1){
                
                //  k = 1
                
                
                
                self.redmarkerlocation.text = mydatapage.details!.dropLocation
                
                self.greenmarkerlocation.text = mydatapage.details!.pickupLocation
                
                
                PickupLoc = (mydatapage.details!.pickupLocation)!
                
                currentStatus = (mydatapage.details?.rideStatus)!
                
                UserDefaults.standard.setValue(currentStatus, forKey:"firebaseride_status")
                
                print(currentStatus)
                
                Driverdroplocation = mydatapage.details!.driverLocation!
                
                GlobalVarible.RideId = (mydatapage.details!.rideId)!
                GlobalVarible.driverphonenumber = (mydatapage.details!.driverPhone)!
                drivername.text = mydatapage.details!.driverName
                
                carname.text = mydatapage.details!.carTypeName
                carmodelname.text = mydatapage.details!.carModelName
                
                carnumber.text = mydatapage.details!.carNumber
                
                let driverlat = Double((mydatapage.details!.driverLat)!)!
                let driverlng = Double((mydatapage.details!.driverLong)!)!
                
                
                DRIVERLAT  = String(format:"%f", driverlat)
                DRIVERLNG  = String(format:"%f", driverlng)
                
                driverid = (mydatapage.details?.driverId)!
                
                
                mapview.animate(toLocation: CLLocationCoordinate2D(latitude: Double(GlobalVarible.PickUpLat)!, longitude: Double(GlobalVarible.PickUpLng)!))
                mapview.animate(toZoom: 15)
                
                driverratingresult.text = mydatapage.details?.driverRating
                
                
                let driverratingvalue = mydatapage.details?.driverRating
                
                
                if driverratingvalue == ""{
                    print("hjjk")
                }else{
                    
                    // ratingview.rating = Float(driverratingvalue!)!
                    
                }
                
                let drivertypeimage = mydatapage.details!.driverImage
                
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
                
                
                if(currentStatus == "3"){
                    
                    print(DRIVERLAT)
                    print(DRIVERLNG)
                    
                    //  let origin = GlobalVarible.PickUpLat + "," + GlobalVarible.PickUpLng
                    //   let destination = DRIVERLAT + "," + DRIVERLNG
                    
                    //   self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
                    
                    self.starttimer()
                    ridestatustoplabel.text = "Arriving Now"
                    
                    sosbtn.isHidden = true
                    
                }
                
                if(currentStatus == "5"){
                    
                    k = 0
                    // self.Timer.invalidate()
                    ref.child("Drivers_A").removeAllObservers()
                    
                    cancelbutton.isHidden = true
                    cancelbuttonview.isHidden = true
                    sosbtn.isHidden = true
                    x = 1
                    startlat = mydatapage.details!.pickupLat!
                    startlng = mydatapage.details!.pickupLong!
                    
                    GlobalVarible.PickUpLat = mydatapage.details!.pickupLat!
                    
                    GlobalVarible.PickUpLng = mydatapage.details!.pickupLong!
                    
                    GlobalVarible.UserDropLat = Double(mydatapage.details!.dropLat!)!
                    
                    GlobalVarible.UserDropLng = Double((mydatapage.details?.dropLong!)!)!
                    
                    ridestatustoplabel.text = "Ride Arrived"
                    destinationlat = mydatapage.details!.dropLat!
                    destinationlng = mydatapage.details!.dropLong!
                    
                    
                    let origin = startlat + "," + startlng
                    let destination = destinationlat + "," + destinationlng
                    
                    self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
                    
                    //   self.createRoute()
                    
                    // showTextToast(currentmessage)
                    //   self.showalert1(currentmessage)
                    
                    
                }
                
                if(currentStatus == "6"){
                    
                    k = 0
                    //  self.Timer.invalidate()
                    ref.child("Drivers_A").removeAllObservers()
                    
                    self.temparoryvalue = 1
                    
                    startlat = mydatapage.details!.pickupLat!
                    startlng = mydatapage.details!.pickupLong!
                    
                    GlobalVarible.PickUpLat = mydatapage.details!.pickupLat!
                    
                    GlobalVarible.PickUpLng = mydatapage.details!.pickupLong!
                    
                    GlobalVarible.UserDropLat =  Double(mydatapage.details!.dropLat!)!
                    GlobalVarible.UserDropLng = Double(mydatapage.details!.dropLong!)!
                    
                    
                    destinationlat = String(GlobalVarible.UserDropLat)
                    destinationlng =  String(GlobalVarible.UserDropLng)
                    
                    
                    ridestatustoplabel.text = "Riding Now"
                    
                    Driverdroplocation = (mydatapage.details!.dropLocation)!
                    
                    //   self.showalert1(currentmessage)
                    
                    
                    self.starttimer2()
                    
                    x = 1
                    cancelbutton.isHidden = true
                    cancelbuttonview.isHidden = true
                    sosbtn.isHidden = false
                    mapview.clear()
                    
                    
                    
                }
                
                
                if(currentStatus == "7"){
                    
                    
                    self.ref.child("Drivers_A").removeAllObservers()
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: NewPaymentViewController = storyboard.instantiateViewController(withIdentifier: "NewPaymentViewController") as! NewPaymentViewController
                    
                    nextController.currentrideid = mydatapage.details!.doneRideId!
                    
                    
                    self.present(nextController, animated: true, completion: nil)
                    
                    
                }
                    
                    
                else{
                    
                    
                }
                
                
                
                
            }else{
                
                print("Hello")
                
                
            }
            
        }
        
        if(GlobalVarible.Api == "Dropchange"){
            
            self.changedata = data as! DropChange
            
            if self.changedata.result == 1{
                
                /* self.redmarkerlocation.text = self.changedata.details?.dropLocation!
                 
                 destinationlat = (self.changedata.details?.dropLat!)!
                 destinationlng = (self.changedata.details?.dropLong!)!
                 
                 
                 let origin = startlat + "," + startlng
                 let destination = destinationlat + "," + destinationlng
                 
                 self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)*/
                
                self.dropchange = 0
                
                self.redmarkerlocation.text = changedata.details!.dropLocation
                
                self.greenmarkerlocation.text = changedata.details!.pickupLocation
                
                
                PickupLoc = (changedata.details!.pickupLocation)!
                
                
                Driverdroplocation = changedata.details!.driverLocation!
                
                GlobalVarible.RideId = (changedata.details!.rideId)!
                GlobalVarible.driverphonenumber = (changedata.details!.driverPhone)!
                drivername.text = changedata.details!.driverName
                
                carname.text = changedata.details!.carTypeName
                carmodelname.text = changedata.details!.carModelName
                
                carnumber.text = changedata.details!.carNumber
                
                let driverlat = Double((changedata.details!.driverLat)!)!
                let driverlng = Double((changedata.details!.driverLong)!)!
                
                
                DRIVERLAT  = String(format:"%f", driverlat)
                DRIVERLNG  = String(format:"%f", driverlng)
                
                driverid = (changedata.details?.driverId)!
                
                GlobalVarible.PickUpLat = changedata.details!.pickupLat!
                GlobalVarible.PickUpLng = (changedata.details?.pickupLong!)!
                
                GlobalVarible.UserDropLat = Double((changedata.details?.dropLat!)!)!
                
                GlobalVarible.UserDropLng = Double((changedata.details?.dropLong!)!)!
                
                
                mapview.animate(toLocation: CLLocationCoordinate2D(latitude: Double(GlobalVarible.PickUpLat)!, longitude: Double(GlobalVarible.PickUpLng)!))
                mapview.animate(toZoom: 15)
                
                driverratingresult.text = changedata.details?.driverRating
                
                
                let driverratingvalue = changedata.details?.driverRating
                
                
                if driverratingvalue == ""{
                    print("hjjk")
                }else{
                    
                    // ratingview.rating = Float(driverratingvalue!)!
                    
                }
                
                let drivertypeimage = changedata.details!.driverImage
                
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
                
                
                if(currentStatus == "3"){
                    
                    print(DRIVERLAT)
                    print(DRIVERLNG)
                    
                    //  let origin = GlobalVarible.PickUpLat + "," + GlobalVarible.PickUpLng
                    //   let destination = DRIVERLAT + "," + DRIVERLNG
                    
                    //   self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
                    
                    self.starttimer()
                    ridestatustoplabel.text = "Arriving Now"
                    sosbtn.isHidden = true
                    
                }
                
                if(currentStatus == "5"){
                    
                    k = 0
                    // self.Timer.invalidate()
                    ref.child("Drivers_A").removeAllObservers()
                    
                    cancelbutton.isHidden = true
                    cancelbuttonview.isHidden = true
                    sosbtn.isHidden = true
                    x = 1
                    startlat = changedata.details!.pickupLat!
                    startlng = changedata.details!.pickupLong!
                    
                    ridestatustoplabel.text = "Ride Arrived"
                    destinationlat = changedata.details!.dropLat!
                    destinationlng = changedata.details!.dropLong!
                    
                    
                    let origin = startlat + "," + startlng
                    let destination = destinationlat + "," + destinationlng
                    
                    self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
                    
                    //   self.createRoute()
                    
                    // showTextToast(currentmessage)
                    //   self.showalert1(currentmessage)
                    
                    
                }
                
                if(currentStatus == "6"){
                    
                    k = 0
                    //  self.Timer.invalidate()
                    ref.child("Drivers_A").removeAllObservers()
                    
                    self.temparoryvalue = 1
                    
                    startlat = changedata.details!.pickupLat!
                    startlng = changedata.details!.pickupLong!
                    
                    GlobalVarible.UserDropLat =  Double(changedata.details!.dropLat!)!
                    GlobalVarible.UserDropLng = Double(changedata.details!.dropLong!)!
                    
                    
                    destinationlat = String(GlobalVarible.UserDropLat)
                    destinationlng =  String(GlobalVarible.UserDropLng)
                    
                    
                    ridestatustoplabel.text = "Riding Now"
                    
                    Driverdroplocation = (changedata.details!.dropLocation)!
                    
                    //   self.showalert1(currentmessage)
                    let origin = startlat + "," + startlng
                    let destination = destinationlat + "," + destinationlng
                    
                    self.getDirections(origin: origin, destination: destination, waypoints: nil, travelMode: nil)
                    
                    self.starttimer2()
                    
                    x = 1
                    cancelbutton.isHidden = true
                    cancelbuttonview.isHidden = true
                    sosbtn.isHidden = false
                    mapview.clear()
                    
                    
                    
                }
                else{
                    
                    
                }
                
                
                
                
            }
        }
        
        if(GlobalVarible.Api == "rentalshareurl"){
            self.ridesharedata = data as! RideShareModel
            
            if self.ridesharedata.result == "1" {
                
                /* let shareText = "http://www.apporiotaxi.com/Apporiotaxi/Ride/Track/" + ridesharedata.details!
                 let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                 present(activityViewController, animated: true, completion: nil)*/
                
                
                let shareText = API_URL.sharelinkurl + "Ride/Track/" + ridesharedata.details!
                
                print(shareText)
                
                let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
                activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                
                self.present(activityViewController, animated: true) {
                    print("option menu presented")
                }
                
                
                
                
                
            }else{
                
                self.showalert(message: ridesharedata.message!)
            }
            
            
            
            
        }
        
        
        
    }
    
    
    
}


extension TrackRideViewController {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print(place)
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        print("Place attributions: \(place.coordinate.latitude)")
        print("Place attributions: \(place.coordinate.longitude)")
        //  manualloactioncheck = "manual"
        
        // GlobalVarible.Pickuptext = place.formattedAddress!
        // GlobalVarible.UserDropLocationText = place.formattedAddress!
        GlobalVarible.UserDropLocationText = place.name
        GlobalVarible.UserDropLat = place.coordinate.latitude
        GlobalVarible.UserDropLng = place.coordinate.longitude
        
        self.dropchange = 1
        
        
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

