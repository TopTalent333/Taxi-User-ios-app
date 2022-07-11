//
//  API_URL.swift
//  IZYCAB
//
//  Created by AppOrio on 23/02/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import Foundation


public class API_URL {
    
   // public static var basedomain = "http://apporio.co.uk/apporiotaxi/api/"
  // public static var imagedomain = "http://apporio.co.uk/apporiotaxi/"
    
    public static var basedomain = GlobalVarible.UserBaseUrl
    public static var imagedomain = GlobalVarible.UserImageBaseUrl

    
    //  public static var basedomain = "http://apporioinfolabs.com/apporiotaxi/api/"
    //   public static var imagedomain = "http://apporioinfolabs.com/apporiotaxi/"
    
    
    //public static var imagedomain1 = "http://apporio.net/Apporiotaxi_new/"
    
  //  public static var rentaldomain = "http://apporioinfolabs.com/Apporiotaxi_new/Rental/"
    
    public static var rentaldomain = "http://www.tyradmin.co.za/tagyourride/index.php?/Rental/"
    
    public static var sharelinkurl = "http://www.tyradmin.co.za/tagyourride/index.php?/"
    
    public static var viewcarswithtime =  rentaldomain + "Car_Type"
    // public static var viewcarswithtime = "http://apporio.net/Apporiotaxi_new/User/Car_Type"
    
    public static var viewrentaldata =  rentaldomain + "Rental_Package"
    
    public static var bookriderental = rentaldomain + "Book_Car"
    
    public static var rentalridesync = rentaldomain + "Ride_Sync"
    
    public static var rentalusercancel = rentaldomain + "Rental_User_Cancel_Ride"
    
    public static var rentalpayment = rentaldomain + "Payment"
    
    
    public static var customersupport = "http://www.tyradmin.co.za/tagyourride/index.php?/Common/Customer_support"

    
    public static var emergencycontacturl =  "http://www.tyradmin.co.za/tagyourride/index.php?/Common/SOS"
    
    public static var emergencycontactmessage = "http://www.tyradmin.co.za/tagyourride/index.php?/Common/SOS_Request"
    
    public static var rentalcancelreason =  "http://www.tyradmin.co.za/tagyourride/index.php?/Common/Cancel_Reasons"
    
    public static var viewrides = "http://www.tyradmin.co.za/tagyourride/index.php?/User/Ride_History"
    
    public static var RentalViewRideInfo = "http://www.tyradmin.co.za/tagyourride/index.php?/User/Ride_Details"
    
    public static var RideShareUrl = "http://www.tyradmin.co.za/tagyourride/index.php?/Common/Share_Ride_url"
    
    public static var NotificationUrl = "http://www.tyradmin.co.za/tagyourride/index.php?/Common/Notification"
    
    public static var EditProfile = "http://www.tyradmin.co.za/tagyourride/index.php?/Account/Edit_Profile"
    
    public static var Rentalridefareinfo = rentaldomain + "Done_Ride_Info"
    
    public static var Rentalratinginfo = rentaldomain + "Rating"
    
    public static var Rentaltrackridefareinfo = rentaldomain + "Ride_Info"
    

    
    
 
    
    public static var Register = basedomain + "register_user.php?user_name="
   // public static var register2 = basedomain + "register_driver_docs.php?driver_id="
    // public static var registerTesting = basedomain + "register_driver_testing.php?driver_email="
    public static var verifyphone = basedomain + "phone.php?user_phone="
    public static var getotp = basedomain + "otp_sent.php?user_phone="
    public static var createpassword = basedomain + "create_password.php?user_phone="
    public static var socialtoken = basedomain + "send_social_token.php?social_token="
    public static var socialregister = basedomain + "register_user_google.php?social_token="
    public static var getcoupon = basedomain + "coupon.php?coupon_code="
     public static var Viewcars = basedomain + "car_by_city.php?city_id="
    
    
   
   // public static var viewcarswithtime =  "http://apporioinfolabs.com/Apporiotaxi_new/Rental/Car_Type"
    
    public static var loginuser = basedomain + "login_user.php?user_email_phone="
    public static var forgetpassword = basedomain + "forgot_password_user.php?user_email="
    
    public static var changepassword = basedomain + "change_password_user.php?user_id="
  //  public static var EditProfile = basedomain + "edit_profile_user.php?language_id="
     public static var ViewCity = basedomain + "city.php?language_id="
    public static var viewdriverlocation = basedomain + "view_driver.php?car_type_id="
  //  public static var viewrides = basedomain + "view_rides_user.php?user_id="
     public static var Aboutus = basedomain + "about.php?language_id="
     public static var TermsAndConditions = basedomain + "tc.php?language_id="
     public static var callSupport = basedomain + "call_support.php?language_id="
    public static var ratecard = basedomain + "rate_card_city.php?city_id="
    public static var rideestimate = basedomain + "ride_estimate.php"
    
    public static var RideNow = basedomain + "ride_now.php"
    
    public static var RideLater = basedomain + "ride_later.php"
    public static var Cancelbyuser = basedomain + "ride_cancel.php?ride_id="
    public static var DeviceId = basedomain + "deviceid_user.php"
    public static var driverdetails = basedomain + "view_ride_info_user.php?ride_id="
    
    public static var viewdonerideinfo = basedomain + "view_done_ride_info.php?done_ride_id="
    
    
    public static var trackride = basedomain + "view_driver_location.php?ride_id="
   
    
    public static var userrating = basedomain + "rating_user.php?user_id="
    public static var confirmpayment = basedomain + "payment_saved.php"
    
    public static var logoutuser = basedomain + "logout_user.php?user_id="
    public static var cancelreasonuser = basedomain + "cancel_reason_customer.php?language_id="
    
    public static var sendinvoice = basedomain + "resend_invoice.php?ride_id="
    
    public static var savecard = basedomain + "save_card.php?user_id="
    
    public static var viewcard = basedomain + "view_card.php?user_id="
        
    public static var deletecard = basedomain + "delete_card.php?card_id="
    
    public static var paycard = basedomain + "pay_with_card.php?ride_id="
    
    public static var viewpaymentoption = basedomain + "view_payment_option.php?language_id="
    
    public static var customersync = basedomain + "customer_sync.php?ride_id="
    
    
    public static var usersyncwhenappterminate = basedomain + "user_sync.php?user_id="
    
    public static var customersyncend = basedomain + "customer_sync_end.php?ride_id="
    
     public static var cancelride60sec = basedomain + "cancel_ride_user.php?ride_id="
    
    public static var showwalletmoney = basedomain + "view_wallent_money.php?user_id="
    
    public static var addmoneyurl = basedomain + "add_money.php?amount="
    
    
    public static var changedropLoc = basedomain + "change_drop_location.php"
    

    
    
}
