//
//  WalletModel.swift
//
//  Created by Piyush Kumar on 11/7/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class WalletModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kWalletModelResultKey: String = "result"
	internal let kWalletModelMsgKey: String = "msg"


    // MARK: Properties
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
		result = json[kWalletModelResultKey].int
		msg = json[kWalletModelMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if result != nil {
			dictionary.updateValue(result! as AnyObject, forKey: kWalletModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg! as AnyObject, forKey: kWalletModelMsgKey)
		}

        return dictionary
    }

}
