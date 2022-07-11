//
//  RentalRideFareModel.swift
//
//  Created by AppOrio on 05/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RentalRideFareModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kRentalRideFareModelStatusKey: String = "status"
	internal let kRentalRideFareModelMessageKey: String = "message"
	internal let kRentalRideFareModelDetailsKey: String = "details"


    // MARK: Properties
	public var status: Int?
	public var message: String?
	public var details: RentalRideFareDetails?


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
		status = json[kRentalRideFareModelStatusKey].int
		message = json[kRentalRideFareModelMessageKey].string
		details = RentalRideFareDetails(json: json[kRentalRideFareModelDetailsKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if status != nil {
			dictionary.updateValue(status! as AnyObject, forKey: kRentalRideFareModelStatusKey)
		}
		if message != nil {
			dictionary.updateValue(message! as AnyObject, forKey: kRentalRideFareModelMessageKey)
		}
		if details != nil {
			dictionary.updateValue(details!.dictionaryRepresentation() as AnyObject, forKey: kRentalRideFareModelDetailsKey)
		}

        return dictionary
    }

}
