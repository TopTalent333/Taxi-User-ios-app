//
//  Msg.swift
//
//  Created by AppOrio on 01/03/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ViewPaymentMsg: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMsgPaymentOptionNameArabicKey: String = "payment_option_name_arabic"
	internal let kMsgPaymentOptionNameFrenchKey: String = "payment_option_name_french"
	internal let kMsgPaymentOptionNameKey: String = "payment_option_name"
	internal let kMsgStatusKey: String = "status"
	internal let kMsgPaymentOptionIdKey: String = "payment_option_id"


    // MARK: Properties
	public var paymentOptionNameArabic: String?
	public var paymentOptionNameFrench: String?
	public var paymentOptionName: String?
	public var status: String?
	public var paymentOptionId: String?


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
		paymentOptionNameArabic = json[kMsgPaymentOptionNameArabicKey].string
		paymentOptionNameFrench = json[kMsgPaymentOptionNameFrenchKey].string
		paymentOptionName = json[kMsgPaymentOptionNameKey].string
		status = json[kMsgStatusKey].string
		paymentOptionId = json[kMsgPaymentOptionIdKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if paymentOptionNameArabic != nil {
			dictionary.updateValue(paymentOptionNameArabic! as AnyObject, forKey: kMsgPaymentOptionNameArabicKey)
		}
		if paymentOptionNameFrench != nil {
			dictionary.updateValue(paymentOptionNameFrench! as AnyObject, forKey: kMsgPaymentOptionNameFrenchKey)
		}
		if paymentOptionName != nil {
			dictionary.updateValue(paymentOptionName! as AnyObject, forKey: kMsgPaymentOptionNameKey)
		}
		if status != nil {
			dictionary.updateValue(status! as AnyObject, forKey: kMsgStatusKey)
		}
		if paymentOptionId != nil {
			dictionary.updateValue(paymentOptionId! as AnyObject, forKey: kMsgPaymentOptionIdKey)
		}

        return dictionary
    }

}
