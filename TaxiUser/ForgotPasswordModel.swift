//
//  ForgotPasswordModel.swift
//
//  Created by Piyush Kumar on 10/25/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ForgotPasswordModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kForgotPasswordModelMessageKey: String = "message"
	internal let kForgotPasswordModelResultKey: String = "result"


    // MARK: Properties
	public var message: String?
	public var result: Int?


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
		message = json[kForgotPasswordModelMessageKey].string
		result = json[kForgotPasswordModelResultKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if message != nil {
			dictionary.updateValue(message! as AnyObject, forKey: kForgotPasswordModelMessageKey)
		}
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kForgotPasswordModelResultKey)
		}

        return dictionary
    }

}
