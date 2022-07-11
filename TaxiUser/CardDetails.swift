//
//  Details.swift
//
//  Created by AppOrio on 28/02/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CardDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsCardNumberKey: String = "card_number"
	internal let kDetailsCardIdKey: String = "card_id"
	internal let kDetailsCardTypeKey: String = "card_type"


    // MARK: Properties
	public var cardNumber: String?
	public var cardId: String?
	public var cardType: String?


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
		cardNumber = json[kDetailsCardNumberKey].string
		cardId = json[kDetailsCardIdKey].string
		cardType = json[kDetailsCardTypeKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if cardNumber != nil {
			dictionary.updateValue(cardNumber! as AnyObject, forKey: kDetailsCardNumberKey)
		}
		if cardId != nil {
			dictionary.updateValue(cardId! as AnyObject, forKey: kDetailsCardIdKey)
		}
		if cardType != nil {
			dictionary.updateValue(cardType! as AnyObject, forKey: kDetailsCardTypeKey)
		}

        return dictionary
    }

}
