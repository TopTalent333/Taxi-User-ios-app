//
//  Client.swift
//
//  Created by Rakesh kumar on 06/08/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Client: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kClientPaypalSdkVersionKey: String = "paypal_sdk_version"
	internal let kClientPlatformKey: String = "platform"
	internal let kClientEnvironmentKey: String = "environment"
	internal let kClientProductNameKey: String = "product_name"


    // MARK: Properties
	public var paypalSdkVersion: String?
	public var platform: String?
	public var environment: String?
	public var productName: String?


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
		paypalSdkVersion = json[kClientPaypalSdkVersionKey].string
		platform = json[kClientPlatformKey].string
		environment = json[kClientEnvironmentKey].string
		productName = json[kClientProductNameKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if paypalSdkVersion != nil {
			dictionary.updateValue(paypalSdkVersion! as AnyObject, forKey: kClientPaypalSdkVersionKey)
		}
		if platform != nil {
			dictionary.updateValue(platform! as AnyObject, forKey: kClientPlatformKey)
		}
		if environment != nil {
			dictionary.updateValue(environment! as AnyObject, forKey: kClientEnvironmentKey)
		}
		if productName != nil {
			dictionary.updateValue(productName! as AnyObject, forKey: kClientProductNameKey)
		}

        return dictionary
    }

}
