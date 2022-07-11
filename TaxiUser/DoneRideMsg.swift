//
//  Msg.swift
//
//  Created by AppOrio on 25/05/17
//  Copyright (c) . All rights reserved.
//

import Foundation

import SwiftyJSON

public class DoneRideMsg: NSObject {


    internal let kMsgPaymentStatusKey: String = "payment_status"
    internal let kMsgPaymentOptionNameKey: String = "payment_option_name"
    internal let kMsgEndLocationKey: String = "end_location"
    internal let kMsgPaymentOptionIdKey: String = "payment_option_id"
    internal let kMsgDriverImageKey: String = "driver_image"
    internal let kMsgUserImageKey: String = "user_image"
    internal let kMsgRideDateKey: String = "ride_date"
    internal let kMsgDriverNameKey: String = "driver_name"
    internal let kMsgDistanceKey: String = "distance"
    internal let kMsgRideImageKey: String = "ride_image"
    internal let kMsgAmountKey: String = "amount"
    internal let kMsgWalletDeductedAmountKey: String = "wallet_deducted_amount"
    internal let kMsgRideTimeKey: String = "ride_time"
    internal let kMsgTotTimeKey: String = "tot_time"
    internal let kMsgPeakTimeChargeKey: String = "peak_time_charge"
    internal let kMsgTotalAmountKey: String = "total_amount"
    internal let kMsgUserPhoneKey: String = "user_phone"
    internal let kMsgCarTypeImageKey: String = "car_type_image"
    internal let kMsgCarTypeNameKey: String = "car_type_name"
    internal let kMsgNightTimeChargeKey: String = "night_time_charge"
    internal let kMsgDriverIdKey: String = "driver_id"
    internal let kMsgPaymentFaliedMessageKey: String = "payment_falied_message"
    internal let kMsgCouponsPriceKey: String = "coupons_price"
    internal let kMsgRideTimePriceKey: String = "ride_time_price"
    internal let kMsgUsernameKey: String = "username"
    internal let kMsgWaitingTimeKey: String = "waiting_time"
    internal let kMsgRideIdKey: String = "ride_id"
    internal let kMsgCarTypeIdKey: String = "car_type_id"
    internal let kMsgDoneRideIdKey: String = "done_ride_id"
    internal let kMsgCouponsCodeKey: String = "coupons_code"
    internal let kMsgUserIdKey: String = "user_id"
    internal let kMsgWaitingPriceKey: String = "waiting_price"
    internal let kMsgBeginLocationKey: String = "begin_location"
    internal let kMsgTotalPayableAmount: String = "total_payable_amount"
    
    
    // MARK: Properties
    public var paymentStatus: String?
    public var paymentOptionName: String?
    public var endLocation: String?
    public var paymentOptionId: String?
    public var driverImage: String?
    public var userImage: String?
    public var rideDate: String?
    public var driverName: String?
    public var distance: String?
    public var rideImage: String?
    public var amount: String?
    public var walletDeductedAmount: String?
    public var rideTime: String?
    public var totTime: String?
    public var peakTimeCharge: String?
    public var totalAmount: String?
    public var userPhone: String?
    public var carTypeImage: String?
    public var carTypeName: String?
    public var nightTimeCharge: String?
    public var driverId: String?
    public var paymentFaliedMessage: String?
    public var couponsPrice: String?
    public var rideTimePrice: String?
    public var username: String?
    public var waitingTime: String?
    public var rideId: String?
    public var carTypeId: String?
    public var doneRideId: String?
    public var couponsCode: String?
    public var userId: String?
    public var waitingPrice: String?
    public var beginLocation: String?
    public var totalpayableamount: String?
    
    
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
        paymentStatus = json[kMsgPaymentStatusKey].string
        paymentOptionName = json[kMsgPaymentOptionNameKey].string
        endLocation = json[kMsgEndLocationKey].string
        paymentOptionId = json[kMsgPaymentOptionIdKey].string
        driverImage = json[kMsgDriverImageKey].string
        userImage = json[kMsgUserImageKey].string
        rideDate = json[kMsgRideDateKey].string
        driverName = json[kMsgDriverNameKey].string
        distance = json[kMsgDistanceKey].string
        rideImage = json[kMsgRideImageKey].string
        amount = json[kMsgAmountKey].string
        walletDeductedAmount = json[kMsgWalletDeductedAmountKey].string
        rideTime = json[kMsgRideTimeKey].string
        totTime = json[kMsgTotTimeKey].string
        peakTimeCharge = json[kMsgPeakTimeChargeKey].string
        totalAmount = json[kMsgTotalAmountKey].string
        userPhone = json[kMsgUserPhoneKey].string
        carTypeImage = json[kMsgCarTypeImageKey].string
        carTypeName = json[kMsgCarTypeNameKey].string
        nightTimeCharge = json[kMsgNightTimeChargeKey].string
        driverId = json[kMsgDriverIdKey].string
        paymentFaliedMessage = json[kMsgPaymentFaliedMessageKey].string
        couponsPrice = json[kMsgCouponsPriceKey].string
        rideTimePrice = json[kMsgRideTimePriceKey].string
        username = json[kMsgUsernameKey].string
        waitingTime = json[kMsgWaitingTimeKey].string
        rideId = json[kMsgRideIdKey].string
        carTypeId = json[kMsgCarTypeIdKey].string
        doneRideId = json[kMsgDoneRideIdKey].string
        couponsCode = json[kMsgCouponsCodeKey].string
        userId = json[kMsgUserIdKey].string
        waitingPrice = json[kMsgWaitingPriceKey].string
        beginLocation = json[kMsgBeginLocationKey].string
        totalpayableamount = json[kMsgTotalPayableAmount].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if paymentStatus != nil {
            dictionary.updateValue(paymentStatus! as AnyObject, forKey: kMsgPaymentStatusKey)
        }
        if paymentOptionName != nil {
            dictionary.updateValue(paymentOptionName! as AnyObject, forKey: kMsgPaymentOptionNameKey)
        }
        if endLocation != nil {
            dictionary.updateValue(endLocation! as AnyObject, forKey: kMsgEndLocationKey)
        }
        if paymentOptionId != nil {
            dictionary.updateValue(paymentOptionId! as AnyObject, forKey: kMsgPaymentOptionIdKey)
        }
        if driverImage != nil {
            dictionary.updateValue(driverImage! as AnyObject, forKey: kMsgDriverImageKey)
        }
        if userImage != nil {
            dictionary.updateValue(userImage! as AnyObject, forKey: kMsgUserImageKey)
        }
        if rideDate != nil {
            dictionary.updateValue(rideDate! as AnyObject, forKey: kMsgRideDateKey)
        }
        if driverName != nil {
            dictionary.updateValue(driverName! as AnyObject, forKey: kMsgDriverNameKey)
        }
        if distance != nil {
            dictionary.updateValue(distance! as AnyObject, forKey: kMsgDistanceKey)
        }
        if rideImage != nil {
            dictionary.updateValue(rideImage! as AnyObject, forKey: kMsgRideImageKey)
        }
        if amount != nil {
            dictionary.updateValue(amount! as AnyObject, forKey: kMsgAmountKey)
        }
        if walletDeductedAmount != nil {
            dictionary.updateValue(walletDeductedAmount! as AnyObject, forKey: kMsgWalletDeductedAmountKey)
        }
        if rideTime != nil {
            dictionary.updateValue(rideTime! as AnyObject, forKey: kMsgRideTimeKey)
        }
        if totTime != nil {
            dictionary.updateValue(totTime! as AnyObject, forKey: kMsgTotTimeKey)
        }
        if peakTimeCharge != nil {
            dictionary.updateValue(peakTimeCharge! as AnyObject, forKey: kMsgPeakTimeChargeKey)
        }
        if totalAmount != nil {
            dictionary.updateValue(totalAmount! as AnyObject, forKey: kMsgTotalAmountKey)
        }
        if userPhone != nil {
            dictionary.updateValue(userPhone! as AnyObject, forKey: kMsgUserPhoneKey)
        }
        if carTypeImage != nil {
            dictionary.updateValue(carTypeImage! as AnyObject, forKey: kMsgCarTypeImageKey)
        }
        if carTypeName != nil {
            dictionary.updateValue(carTypeName! as AnyObject, forKey: kMsgCarTypeNameKey)
        }
        if nightTimeCharge != nil {
            dictionary.updateValue(nightTimeCharge! as AnyObject, forKey: kMsgNightTimeChargeKey)
        }
        if driverId != nil {
            dictionary.updateValue(driverId! as AnyObject, forKey: kMsgDriverIdKey)
        }
        if paymentFaliedMessage != nil {
            dictionary.updateValue(paymentFaliedMessage! as AnyObject, forKey: kMsgPaymentFaliedMessageKey)
        }
        if couponsPrice != nil {
            dictionary.updateValue(couponsPrice! as AnyObject, forKey: kMsgCouponsPriceKey)
        }
        if rideTimePrice != nil {
            dictionary.updateValue(rideTimePrice! as AnyObject, forKey: kMsgRideTimePriceKey)
        }
        if username != nil {
            dictionary.updateValue(username! as AnyObject, forKey: kMsgUsernameKey)
        }
        if waitingTime != nil {
            dictionary.updateValue(waitingTime! as AnyObject, forKey: kMsgWaitingTimeKey)
        }
        if rideId != nil {
            dictionary.updateValue(rideId! as AnyObject, forKey: kMsgRideIdKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId! as AnyObject, forKey: kMsgCarTypeIdKey)
        }
        if doneRideId != nil {
            dictionary.updateValue(doneRideId! as AnyObject, forKey: kMsgDoneRideIdKey)
        }
        if couponsCode != nil {
            dictionary.updateValue(couponsCode! as AnyObject, forKey: kMsgCouponsCodeKey)
        }
        if userId != nil {
            dictionary.updateValue(userId! as AnyObject, forKey: kMsgUserIdKey)
        }
        if waitingPrice != nil {
            dictionary.updateValue(waitingPrice! as AnyObject, forKey: kMsgWaitingPriceKey)
        }
        if beginLocation != nil {
            dictionary.updateValue(beginLocation! as AnyObject, forKey: kMsgBeginLocationKey)
        }
        if totalpayableamount != nil {
            dictionary.updateValue(totalpayableamount! as AnyObject, forKey: kMsgBeginLocationKey)
        }
        
        return dictionary
    }
    
}


    // MARK: Declaration for string constants to be used to decode and also serialize.
	/*internal let kMsgPaymentOptionNameKey: String = "payment_option_name"
	internal let kMsgEndLocationKey: String = "end_location"
	internal let kMsgPaymentOptionIdKey: String = "payment_option_id"
	internal let kMsgDriverImageKey: String = "driver_image"
	internal let kMsgUserImageKey: String = "user_image"

    internal let kMsgRideDateKey: String = "ride_date"
	internal let kMsgDriverNameKey: String = "driver_name"
	internal let kMsgDistanceKey: String = "distance"
	internal let kMsgAmountKey: String = "amount"
	internal let kMsgRideTimeKey: String = "ride_time"
	internal let kMsgTotTimeKey: String = "tot_time"
	internal let kMsgTotalAmountKey: String = "total_amount"
	internal let kMsgUserPhoneKey: String = "user_phone"
	internal let kMsgCarTypeNameKey: String = "car_type_name"
	internal let kMsgCarTypeImageKey: String = "car_type_image"
	internal let kMsgDriverIdKey: String = "driver_id"

    internal let kMsgRideIdKey: String = "ride_id"
	internal let kMsgWaitingTimeKey: String = "waiting_time"
	internal let kMsgRideTimePriceKey: String = "ride_time_price"
	internal let kMsgCouponsPriceKey: String = "coupons_price"
	internal let kMsgUsernameKey: String = "username"
	internal let kMsgCarTypeIdKey: String = "car_type_id"
	internal let kMsgDoneRideIdKey: String = "done_ride_id"
	internal let kMsgWaitingPriceKey: String = "waiting_price"
	internal let kMsgCouponsCodeKey: String = "coupons_code"
	internal let kMsgBeginLocationKey: String = "begin_location"
    internal let kMsgPeakTimeCharge: String = "peak_time_charge"
    internal let kMsgNighTimeCharges: String = "night_time_charge"


    // MARK: Properties
	public var paymentOptionName: String?
	public var endLocation: String?
	public var paymentOptionId: String?
	public var driverImage: String?
	public var userImage: String?
	public var rideDate: String?
	public var driverName: String?
	public var distance: String?
	public var amount: String?
	public var rideTime: String?
	public var totTime: String?
	public var totalAmount: String?
	public var userPhone: String?
	public var carTypeName: String?
	public var carTypeImage: String?
	public var driverId: String?
	public var rideId: String?
	public var waitingTime: String?
	public var rideTimePrice: String?
	public var couponsPrice: String?
	public var username: String?
	public var carTypeId: String?
	public var doneRideId: String?
	public var waitingPrice: String?
	public var couponsCode: String?
	public var beginLocation: String?
    public var peaktimecharges: String?
    public var nighttimecharges: String?


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
		paymentOptionName = json[kMsgPaymentOptionNameKey].string
		endLocation = json[kMsgEndLocationKey].string
		paymentOptionId = json[kMsgPaymentOptionIdKey].string
		driverImage = json[kMsgDriverImageKey].string
		userImage = json[kMsgUserImageKey].string
		rideDate = json[kMsgRideDateKey].string
		driverName = json[kMsgDriverNameKey].string
		distance = json[kMsgDistanceKey].string
		amount = json[kMsgAmountKey].string
		rideTime = json[kMsgRideTimeKey].string
		totTime = json[kMsgTotTimeKey].string
		totalAmount = json[kMsgTotalAmountKey].string
		userPhone = json[kMsgUserPhoneKey].string
		carTypeName = json[kMsgCarTypeNameKey].string
		carTypeImage = json[kMsgCarTypeImageKey].string
		driverId = json[kMsgDriverIdKey].string
		rideId = json[kMsgRideIdKey].string
		waitingTime = json[kMsgWaitingTimeKey].string
		rideTimePrice = json[kMsgRideTimePriceKey].string
		couponsPrice = json[kMsgCouponsPriceKey].string
		username = json[kMsgUsernameKey].string
		carTypeId = json[kMsgCarTypeIdKey].string
		doneRideId = json[kMsgDoneRideIdKey].string
		waitingPrice = json[kMsgWaitingPriceKey].string
		couponsCode = json[kMsgCouponsCodeKey].string
		beginLocation = json[kMsgBeginLocationKey].string
        peaktimecharges = json[kMsgPeakTimeCharge].string
        nighttimecharges = json[kMsgNighTimeCharges].string


    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if paymentOptionName != nil {
			dictionary.updateValue(paymentOptionName! as AnyObject, forKey: kMsgPaymentOptionNameKey)
		}
		if endLocation != nil {
			dictionary.updateValue(endLocation! as AnyObject, forKey: kMsgEndLocationKey)
		}
		if paymentOptionId != nil {
			dictionary.updateValue(paymentOptionId! as AnyObject, forKey: kMsgPaymentOptionIdKey)
		}
		if driverImage != nil {
			dictionary.updateValue(driverImage! as AnyObject, forKey: kMsgDriverImageKey)
		}
		if userImage != nil {
			dictionary.updateValue(userImage! as AnyObject, forKey: kMsgUserImageKey)
		}
		if rideDate != nil {
			dictionary.updateValue(rideDate! as AnyObject, forKey: kMsgRideDateKey)
		}
		if driverName != nil {
			dictionary.updateValue(driverName! as AnyObject, forKey: kMsgDriverNameKey)
		}
		if distance != nil {
			dictionary.updateValue(distance! as AnyObject, forKey: kMsgDistanceKey)
		}
		if amount != nil {
			dictionary.updateValue(amount! as AnyObject, forKey: kMsgAmountKey)
		}
		if rideTime != nil {
			dictionary.updateValue(rideTime! as AnyObject, forKey: kMsgRideTimeKey)
		}
		if totTime != nil {
			dictionary.updateValue(totTime! as AnyObject, forKey: kMsgTotTimeKey)
		}
		if totalAmount != nil {
			dictionary.updateValue(totalAmount! as AnyObject, forKey: kMsgTotalAmountKey)
		}
		if userPhone != nil {
			dictionary.updateValue(userPhone! as AnyObject, forKey: kMsgUserPhoneKey)
		}
		if carTypeName != nil {
			dictionary.updateValue(carTypeName! as AnyObject, forKey: kMsgCarTypeNameKey)
		}
		if carTypeImage != nil {
			dictionary.updateValue(carTypeImage! as AnyObject, forKey: kMsgCarTypeImageKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId! as AnyObject, forKey: kMsgDriverIdKey)
		}
		if rideId != nil {
			dictionary.updateValue(rideId! as AnyObject, forKey: kMsgRideIdKey)
		}
		if waitingTime != nil {
			dictionary.updateValue(waitingTime! as AnyObject, forKey: kMsgWaitingTimeKey)
		}
		if rideTimePrice != nil {
			dictionary.updateValue(rideTimePrice! as AnyObject, forKey: kMsgRideTimePriceKey)
		}
		if couponsPrice != nil {
			dictionary.updateValue(couponsPrice! as AnyObject, forKey: kMsgCouponsPriceKey)
		}
		if username != nil {
			dictionary.updateValue(username! as AnyObject, forKey: kMsgUsernameKey)
		}
		if carTypeId != nil {
			dictionary.updateValue(carTypeId! as AnyObject, forKey: kMsgCarTypeIdKey)
		}
		if doneRideId != nil {
			dictionary.updateValue(doneRideId! as AnyObject, forKey: kMsgDoneRideIdKey)
		}
		if waitingPrice != nil {
			dictionary.updateValue(waitingPrice! as AnyObject, forKey: kMsgWaitingPriceKey)
		}
		if couponsCode != nil {
			dictionary.updateValue(couponsCode! as AnyObject, forKey: kMsgCouponsCodeKey)
		}
		if beginLocation != nil {
			dictionary.updateValue(beginLocation! as AnyObject, forKey: kMsgBeginLocationKey)
		}
        if peaktimecharges != nil {
            dictionary.updateValue(peaktimecharges! as AnyObject, forKey: kMsgPeakTimeCharge)
        }
        if nighttimecharges != nil {
            dictionary.updateValue(nighttimecharges! as AnyObject, forKey: kMsgNighTimeCharges)
        }
        


        return dictionary
    }

}*/
