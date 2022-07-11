//
//  CarsTImeModel.swift
//
//  Created by AppOrio on 24/01/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CarsTImeModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kBaseClassCurrencyUnicodeKey: String = "currency_unicode"
    internal let kBaseClassCurrencyKey: String = "currency"
    internal let kBaseClassCurrencyIsoCodeKey: String = "currency_iso_code"
    internal let kCarsTImeModelStatusKey: String = "status"
    internal let kCarsTImeModelMessageKey: String = "message"
    internal let kCarsTImeModelDetailsKey: String = "details"
  
    
    
    // MARK: Properties
    public var currencyUnicode: String?
    public var currency: String?
    public var currencyIsoCode: String?
    public var status: Int?
    public var message: String?
    public var details: [CarsTimeMsg]?
    
    
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
        currencyUnicode = json[kBaseClassCurrencyUnicodeKey].string
        currency = json[kBaseClassCurrencyKey].string
        currencyIsoCode = json[kBaseClassCurrencyIsoCodeKey].string
        status = json[kCarsTImeModelStatusKey].int
        message = json[kCarsTImeModelMessageKey].string
        details = []
        if let items = json[kCarsTImeModelDetailsKey].array {
            for item in items {
                details?.append(CarsTimeMsg(json: item))
            }
        } else {
            details = nil
        }
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if currencyUnicode != nil {
            dictionary.updateValue(currencyUnicode! as AnyObject, forKey: kBaseClassCurrencyUnicodeKey)
        }
        if currency != nil {
            dictionary.updateValue(currency! as AnyObject, forKey: kBaseClassCurrencyKey)
        }
        if currencyIsoCode != nil {
            dictionary.updateValue(currencyIsoCode! as AnyObject, forKey: kBaseClassCurrencyIsoCodeKey)
        }
        if status != nil {
            dictionary.updateValue(status! as AnyObject, forKey: kCarsTImeModelStatusKey)
        }
        if message != nil {
            dictionary.updateValue(message! as AnyObject, forKey: kCarsTImeModelMessageKey)
        }
        if (details?.count)! > 0 {
            var temp: [AnyObject] = []
            for item in details! {
                temp.append(item.dictionaryRepresentation() as AnyObject)
            }
            dictionary.updateValue(temp as AnyObject, forKey: kCarsTImeModelDetailsKey)
        }
        
        return dictionary
    }
    
}
