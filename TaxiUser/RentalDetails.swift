//
//  Details.swift
//
//  Created by AppOrio on 28/06/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RentalDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsRentalCategoryHoursKey: String = "rental_category_hours"
	internal let kDetailsRentalPakageCarKey: String = "Rental_Pakage_Car"
	internal let kDetailsRentalCategoryIdKey: String = "rental_category_id"
	internal let kDetailsRentalCategoryKilometerKey: String = "rental_category_kilometer"
	internal let kDetailsRentalCategoryKey: String = "rental_category"
    internal let kRentalPackageDescription: String = "rental_category_description"


    // MARK: Properties
	public var rentalCategoryHours: String?
	public var rentalPakageCar: [RentalPakageCar]?
	public var rentalCategoryId: String?
	public var rentalCategoryKilometer: String?
	public var rentalCategory: String?
    public var rentaldescription: String?

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
		rentalCategoryHours = json[kDetailsRentalCategoryHoursKey].string
		rentalPakageCar = []
		if let items = json[kDetailsRentalPakageCarKey].array {
			for item in items {
				rentalPakageCar?.append(RentalPakageCar(json: item))
			}
		} else {
			rentalPakageCar = nil
		}
		rentalCategoryId = json[kDetailsRentalCategoryIdKey].string
		rentalCategoryKilometer = json[kDetailsRentalCategoryKilometerKey].string
		rentalCategory = json[kDetailsRentalCategoryKey].string
        rentaldescription = json[kRentalPackageDescription].string
    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if rentalCategoryHours != nil {
			dictionary.updateValue(rentalCategoryHours! as AnyObject, forKey: kDetailsRentalCategoryHoursKey)
		}
		if (rentalPakageCar?.count)! > 0 {
			var temp: [AnyObject] = []
			for item in rentalPakageCar! {
				temp.append(item.dictionaryRepresentation() as AnyObject)
			}
			dictionary.updateValue(temp as AnyObject, forKey: kDetailsRentalPakageCarKey)
		}
		if rentalCategoryId != nil {
			dictionary.updateValue(rentalCategoryId! as AnyObject, forKey: kDetailsRentalCategoryIdKey)
		}
		if rentalCategoryKilometer != nil {
			dictionary.updateValue(rentalCategoryKilometer! as AnyObject, forKey: kDetailsRentalCategoryKilometerKey)
		}
		if rentalCategory != nil {
			dictionary.updateValue(rentalCategory! as AnyObject, forKey: kDetailsRentalCategoryKey)
		}
        if rentaldescription != nil {
            
            dictionary.updateValue(rentaldescription! as AnyObject, forKey: kRentalPackageDescription)
            
        }

        return dictionary
    }

}
