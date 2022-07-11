//
//  PaymentStatusModel.swift
//
//  Created by Piyush Kumar on 10/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PaymentStatusModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPaymentStatusModelDetailsKey: String = "details"
	internal let kPaymentStatusModelResultKey: String = "result"
	internal let kPaymentStatusModelMsgKey: String = "msg"


    // MARK: Properties
	public var details: PaymentStatusDetails?
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
		details = PaymentStatusDetails(json: json[kPaymentStatusModelDetailsKey])
		result = json[kPaymentStatusModelResultKey].int
		msg = json[kPaymentStatusModelMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if details != nil {
			dictionary.updateValue(details!.dictionaryRepresentation() as AnyObject, forKey: kPaymentStatusModelDetailsKey)
		}
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kPaymentStatusModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg! as AnyObject, forKey: kPaymentStatusModelMsgKey)
		}

        return dictionary
    }

}
