//
//  Msg.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CityMessage: NSObject {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.

    internal let kMsgCityNameFrenchKey: String = "city_name_french"
    internal let kMsgCityNameKey: String = "city_name"
    internal let kMsgCityIdKey: String = "city_id"
    internal let kMsgCityNameArabicKey: String = "city_name_arabic"
    internal let kMsgCityAdminStatusKey: String = "city_admin_status"
    
    
    // MARK: Properties
    public var cityNameFrench: String?
    public var cityName: String?
    public var cityId: String?
    public var cityNameArabic: String?
    public var cityAdminStatus: String?
    
    
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
        cityNameFrench = json[kMsgCityNameFrenchKey].string
        cityName = json[kMsgCityNameKey].string
        cityId = json[kMsgCityIdKey].string
        cityNameArabic = json[kMsgCityNameArabicKey].string
        cityAdminStatus = json[kMsgCityAdminStatusKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if cityNameFrench != nil {
            dictionary.updateValue(cityNameFrench! as AnyObject, forKey: kMsgCityNameFrenchKey)
        }
        if cityName != nil {
            dictionary.updateValue(cityName! as AnyObject, forKey: kMsgCityNameKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId! as AnyObject, forKey: kMsgCityIdKey)
        }
        if cityNameArabic != nil {
            dictionary.updateValue(cityNameArabic! as AnyObject, forKey: kMsgCityNameArabicKey)
        }
        if cityAdminStatus != nil {
            dictionary.updateValue(cityAdminStatus! as AnyObject, forKey: kMsgCityAdminStatusKey)
        }
        
        return dictionary
    }
    
}






  
