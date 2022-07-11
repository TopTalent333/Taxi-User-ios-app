//
//  DistanceModel.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DistanceModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDistanceModelOriginAddressesKey: String = "origin_addresses"
	internal let kDistanceModelRowsKey: String = "rows"
	internal let kDistanceModelDestinationAddressesKey: String = "destination_addresses"
	internal let kDistanceModelStatusKey: String = "status"


    // MARK: Properties
	public var originAddresses: [String]?
	public var rows: [Rows]?
	public var destinationAddresses: [String]?
	public var status: String?


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
		originAddresses = []
		if let items = json[kDistanceModelOriginAddressesKey].array {
			for item in items {
				if let tempValue = item.string {
				originAddresses?.append(tempValue)
				}
			}
		} else {
			originAddresses = nil
		}
		rows = []
		if let items = json[kDistanceModelRowsKey].array {
			for item in items {
				rows?.append(Rows(json: item))
			}
		} else {
			rows = nil
		}
		destinationAddresses = []
		if let items = json[kDistanceModelDestinationAddressesKey].array {
			for item in items {
				if let tempValue = item.string {
				destinationAddresses?.append(tempValue)
				}
			}
		} else {
			destinationAddresses = nil
		}
		status = json[kDistanceModelStatusKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if (originAddresses?.count)! > 0 {
			dictionary.updateValue(originAddresses! as AnyObject, forKey: kDistanceModelOriginAddressesKey)
		}
		if (rows?.count)! > 0 {
			var temp: [AnyObject] = []
			for item in rows! {
				temp.append(item.dictionaryRepresentation() as AnyObject)
			}
			dictionary.updateValue(temp as AnyObject, forKey: kDistanceModelRowsKey)
		}
		if (destinationAddresses?.count)! > 0 {
			dictionary.updateValue(destinationAddresses! as AnyObject, forKey: kDistanceModelDestinationAddressesKey)
		}
		if status != nil {
			dictionary.updateValue(status! as AnyObject, forKey: kDistanceModelStatusKey)
		}

        return dictionary
    }

}
