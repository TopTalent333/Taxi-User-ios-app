//
//  Details.swift
//
//  Created by AppOrio on 23/08/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class EmergencyResponseDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsSosNumberKey: String = "sos_number"
	internal let kDetailsSosIdKey: String = "sos_id"
	internal let kDetailsSosStatusKey: String = "sos_status"
	internal let kDetailsSosNameKey: String = "sos_name"


    // MARK: Properties
	public var sosNumber: String?
	public var sosId: String?
	public var sosStatus: String?
	public var sosName: String?


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
		sosNumber = json[kDetailsSosNumberKey].string
		sosId = json[kDetailsSosIdKey].string
		sosStatus = json[kDetailsSosStatusKey].string
		sosName = json[kDetailsSosNameKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if sosNumber != nil {
			dictionary.updateValue(sosNumber! as AnyObject, forKey: kDetailsSosNumberKey)
		}
		if sosId != nil {
			dictionary.updateValue(sosId! as AnyObject, forKey: kDetailsSosIdKey)
		}
		if sosStatus != nil {
			dictionary.updateValue(sosStatus! as AnyObject, forKey: kDetailsSosStatusKey)
		}
		if sosName != nil {
			dictionary.updateValue(sosName! as AnyObject, forKey: kDetailsSosNameKey)
		}

        return dictionary
    }

}
