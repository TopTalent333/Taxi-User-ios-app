
//
//  DriverInfo.swift
//
//  Created by AppOrio on 21/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DriverInfo: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDriverInfoDetailsKey: String = "details"
	internal let kDriverInfoResultKey: String = "result"
	internal let kDriverInfoMsgKey: String = "msg"


    // MARK: Properties
	public var details: DriverInfoDetails?
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
		details = DriverInfoDetails(json: json[kDriverInfoDetailsKey])
		result = json[kDriverInfoResultKey].int
		msg = json[kDriverInfoMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if details != nil {
			dictionary.updateValue(details!.dictionaryRepresentation() as AnyObject, forKey: kDriverInfoDetailsKey)
		}
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kDriverInfoResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg! as AnyObject, forKey: kDriverInfoMsgKey)
		}

        return dictionary
    }

}
