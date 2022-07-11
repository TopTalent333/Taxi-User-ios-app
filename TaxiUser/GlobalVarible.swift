//
//  GlobalVarible.swift
//  TaxiApp
//
//  Created by AppOrio on 01/09/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import Foundation
import GoogleMaps



struct GlobalVarible {
    
 

 static var presentlyopenScreeen :String = ""
static var PeachWalletVar = 0
static var PeachPaymentVar = 0
static var Api :String = ""
static var cartypeid :String = ""
static var Citytypeid :String = ""
static var PickUpLat :String = ""
static var PickUpLng :String = ""
static var cartypename :String = ""
static var cartypeimage :String = ""
static var ContactTelephone :String = ""
static var ContactEmail :String = "info@tagyourride.co.za"
static var selectcouponid :String = ""
static var DropLat = 0.0
static var DropLng = 0.0
static var Pickuptext :String = ""
static var Droplocationtext :String = ""
static var driverphonenumber :String = ""
static var SelectDate :String = ""
static var SelectTime :String = ""
static var CouponCode :String = ""
static var RideType :String = ""
static var OKBtnString :String = ""
//static var DriverCityId :String = ""
static var RideId :String = ""
static var RatingValue :String = "0"
static var Counter :String = ""
static var RideResult :Int = 100
static var CurrentRideStatus : String = ""
static var MatchStringforCancel: String = ""
static var TotalPayableamount: String = ""
static var DRIVERID: String = ""
static var CurrentDate: String = ""
static var StringMatchPayment: String = ""
static var CreateTime: String = ""
static var State : String = ""
static var PaypalId: String = ""
static var Intent: String = ""
static var UserDropLat = 0.0
static var UserDropLng = 0.0
static var UserDropLocationText: String = NSLocalizedString("No drop off point", comment: "")
static var matchintegernumber: Int = 0
static var usercityname: String = "Dummy City"
    static var usercityname1: String = ""
static var Cityid: String = ""
static var PlaceId: String = ""
static var  GooglePlaceSelectedText: String = ""
static var user_phone: String = ""
static var Otpmessage: String = "dsrthfhjbjhfjghj"
static var user_name: String = ""
static var user_password: String = ""
static var user_email: String = ""
static var social_sign_token: String = ""
static var socialtype: String = ""
static var cancelbtnvaluematch: String = ""
static var car_type_id: String = ""
static var firstcarname: String = ""
       static var cancelId: String = ""
    static var PaymentOptionId: String = "1"
    static var CardId: String = "0"
    static var paymentmethod: String = "Cash"
    
    
    static var currencysymbol: String = ""
    
    static var MatchCardSelect: Int = 0
    
    static var couponcodevalue: Int = 0
    
    static var k: Int = 0
    
     static var trackbackbtnvaluematch: Int = 0
    
    static var notificationvalue = 0
    
    static var afterallownotificationsetting = 0
    
     static var rideendstopupdatelocation = 0
    
    static var checklocationvalue: Int = 1
    
    static var languageid: Int = 1
    
    static var languagecode: String = ""
    
    static var Walletcheck: Int = 0
    
    static var addmoneyvalue: Int = 0
    
    static var checkdialogcancelbtn: Int = 0
    
    static var pemfilevaule: String = ""
    
    static var  googlemapkeys = "AIzaSyDdN4fqXPnnGWuCs2d5ncpDBnGgKfDo1fM"
    
    static var checkRideId :String = "0"
    
    static var checkridestatus: String = "0"
    
    static var movefromdemouser: String = ""
    
    static var locationdidactive: Int = 0
    
    static var changeddestination: Int = 0
    
      static var firebasepaymentscreen: Int = 0
    
     static var viewcontrollerself : UIViewController!

    
    static  var timerForGetDriverLocation1 = Timer()
    
      static  var timerForGetDriverLocation5 = Timer()
    
    
    
    static var emergencylatitude: String = ""
    static var emergencylongitude: String = ""
    
   // static var UserBaseUrl: String = "http://apporioinfolabs.com/apporiotaxi/api/"
    // static var UserImageBaseUrl: String = "http://apporioinfolabs.com/apporiotaxi/"
    // static var UserAccountBaseUrl: String = "http://apporioinfolabs.com/"
    
    static var UserBaseUrl: String =  "http://www.tyradmin.co.za/api/"
    static var UserImageBaseUrl: String =  "http://www.tyradmin.co.za/"
    static var UserAccountBaseUrl: String =  "http://www.tyradmin.co.za/"

    
    
   
    
    
    //  creatdd new variables 

}







/*func setuplocationMarker1(coordinate: CLLocationCoordinate2D) {
 
 
    let marker = GMSMarker(position: coordinate)
 
    marker.icon = UIImage(named: "Record-25 (1)") as UIImage?
 
    
    marker.map = trackrideviewcontroller.mapview
    
}

var GlobalSelcetvaluue = 1

var latroute: [Double] = [Double]()
var longroute: [Double] = [Double]()

 var routePolyline: GMSPolyline = GMSPolyline()



func redrawRoute(map: GMSMapView , lat: Double , lng: Double){
    
    print("1")
   
    
   // map.clear()
    
   /* if(GlobalSelcetvaluue == 1){
    
    latroute.removeAtIndex(0)
    longroute.removeAtIndex(0)
        GlobalSelcetvaluue = 2

    }*/
    
    
    latroute.append(lat)
    longroute.append(lng)
    
    
    print(longroute)
    print(latroute)
    
   // setuplocationMarker1(CLLocationCoordinate2D(latitude: GlobalVarible.UserDropLat, longitude: GlobalVarible.UserDropLng))
    
    let path = GMSMutablePath()
    for  i  in  0 ... latroute.count - 1 {
        path.addCoordinate(CLLocationCoordinate2D(latitude: latroute[i], longitude: longroute[i]))
    }
    print("******\(path.count())")
    routePolyline = GMSPolyline(path: path)
    routePolyline.strokeWidth = 5.0
    routePolyline.strokeColor = UIColor.grayColor()
    routePolyline.map = map
    
}*/


var driversCount = -100

// let BASE_URL = "http://apporio.co.uk/Apporiotaxi/Account/"

let BASE_URL =   GlobalVarible.UserAccountBaseUrl + "tagyourride/index.php?/Account/"

let BASE_URL1 =   GlobalVarible.UserAccountBaseUrl + "tagyourride/index.php?/Demo_Account/"

 // let BASE_URL = "http://apporioinfolabs.com/Apporiotaxi/Account/"

let DemoUserUrl = BASE_URL1 + "Signup"
let DemoUserUrl1 = "user_phone"
let DemoUserUrl2 = "user_email"
let DemoUserUrl3 = "user_name"
let DemoUserUrl4 = "unique_number"
let DemoUserUrl5 = "language_code"

let loginUrl = BASE_URL + "Login"
let loginUrl2 = "phone"
let loginUrl3 = "password"
let loginUrl4 = "language_code"

let signUpUrl = BASE_URL + "signup"
let signUpUrl2 = "first_name"
let signUpUrl3 = "last_name"
let signUpUrl4 = "phone"
let signUpUrl5 = "password"
let signUpUrl6 = "user_email"
let signUpUrl7 = "language_code"


let googleLoginUrl = BASE_URL + "google_login"
let googleLoginUrl2 = "google_id"

let facebookLoginUrl = BASE_URL + "facebook_login"
let facebookLoginUrl2 = "facebook_id"



let facebookSignupUrl = BASE_URL + "facebook_signup"
let facebookSignupUrl2 = "facebook_id"
let facebookSignupUrl3 = "facebook_mail"
let facebookSignupUrl4 = "facebook_image"
let facebookSignupUrl5 = "facebook_firstname"
let facebookSignupUrl6 = "facebook_lastname"
let facebookSignupUrl7 = "phone"
let facebookSignupUrl8 = "first_name"
let facebookSignupUrl9 = "last_name"
let facebookSignupUrl10 = "language_code"


let googleSignupUrl = BASE_URL + "google_signup"
let googleSignupUrl2 = "google_id"
let googleSignupUrl3 = "google_name"
let googleSignupUrl4 = "google_mail"
let googleSignupUrl5 = "google_image"
let googleSignupUrl6 = "phone"
let googleSignupUrl7 = "first_name"
let googleSignupUrl8 = "last_name"
let googleSignupUrl9 = "language_code"

var checkPhoneExistOrNotUrl = BASE_URL + "phone"
let checkPhoneExistOrNotUrl2 = "phone"

var changePassword =  BASE_URL +  "forget_password"
var changePassword2 = "email_id"


/*var EditProfile = BASE_URL + "Edit_Profile"
var EditProfile1 = "user_name"
var EditProfile2 = "user_email"
var EditProfile3 = "user_id"
var EditProfile4 = "user_image"*/


var LogoutUrl = BASE_URL + "Logout"
var LogoutUrl1 = "user_id"
var LogoutUrl2 = "unique_id"
var LogoutUrl3 = "language_code"




var Where = String()



