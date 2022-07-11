//
//  PayPalModel.swift
//
//  Created by Rakesh kumar on 06/08/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PayPalModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPayPalModelResponseKey: String = "response"
	internal let kPayPalModelResponseTypeKey: String = "response_type"
	internal let kPayPalModelClientKey: String = "client"


    // MARK: Properties
	public var response: PaypalResponse?
	public var responseType: String?
	public var client: Client?


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
		response = PaypalResponse(json: json[kPayPalModelResponseKey])
		responseType = json[kPayPalModelResponseTypeKey].string
		client = Client(json: json[kPayPalModelClientKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if response != nil {
			dictionary.updateValue(response!.dictionaryRepresentation() as AnyObject, forKey: kPayPalModelResponseKey)
		}
		if responseType != nil {
			dictionary.updateValue(responseType! as AnyObject, forKey: kPayPalModelResponseTypeKey)
		}
		if client != nil {
			dictionary.updateValue(client!.dictionaryRepresentation() as AnyObject, forKey: kPayPalModelClientKey)
		}

        return dictionary
    }

}
