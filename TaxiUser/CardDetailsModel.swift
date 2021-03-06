//
//  CardDetailsModel.swift
//
//  Created by AppOrio on 28/02/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CardDetailsModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kCardDetailsModelDetailsKey: String = "details"
    internal let kCardDetailsModelResultKey: String = "result"
    internal let kCardDetailsModelMsgKey: String = "msg"
    
    
    // MARK: Properties
    public var details: [CardDetails]?
    public var result: Int?
    public var msg: String?
    
    
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
        details = []
        if let items = json[kCardDetailsModelDetailsKey].array {
            for item in items {
                details?.append(CardDetails(json: item))
            }
        } else {
            details = nil
        }
        result = json[kCardDetailsModelResultKey].int
        msg = json[kCardDetailsModelMsgKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if (details?.count)! > 0 {
            var temp: [AnyObject] = []
            for item in details! {
                temp.append(item.dictionaryRepresentation() as AnyObject)
            }
            dictionary.updateValue(temp as AnyObject, forKey: kCardDetailsModelDetailsKey)
        }
        if result != nil {
            dictionary.updateValue(result! as AnyObject, forKey: kCardDetailsModelResultKey)
        }
        if msg != nil {
            dictionary.updateValue(msg! as AnyObject, forKey: kCardDetailsModelMsgKey)
        }
        
        return dictionary
    }
    
}



