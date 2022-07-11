//
//  Details.swift
//
//  Created by Piyush Kumar on 10/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PaymentStatusDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsCodeKey: String = "code"
	internal let kDetailsDescriptionValueKey: String = "description"


    // MARK: Properties
	public var code: String?
	public var descriptionValue: String?


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
		code = json[kDetailsCodeKey].string
		descriptionValue = json[kDetailsDescriptionValueKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
			dictionary.updateValue(code! as AnyObject, forKey: kDetailsCodeKey)
		}
		if descriptionValue != nil {
			dictionary.updateValue(descriptionValue! as AnyObject, forKey: kDetailsDescriptionValueKey)
		}

        return dictionary
    }

}
