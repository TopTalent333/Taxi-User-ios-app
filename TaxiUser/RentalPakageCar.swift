//
//  RentalPakageCar.swift
//
//  Created by AppOrio on 28/06/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RentalPakageCar: NSObject {


    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kRentalPakageCarPriceKey: String = "price"
    internal let kRentalPakageCarPricePerHrsKey: String = "price_per_hrs"
    internal let kRentalPakageCarRentalCategoryIdKey: String = "rental_category_id"
    internal let kRentalPakageCarCarTypeNameKey: String = "car_type_name"
    internal let kRentalPakageCarCarTypeImageKey: String = "car_type_image"
    internal let kRentalPakageCarRentcardIdKey: String = "rentcard_id"
    internal let kRentalPakageCarPricePerKmsKey: String = "price_per_kms"
    internal let kRentalPakageCarRideModeKey: String = "ride_mode"
    internal let kRentalPakageCarCityIdKey: String = "city_id"
    internal let kRentalPakageCarCarAdminStatusKey: String = "car_admin_status"
    internal let kRentalPakageCarCarNameArabicKey: String = "car_name_arabic"
    internal let kRentalPakageCarCarTypeNameFrenchKey: String = "car_type_name_french"
    internal let kRentalPakageCarCarTypeIdKey: String = "car_type_id"
    internal let kRentalPakageCarRentcardAdminStatusKey: String = "rentcard_admin_status"
    
    
    
    // MARK: Properties
    public var price: String?
    public var pricePerHrs: String?
    public var rentalCategoryId: String?
    public var carTypeName: String?
    public var carTypeImage: String?
    public var rentcardId: String?
    public var pricePerKms: String?
    public var rideMode: String?
    public var cityId: String?
    public var carAdminStatus: String?
    public var carNameArabic: String?
    public var carTypeNameFrench: String?
    public var carTypeId: String?
    public var rentcardAdminStatus: String?
  
    
    
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
        price = json[kRentalPakageCarPriceKey].string
        pricePerHrs = json[kRentalPakageCarPricePerHrsKey].string
        rentalCategoryId = json[kRentalPakageCarRentalCategoryIdKey].string
        carTypeName = json[kRentalPakageCarCarTypeNameKey].string
        carTypeImage = json[kRentalPakageCarCarTypeImageKey].string
        rentcardId = json[kRentalPakageCarRentcardIdKey].string
        pricePerKms = json[kRentalPakageCarPricePerKmsKey].string
        rideMode = json[kRentalPakageCarRideModeKey].string
        cityId = json[kRentalPakageCarCityIdKey].string
        carAdminStatus = json[kRentalPakageCarCarAdminStatusKey].string
        carNameArabic = json[kRentalPakageCarCarNameArabicKey].string
        carTypeNameFrench = json[kRentalPakageCarCarTypeNameFrenchKey].string
        carTypeId = json[kRentalPakageCarCarTypeIdKey].string
        rentcardAdminStatus = json[kRentalPakageCarRentcardAdminStatusKey].string
      
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if price != nil {
            dictionary.updateValue(price! as AnyObject, forKey: kRentalPakageCarPriceKey)
        }
        if pricePerHrs != nil {
            dictionary.updateValue(pricePerHrs! as AnyObject, forKey: kRentalPakageCarPricePerHrsKey)
        }
        if rentalCategoryId != nil {
            dictionary.updateValue(rentalCategoryId! as AnyObject, forKey: kRentalPakageCarRentalCategoryIdKey)
        }
        if carTypeName != nil {
            dictionary.updateValue(carTypeName! as AnyObject, forKey: kRentalPakageCarCarTypeNameKey)
        }
        if carTypeImage != nil {
            dictionary.updateValue(carTypeImage!  as AnyObject, forKey: kRentalPakageCarCarTypeImageKey)
        }
        if rentcardId != nil {
            dictionary.updateValue(rentcardId! as AnyObject, forKey: kRentalPakageCarRentcardIdKey)
        }
        if pricePerKms != nil {
            dictionary.updateValue(pricePerKms! as AnyObject, forKey: kRentalPakageCarPricePerKmsKey)
        }
        if rideMode != nil {
            dictionary.updateValue(rideMode! as AnyObject, forKey: kRentalPakageCarRideModeKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId! as AnyObject, forKey: kRentalPakageCarCityIdKey)
        }
        if carAdminStatus != nil {
            dictionary.updateValue(carAdminStatus! as AnyObject, forKey: kRentalPakageCarCarAdminStatusKey)
        }
        if carNameArabic != nil {
            dictionary.updateValue(carNameArabic! as AnyObject, forKey: kRentalPakageCarCarNameArabicKey)
        }
        if carTypeNameFrench != nil {
            dictionary.updateValue(carTypeNameFrench! as AnyObject, forKey: kRentalPakageCarCarTypeNameFrenchKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId! as AnyObject, forKey: kRentalPakageCarCarTypeIdKey)
        }
        if rentcardAdminStatus != nil {
            dictionary.updateValue(rentcardAdminStatus! as AnyObject, forKey: kRentalPakageCarRentcardAdminStatusKey)
        }
        
        
        return dictionary
    }
    
}

    // MARK: Declaration for string constants to be used to decode and also serialize.
	/*internal let kRentalPakageCarPriceKey: String = "price"
	internal let kRentalPakageCarRideModeKey: String = "ride_mode"
	internal let kRentalPakageCarRentalCategoryIdKey: String = "rental_category_id"
	internal let kRentalPakageCarCityIdKey: String = "city_id"
	internal let kRentalPakageCarCarTypeImageKey: String = "car_type_image"
	internal let kRentalPakageCarCarAdminStatusKey: String = "car_admin_status"
	internal let kRentalPakageCarCarTypeIdKey: String = "car_type_id"
	internal let kRentalPakageCarCarTypeNameKey: String = "car_type_name"
	internal let kRentalPakageCarCarNameArabicKey: String = "car_name_arabic"
	internal let kRentalPakageCarCarTypeNameFrenchKey: String = "car_type_name_french"
	internal let kRentalPakageCarRentcardIdKey: String = "rentcard_id"
	internal let kRentalPakageCarRentcardAdminStatusKey: String = "rentcard_admin_status"


    // MARK: Properties
	public var price: String?
	public var rideMode: String?
	public var rentalCategoryId: String?
	public var cityId: String?
	public var carTypeImage: String?
	public var carAdminStatus: String?
	public var carTypeId: String?
	public var carTypeName: String?
	public var carNameArabic: String?
	public var carTypeNameFrench: String?
	public var rentcardId: String?
	public var rentcardAdminStatus: String?


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
		price = json[kRentalPakageCarPriceKey].string
		rideMode = json[kRentalPakageCarRideModeKey].string
		rentalCategoryId = json[kRentalPakageCarRentalCategoryIdKey].string
		cityId = json[kRentalPakageCarCityIdKey].string
		carTypeImage = json[kRentalPakageCarCarTypeImageKey].string
		carAdminStatus = json[kRentalPakageCarCarAdminStatusKey].string
		carTypeId = json[kRentalPakageCarCarTypeIdKey].string
		carTypeName = json[kRentalPakageCarCarTypeNameKey].string
		carNameArabic = json[kRentalPakageCarCarNameArabicKey].string
		carTypeNameFrench = json[kRentalPakageCarCarTypeNameFrenchKey].string
		rentcardId = json[kRentalPakageCarRentcardIdKey].string
		rentcardAdminStatus = json[kRentalPakageCarRentcardAdminStatusKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if price != nil {
			dictionary.updateValue(price! as AnyObject, forKey: kRentalPakageCarPriceKey)
		}
		if rideMode != nil {
			dictionary.updateValue(rideMode! as AnyObject, forKey: kRentalPakageCarRideModeKey)
		}
		if rentalCategoryId != nil {
			dictionary.updateValue(rentalCategoryId! as AnyObject, forKey: kRentalPakageCarRentalCategoryIdKey)
		}
		if cityId != nil {
			dictionary.updateValue(cityId! as AnyObject, forKey: kRentalPakageCarCityIdKey)
		}
		if carTypeImage != nil {
			dictionary.updateValue(carTypeImage! as AnyObject, forKey: kRentalPakageCarCarTypeImageKey)
		}
		if carAdminStatus != nil {
			dictionary.updateValue(carAdminStatus! as AnyObject, forKey: kRentalPakageCarCarAdminStatusKey)
		}
		if carTypeId != nil {
			dictionary.updateValue(carTypeId! as AnyObject, forKey: kRentalPakageCarCarTypeIdKey)
		}
		if carTypeName != nil {
			dictionary.updateValue(carTypeName! as AnyObject, forKey: kRentalPakageCarCarTypeNameKey)
		}
		if carNameArabic != nil {
			dictionary.updateValue(carNameArabic! as AnyObject, forKey: kRentalPakageCarCarNameArabicKey)
		}
		if carTypeNameFrench != nil {
			dictionary.updateValue(carTypeNameFrench! as AnyObject, forKey: kRentalPakageCarCarTypeNameFrenchKey)
		}
		if rentcardId != nil {
			dictionary.updateValue(rentcardId! as AnyObject, forKey: kRentalPakageCarRentcardIdKey)
		}
		if rentcardAdminStatus != nil {
			dictionary.updateValue(rentcardAdminStatus! as AnyObject, forKey: kRentalPakageCarRentcardAdminStatusKey)
		}

        return dictionary
    }

}*/
