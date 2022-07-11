//
//  Response.swift
//
//  Created by Rakesh kumar on 06/08/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PaypalResponse: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kResponseIntentKey: String = "intent"
	internal let kResponseCreateTimeKey: String = "create_time"
	internal let kResponseInternalIdentifierKey: String = "id"
	internal let kResponseStateKey: String = "state"


    // MARK: Properties
	public var intent: String?
	public var createTime: String?
	public var internalIdentifier: String?
	public var state: String?


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
		intent = json[kResponseIntentKey].string
		createTime = json[kResponseCreateTimeKey].string
		internalIdentifier = json[kResponseInternalIdentifierKey].string
		state = json[kResponseStateKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if intent != nil {
			dictionary.updateValue(intent! as AnyObject, forKey: kResponseIntentKey)
		}
		if createTime != nil {
			dictionary.updateValue(createTime! as AnyObject, forKey: kResponseCreateTimeKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier! as AnyObject, forKey: kResponseInternalIdentifierKey)
		}
		if state != nil {
			dictionary.updateValue(state! as AnyObject, forKey: kResponseStateKey)
		}

        return dictionary
    }

}
