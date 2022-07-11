//
//  Msg.swift
//
//  Created by AppOrio on 24/01/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CarsTimeMsg: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kDetailsRideModeKey: String = "ride_mode"
    internal let kDetailsBaseFareKey: String = "base_fare"
    internal let kDetailsDistanceKey: String = "distance"
    internal let kDetailsCarTypeNameKey: String = "car_type_name"
    internal let kDetailsCityIdKey: String = "city_id"
    internal let kDetailsCarTypeImageKey: String = "car_type_image"
    internal let kDetailsCarTypeIdKey: String = "car_type_id"
    internal let kDetailsCurrencyIsoCodeKey: String = "currency_iso_code"
    internal let kDetailsCurrencyUnicodeKey: String = "currency_unicode"
    
    
    // MARK: Properties
    public var rideMode: String?
    public var baseFare: String?
    public var distance: String?
    public var carTypeName: String?
    public var cityId: String?
    public var carTypeImage: String?
    public var carTypeId: String?
    public var currencyIsoCode: String?
    public var currencyUnicode: String?
    
    
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
        rideMode = json[kDetailsRideModeKey].string
        baseFare = json[kDetailsBaseFareKey].string
        distance = json[kDetailsDistanceKey].string
        carTypeName = json[kDetailsCarTypeNameKey].string
        cityId = json[kDetailsCityIdKey].string
        carTypeImage = json[kDetailsCarTypeImageKey].string
        carTypeId = json[kDetailsCarTypeIdKey].string
        currencyIsoCode = json[kDetailsCurrencyIsoCodeKey].string
        currencyUnicode = json[kDetailsCurrencyUnicodeKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if rideMode != nil {
            dictionary.updateValue(rideMode! as AnyObject, forKey: kDetailsRideModeKey)
        }
        if baseFare != nil {
            dictionary.updateValue(baseFare! as AnyObject, forKey: kDetailsBaseFareKey)
        }
        if distance != nil {
            dictionary.updateValue(distance! as AnyObject, forKey: kDetailsDistanceKey)
        }
        if carTypeName != nil {
            dictionary.updateValue(carTypeName! as AnyObject, forKey: kDetailsCarTypeNameKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId! as AnyObject, forKey: kDetailsCityIdKey)
        }
        if carTypeImage != nil {
            dictionary.updateValue(carTypeImage! as AnyObject, forKey: kDetailsCarTypeImageKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId! as AnyObject, forKey: kDetailsCarTypeIdKey)
        }
        if currencyUnicode != nil {
            dictionary.updateValue(currencyUnicode! as AnyObject, forKey: kDetailsCurrencyUnicodeKey)
        }
        if currencyIsoCode != nil {
            dictionary.updateValue(currencyIsoCode! as AnyObject, forKey: kDetailsCurrencyIsoCodeKey)
        }
        
        return dictionary
    }
    
}
