//
//  SignupLoginResponse.swift
//
//  Created by AppOrio on 05/04/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class SignupLoginResponse: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSignupLoginResponseValueKey: String = "value"
	internal let kSignupLoginResponseMessageKey: String = "message"
	internal let kSignupLoginResponseResultKey: String = "result"
	internal let kSignupLoginResponseDetailsKey: String = "details"


    // MARK: Properties
	public var value: Int?
	public var message: String?
	public var result: Int?
	public var details: SignupLoginResponseDetails?


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
		value = json[kSignupLoginResponseValueKey].int
		message = json[kSignupLoginResponseMessageKey].string
		result = json[kSignupLoginResponseResultKey].int
		details = SignupLoginResponseDetails(json: json[kSignupLoginResponseDetailsKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if value != nil {
			dictionary.updateValue(value! as AnyObject, forKey: kSignupLoginResponseValueKey)
		}
		if message != nil {
			dictionary.updateValue(message! as AnyObject, forKey: kSignupLoginResponseMessageKey)
		}
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kSignupLoginResponseResultKey)
		}
		if details != nil {
			dictionary.updateValue(details!.dictionaryRepresentation() as AnyObject, forKey: kSignupLoginResponseDetailsKey)
		}

        return dictionary
    }

}
