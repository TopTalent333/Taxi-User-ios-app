//
//  DoneRideModel.swift
//
//  Created by AppOrio on 25/05/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DoneRideModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDoneRideModelResultKey: String = "result"
	internal let kDoneRideModelMsgKey: String = "msg"


    // MARK: Properties
	public var result: Int?
	public var msg: DoneRideMsg?


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
		result = json[kDoneRideModelResultKey].int
		msg = DoneRideMsg(json: json[kDoneRideModelMsgKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kDoneRideModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!.dictionaryRepresentation() as AnyObject, forKey: kDoneRideModelMsgKey)
		}

        return dictionary
    }

}
