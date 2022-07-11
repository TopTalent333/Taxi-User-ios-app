//
//  Details.swift
//
//  Created by AppOrio on 01/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RentalBookDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsBookingAdminStatusKey: String = "booking_admin_status"
	internal let kDetailsBookingStatusKey: String = "booking_status"
	internal let kDetailsPickupLocationKey: String = "pickup_location"
	internal let kDetailsEndMeterReadingImageKey: String = "end_meter_reading_image"
	internal let kDetailsLastUpdateTimeKey: String = "last_update_time"
	internal let kDetailsUserBookingDateTimeKey: String = "user_booking_date_time"
	internal let kDetailsDriverIdKey: String = "driver_id"
	internal let kDetailsRentcardIdKey: String = "rentcard_id"
	internal let kDetailsEndMeterReadingKey: String = "end_meter_reading"
	internal let kDetailsBookingTypeKey: String = "booking_type"
	internal let kDetailsRentalBookingIdKey: String = "rental_booking_id"
	internal let kDetailsBookingDateKey: String = "booking_date"
	internal let kDetailsCarTypeIdKey: String = "car_type_id"
	internal let kDetailsUserIdKey: String = "user_id"
	internal let kDetailsStartMeterReadingImageKey: String = "start_meter_reading_image"
	internal let kDetailsStartMeterReadingKey: String = "start_meter_reading"
	internal let kDetailsPickupLatKey: String = "pickup_lat"
	internal let kDetailsPickupLongKey: String = "pickup_long"
	internal let kDetailsBookingTimeKey: String = "booking_time"


    // MARK: Properties
	public var bookingAdminStatus: String?
	public var bookingStatus: String?
	public var pickupLocation: String?
	public var endMeterReadingImage: String?
	public var lastUpdateTime: String?
	public var userBookingDateTime: String?
	public var driverId: String?
	public var rentcardId: String?
	public var endMeterReading: String?
	public var bookingType: String?
	public var rentalBookingId: String?
	public var bookingDate: String?
	public var carTypeId: String?
	public var userId: String?
	public var startMeterReadingImage: String?
	public var startMeterReading: String?
	public var pickupLat: String?
	public var pickupLong: String?
	public var bookingTime: String?


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
		bookingAdminStatus = json[kDetailsBookingAdminStatusKey].string
		bookingStatus = json[kDetailsBookingStatusKey].string
		pickupLocation = json[kDetailsPickupLocationKey].string
		endMeterReadingImage = json[kDetailsEndMeterReadingImageKey].string
		lastUpdateTime = json[kDetailsLastUpdateTimeKey].string
		userBookingDateTime = json[kDetailsUserBookingDateTimeKey].string
		driverId = json[kDetailsDriverIdKey].string
		rentcardId = json[kDetailsRentcardIdKey].string
		endMeterReading = json[kDetailsEndMeterReadingKey].string
		bookingType = json[kDetailsBookingTypeKey].string
		rentalBookingId = json[kDetailsRentalBookingIdKey].string
		bookingDate = json[kDetailsBookingDateKey].string
		carTypeId = json[kDetailsCarTypeIdKey].string
		userId = json[kDetailsUserIdKey].string
		startMeterReadingImage = json[kDetailsStartMeterReadingImageKey].string
		startMeterReading = json[kDetailsStartMeterReadingKey].string
		pickupLat = json[kDetailsPickupLatKey].string
		pickupLong = json[kDetailsPickupLongKey].string
		bookingTime = json[kDetailsBookingTimeKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if bookingAdminStatus != nil {
			dictionary.updateValue(bookingAdminStatus! as AnyObject, forKey: kDetailsBookingAdminStatusKey)
		}
		if bookingStatus != nil {
			dictionary.updateValue(bookingStatus! as AnyObject, forKey: kDetailsBookingStatusKey)
		}
		if pickupLocation != nil {
			dictionary.updateValue(pickupLocation! as AnyObject, forKey: kDetailsPickupLocationKey)
		}
		if endMeterReadingImage != nil {
			dictionary.updateValue(endMeterReadingImage! as AnyObject, forKey: kDetailsEndMeterReadingImageKey)
		}
		if lastUpdateTime != nil {
			dictionary.updateValue(lastUpdateTime! as AnyObject, forKey: kDetailsLastUpdateTimeKey)
		}
		if userBookingDateTime != nil {
			dictionary.updateValue(userBookingDateTime! as AnyObject, forKey: kDetailsUserBookingDateTimeKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId! as AnyObject, forKey: kDetailsDriverIdKey)
		}
		if rentcardId != nil {
			dictionary.updateValue(rentcardId! as AnyObject, forKey: kDetailsRentcardIdKey)
		}
		if endMeterReading != nil {
			dictionary.updateValue(endMeterReading! as AnyObject, forKey: kDetailsEndMeterReadingKey)
		}
		if bookingType != nil {
			dictionary.updateValue(bookingType! as AnyObject, forKey: kDetailsBookingTypeKey)
		}
		if rentalBookingId != nil {
			dictionary.updateValue(rentalBookingId! as AnyObject, forKey: kDetailsRentalBookingIdKey)
		}
		if bookingDate != nil {
			dictionary.updateValue(bookingDate! as AnyObject, forKey: kDetailsBookingDateKey)
		}
		if carTypeId != nil {
			dictionary.updateValue(carTypeId! as AnyObject, forKey: kDetailsCarTypeIdKey)
		}
		if userId != nil {
			dictionary.updateValue(userId! as AnyObject, forKey: kDetailsUserIdKey)
		}
		if startMeterReadingImage != nil {
			dictionary.updateValue(startMeterReadingImage! as AnyObject, forKey: kDetailsStartMeterReadingImageKey)
		}
		if startMeterReading != nil {
			dictionary.updateValue(startMeterReading! as AnyObject, forKey: kDetailsStartMeterReadingKey)
		}
		if pickupLat != nil {
			dictionary.updateValue(pickupLat! as AnyObject, forKey: kDetailsPickupLatKey)
		}
		if pickupLong != nil {
			dictionary.updateValue(pickupLong! as AnyObject, forKey: kDetailsPickupLongKey)
		}
		if bookingTime != nil {
			dictionary.updateValue(bookingTime! as AnyObject, forKey: kDetailsBookingTimeKey)
		}

        return dictionary
    }

}
