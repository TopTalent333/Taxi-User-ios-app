//
//  GeocodedWaypoints.swift
//
//  Created by AppOrio on 26/05/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class GeocodedWaypoints: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kGeocodedWaypointsGeocoderStatusKey: String = "geocoder_status"
	internal let kGeocodedWaypointsPlaceIdKey: String = "place_id"
	internal let kGeocodedWaypointsTypesKey: String = "types"


    // MARK: Properties
	public var geocoderStatus: String?
	public var placeId: String?
	public var types: [Types]?


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
		geocoderStatus = json[kGeocodedWaypointsGeocoderStatusKey].string
		placeId = json[kGeocodedWaypointsPlaceIdKey].string
		types = []
		if let items = json[kGeocodedWaypointsTypesKey].array {
			for item in items {
				types?.append(Types(json: item))
			}
		} else {
			types = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if geocoderStatus != nil {
			dictionary.updateValue(geocoderStatus!, forKey: kGeocodedWaypointsGeocoderStatusKey)
		}
		if placeId != nil {
			dictionary.updateValue(placeId!, forKey: kGeocodedWaypointsPlaceIdKey)
		}
		if types?.count > 0 {
			var temp: [AnyObject] = []
			for item in types! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kGeocodedWaypointsTypesKey)
		}

        return dictionary
    }

}
