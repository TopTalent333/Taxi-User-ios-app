//
//  Details.swift
//
//  Created by AppOrio on 03/11/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Details: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsPaymentStatusKey: String = "payment_status"
	internal let kDetailsPaymentPlatformKey: String = "payment_platform"
	internal let kDetailsPaymentIdKey: String = "payment_id"
	internal let kDetailsPaymentDateTimeKey: String = "payment_date_time"
	internal let kDetailsPaymentMethodKey: String = "payment_method"
	internal let kDetailsUserIdKey: String = "user_id"
	internal let kDetailsPaymentAmountKey: String = "payment_amount"
	internal let kDetailsOrderIdKey: String = "order_id"


    // MARK: Properties
	public var paymentStatus: String?
	public var paymentPlatform: String?
	public var paymentId: String?
	public var paymentDateTime: String?
	public var paymentMethod: String?
	public var userId: String?
	public var paymentAmount: String?
	public var orderId: String?


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
		paymentStatus = json[kDetailsPaymentStatusKey].string
		paymentPlatform = json[kDetailsPaymentPlatformKey].string
		paymentId = json[kDetailsPaymentIdKey].string
		paymentDateTime = json[kDetailsPaymentDateTimeKey].string
		paymentMethod = json[kDetailsPaymentMethodKey].string
		userId = json[kDetailsUserIdKey].string
		paymentAmount = json[kDetailsPaymentAmountKey].string
		orderId = json[kDetailsOrderIdKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if paymentStatus != nil {
			dictionary.updateValue(paymentStatus! as AnyObject, forKey: kDetailsPaymentStatusKey)
		}
		if paymentPlatform != nil {
			dictionary.updateValue(paymentPlatform! as AnyObject, forKey: kDetailsPaymentPlatformKey)
		}
		if paymentId != nil {
			dictionary.updateValue(paymentId! as AnyObject, forKey: kDetailsPaymentIdKey)
		}
		if paymentDateTime != nil {
			dictionary.updateValue(paymentDateTime! as AnyObject, forKey: kDetailsPaymentDateTimeKey)
		}
		if paymentMethod != nil {
			dictionary.updateValue(paymentMethod! as AnyObject, forKey: kDetailsPaymentMethodKey)
		}
		if userId != nil {
			dictionary.updateValue(userId! as AnyObject, forKey: kDetailsUserIdKey)
		}
		if paymentAmount != nil {
			dictionary.updateValue(paymentAmount! as AnyObject, forKey: kDetailsPaymentAmountKey)
		}
		if orderId != nil {
			dictionary.updateValue(orderId! as AnyObject, forKey: kDetailsOrderIdKey)
		}

        return dictionary
    }

}
