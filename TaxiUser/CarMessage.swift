//
//  Msg.swift
//
//  Created by AppOrio on 19/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CarMessage: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.

    internal let kMsgCityIdKey: String = "city_id"
    internal let kMsgCarTypeNameFrenchKey: String = "car_type_name_french"
    internal let kMsgCarNameArabicKey: String = "car_name_arabic"
    internal let kMsgCarTypeImageKey: String = "car_type_image"
    internal let kMsgCarTypeIdKey: String = "car_type_id"
    internal let kMsgCarAdminStatusKey: String = "car_admin_status"
    internal let kMsgCarTypeNameKey: String = "car_type_name"
    
    
    // MARK: Properties
    public var cityId: String?
    public var carTypeNameFrench: String?
    public var carNameArabic: String?
    public var carTypeImage: String?
    public var carTypeId: String?
    public var carAdminStatus: String?
    public var carTypeName: String?
    
    
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
        cityId = json[kMsgCityIdKey].string
        carTypeNameFrench = json[kMsgCarTypeNameFrenchKey].string
        carNameArabic = json[kMsgCarNameArabicKey].string
        carTypeImage = json[kMsgCarTypeImageKey].string
        carTypeId = json[kMsgCarTypeIdKey].string
        carAdminStatus = json[kMsgCarAdminStatusKey].string
        carTypeName = json[kMsgCarTypeNameKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if cityId != nil {
            dictionary.updateValue(cityId! as AnyObject, forKey: kMsgCityIdKey)
        }
        if carTypeNameFrench != nil {
            dictionary.updateValue(carTypeNameFrench! as AnyObject, forKey: kMsgCarTypeNameFrenchKey)
        }
        if carNameArabic != nil {
            dictionary.updateValue(carNameArabic! as AnyObject, forKey: kMsgCarNameArabicKey)
        }
        if carTypeImage != nil {
            dictionary.updateValue(carTypeImage! as AnyObject, forKey: kMsgCarTypeImageKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId! as AnyObject, forKey: kMsgCarTypeIdKey)
        }
        if carAdminStatus != nil {
            dictionary.updateValue(carAdminStatus! as AnyObject, forKey: kMsgCarAdminStatusKey)
        }
        if carTypeName != nil {
            dictionary.updateValue(carTypeName! as AnyObject, forKey: kMsgCarTypeNameKey)
        }
        
        return dictionary
    }
    
}



    
    
