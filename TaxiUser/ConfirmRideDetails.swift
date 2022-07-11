//
//  Details.swift
//
//  Created by AppOrio on 24/05/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ConfirmRideDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsRideAdminStatusKey: String = "ride_admin_status"
	internal let kDetailsRideTimeKey: String = "ride_time"
	internal let kDetailsLaterDateKey: String = "later_date"
	internal let kDetailsLaterTimeKey: String = "later_time"
	internal let kDetailsPickupLocationKey: String = "pickup_location"
	internal let kDetailsDropLatKey: String = "drop_lat"
	internal let kDetailsDriverIdKey: String = "driver_id"
	internal let kDetailsPaymentOptionIdKey: String = "payment_option_id"
	internal let kDetailsRideIdKey: String = "ride_id"
	internal let kDetailsRideTypeKey: String = "ride_type"
	internal let kDetailsRideDateKey: String = "ride_date"
	internal let kDetailsLastTimeStampKey: String = "last_time_stamp"
	internal let kDetailsRideStatusKey: String = "ride_status"
	internal let kDetailsCardIdKey: String = "card_id"
	internal let kDetailsRideImageKey: String = "ride_image"
	internal let kDetailsDropLocationKey: String = "drop_location"
	internal let kDetailsReasonIdKey: String = "reason_id"
	internal let kDetailsUserIdKey: String = "user_id"
	internal let kDetailsCouponCodeKey: String = "coupon_code"
	internal let kDetailsCarTypeIdKey: String = "car_type_id"
	internal let kDetailsPickupLatKey: String = "pickup_lat"
	internal let kDetailsDropLongKey: String = "drop_long"
	internal let kDetailsPickupLongKey: String = "pickup_long"


    // MARK: Properties
	public var rideAdminStatus: String?
	public var rideTime: String?
	public var laterDate: String?
	public var laterTime: String?
	public var pickupLocation: String?
	public var dropLat: String?
	public var driverId: String?
	public var paymentOptionId: String?
	public var rideId: String?
	public var rideType: String?
	public var rideDate: String?
	public var lastTimeStamp: String?
	public var rideStatus: String?
	public var cardId: String?
	public var rideImage: String?
	public var dropLocation: String?
	public var reasonId: String?
	public var userId: String?
	public var couponCode: String?
	public var carTypeId: String?
	public var pickupLat: String?
	public var dropLong: String?
	public var pickupLong: String?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		rideAdminStatus = json[kDetailsRideAdminStatusKey].string
		rideTime = json[kDetailsRideTimeKey].string
		laterDate = json[kDetailsLaterDateKey].string
		laterTime = json[kDetailsLaterTimeKey].string
		pickupLocation = json[kDetailsPickupLocationKey].string
		dropLat = json[kDetailsDropLatKey].string
		driverId = json[kDetailsDriverIdKey].string
		paymentOptionId = json[kDetailsPaymentOptionIdKey].string
		rideId = json[kDetailsRideIdKey].string
		rideType = json[kDetailsRideTypeKey].string
		rideDate = json[kDetailsRideDateKey].string
		lastTimeStamp = json[kDetailsLastTimeStampKey].string
		rideStatus = json[kDetailsRideStatusKey].string
		cardId = json[kDetailsCardIdKey].string
		rideImage = json[kDetailsRideImageKey].string
		dropLocation = json[kDetailsDropLocationKey].string
		reasonId = json[kDetailsReasonIdKey].string
		userId = json[kDetailsUserIdKey].string
		couponCode = json[kDetailsCouponCodeKey].string
		carTypeId = json[kDetailsCarTypeIdKey].string
		pickupLat = json[kDetailsPickupLatKey].string
		dropLong = json[kDetailsDropLongKey].string
		pickupLong = json[kDetailsPickupLongKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if rideAdminStatus != nil {
			dictionary.updateValue(rideAdminStatus! as AnyObject, forKey: kDetailsRideAdminStatusKey)
		}
		if rideTime != nil {
			dictionary.updateValue(rideTime! as AnyObject, forKey: kDetailsRideTimeKey)
		}
		if laterDate != nil {
			dictionary.updateValue(laterDate! as AnyObject, forKey: kDetailsLaterDateKey)
		}
		if laterTime != nil {
			dictionary.updateValue(laterTime! as AnyObject, forKey: kDetailsLaterTimeKey)
		}
		if pickupLocation != nil {
			dictionary.updateValue(pickupLocation! as AnyObject, forKey: kDetailsPickupLocationKey)
		}
		if dropLat != nil {
			dictionary.updateValue(dropLat! as AnyObject, forKey: kDetailsDropLatKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId! as AnyObject, forKey: kDetailsDriverIdKey)
		}
		if paymentOptionId != nil {
			dictionary.updateValue(paymentOptionId! as AnyObject, forKey: kDetailsPaymentOptionIdKey)
		}
		if rideId != nil {
			dictionary.updateValue(rideId! as AnyObject, forKey: kDetailsRideIdKey)
		}
		if rideType != nil {
			dictionary.updateValue(rideType! as AnyObject, forKey: kDetailsRideTypeKey)
		}
		if rideDate != nil {
			dictionary.updateValue(rideDate! as AnyObject, forKey: kDetailsRideDateKey)
		}
		if lastTimeStamp != nil {
			dictionary.updateValue(lastTimeStamp! as AnyObject, forKey: kDetailsLastTimeStampKey)
		}
		if rideStatus != nil {
			dictionary.updateValue(rideStatus! as AnyObject, forKey: kDetailsRideStatusKey)
		}
		if cardId != nil {
			dictionary.updateValue(cardId! as AnyObject, forKey: kDetailsCardIdKey)
		}
		if rideImage != nil {
			dictionary.updateValue(rideImage! as AnyObject, forKey: kDetailsRideImageKey)
		}
		if dropLocation != nil {
			dictionary.updateValue(dropLocation! as AnyObject, forKey: kDetailsDropLocationKey)
		}
		if reasonId != nil {
			dictionary.updateValue(reasonId! as AnyObject, forKey: kDetailsReasonIdKey)
		}
		if userId != nil {
			dictionary.updateValue(userId! as AnyObject, forKey: kDetailsUserIdKey)
		}
		if couponCode != nil {
			dictionary.updateValue(couponCode! as AnyObject, forKey: kDetailsCouponCodeKey)
		}
		if carTypeId != nil {
			dictionary.updateValue(carTypeId! as AnyObject, forKey: kDetailsCarTypeIdKey)
		}
		if pickupLat != nil {
			dictionary.updateValue(pickupLat! as AnyObject, forKey: kDetailsPickupLatKey)
		}
		if dropLong != nil {
			dictionary.updateValue(dropLong! as AnyObject, forKey: kDetailsDropLongKey)
		}
		if pickupLong != nil {
			dictionary.updateValue(pickupLong! as AnyObject, forKey: kDetailsPickupLongKey)
		}

        return dictionary
    }

}
