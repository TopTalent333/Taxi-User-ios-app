//
//  Duration.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Duration: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDurationTextKey: String = "text"
	internal let kDurationValueKey: String = "value"


    // MARK: Properties
	public var text: String?
	public var value: Int?


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
		text = json[kDurationTextKey].string
		value = json[kDurationValueKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if text != nil {
			dictionary.updateValue(text! as AnyObject, forKey: kDurationTextKey)
		}
		if value != nil {
			dictionary.updateValue(value! as AnyObject, forKey: kDurationValueKey)
		}

        return dictionary
    }

}
