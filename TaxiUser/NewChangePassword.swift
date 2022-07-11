//
//  ChangePassword.swift
//
//  Created by Piyush /kumar on 08/03/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class NewChangePassword: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kChangePasswordMessageKey: String = "message"
	internal let kChangePasswordResultKey: String = "result"


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
		message = json[kChangePasswordMessageKey].string
		result = json[kChangePasswordResultKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if message != nil {
			dictionary.updateValue(message! as AnyObject, forKey: kChangePasswordMessageKey)
		}
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kChangePasswordResultKey)
		}

        return dictionary
    }

}
