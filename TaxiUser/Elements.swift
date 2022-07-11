//
//  Elements.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Elements: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kElementsStatusKey: String = "status"
	internal let kElementsDistanceKey: String = "distance"
	internal let kElementsDurationKey: String = "duration"


    // MARK: Properties
	public var status: String?
	public var distance: Distance?
	public var duration: Duration?


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
		status = json[kElementsStatusKey].string
		distance = Distance(json: json[kElementsDistanceKey])
		duration = Duration(json: json[kElementsDurationKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if status != nil {
			dictionary.updateValue(status! as AnyObject, forKey: kElementsStatusKey)
		}
		if distance != nil {
			dictionary.updateValue(distance!.dictionaryRepresentation() as AnyObject, forKey: kElementsDistanceKey)
		}
		if duration != nil {
			dictionary.updateValue(duration!.dictionaryRepresentation() as AnyObject, forKey: kElementsDurationKey)
		}

        return dictionary
    }

}
