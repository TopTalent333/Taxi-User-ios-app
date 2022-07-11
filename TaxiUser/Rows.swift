//
//  Rows.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Rows: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kRowsElementsKey: String = "elements"


    // MARK: Properties
	public var elements: [Elements]?


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
		elements = []
		if let items = json[kRowsElementsKey].array {
			for item in items {
				elements?.append(Elements(json: item))
			}
		} else {
			elements = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if (elements?.count)! > 0 {
			var temp: [AnyObject] = []
			for item in elements! {
				temp.append(item.dictionaryRepresentation() as AnyObject)
			}
			dictionary.updateValue(temp as AnyObject, forKey: kRowsElementsKey)
		}

        return dictionary
    }

}
