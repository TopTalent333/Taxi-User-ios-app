//
//  AddMoneyModel.swift
//
//  Created by AppOrio on 15/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AddMoneyModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kAddMoneyModelPaymentIdKey: String = "payment_id"
	internal let kAddMoneyModelResultKey: String = "result"
	internal let kAddMoneyModelMsgKey: String = "msg"


    // MARK: Properties
	public var paymentId: String?
	public var result: Int?
	public var msg: String?


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
		paymentId = json[kAddMoneyModelPaymentIdKey].string
		result = json[kAddMoneyModelResultKey].int
		msg = json[kAddMoneyModelMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if paymentId != nil {
			dictionary.updateValue(paymentId! as AnyObject, forKey: kAddMoneyModelPaymentIdKey)
		}
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kAddMoneyModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg! as AnyObject, forKey: kAddMoneyModelMsgKey)
		}

        return dictionary
    }

}
