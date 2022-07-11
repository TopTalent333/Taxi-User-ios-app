//
//  CityName.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CityName: NSObject {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kCityNameResultKey: String = "result"
    internal let kCityNameMsgKey: String = "msg"
    
    
    // MARK: Properties
    public var result: Int?
    public var msg: [CityMessage]?
    
    
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
        result = json[kCityNameResultKey].int
        msg = []
        if let items = json[kCityNameMsgKey].array {
            for item in items {
                msg?.append(CityMessage(json: item))
            }
        } else {
            msg = nil
        }
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if result != nil {
            dictionary.updateValue(result! as AnyObject, forKey: kCityNameResultKey)
        }
        if (msg?.count)! > 0 {
            var temp: [AnyObject] = []
            for item in msg! {
                temp.append(item.dictionaryRepresentation() as AnyObject)
            }
            dictionary.updateValue(temp as AnyObject, forKey: kCityNameMsgKey)
        }
        
        return dictionary
    }
    
}
