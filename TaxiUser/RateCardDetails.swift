//
//  Details.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RateCardDetails: NSObject {


    internal let kDetailsPriceIdKey: String = "price_id"
    internal let kDetailsFreeWaitingTimeKey: String = "free_waiting_time"
    internal let kDetailsBasePricePerUnitKey: String = "base_price_per_unit"
    internal let kDetailsLaterBookingFeeKey: String = "later_booking_fee"
    internal let kDetailsPricePerRideMinuteKey: String = "price_per_ride_minute"
    internal let kDetailsBaseDistancePriceKey: String = "base_distance_price"
    internal let kDetailsWatingPriceMinuteKey: String = "wating_price_minute"
    internal let kDetailsNowBookingFeeKey: String = "now_booking_fee"
    internal let kDetailsScheduledCancelFeeKey: String = "scheduled_cancel_fee"
    internal let kDetailsCurrencyKey: String = "currency"
    internal let kDetailsBaseDistanceKey: String = "base_distance"
    internal let kDetailsCityIdKey: String = "city_id"
    internal let kDetailsCancelRideLaterFreeMinKey: String = "cancel_ride_later_free_min"
    internal let kDetailsCancelFeeKey: String = "cancel_fee"
    internal let kDetailsCarTypeIdKey: String = "car_type_id"
    internal let kDetailsCancelRideNowFreeMinKey: String = "cancel_ride_now_free_min"
    internal let kDetailsCommissionKey: String = "commission"
    internal let kDetailsDistanceUnitKey: String = "distance_unit"
    internal let kDetailsFreeRideMinutesKey: String = "free_ride_minutes"
    internal let kDetailsPeakTimePaymentTypeKey: String = "peak_time_payment_type"
    internal let kDetailsNightPaymentTypeKey: String = "night_payment_type"
    internal let kDetailsPeakTimeChargeKey: String = "peak_time_charge"
    internal let kDetailsNightTimeChargeKey: String = "night_time_charge"

    
    
    // MARK: Properties
    public var priceId: String?
    public var freeWaitingTime: String?
    public var basePricePerUnit: String?
    public var laterBookingFee: String?
    public var pricePerRideMinute: String?
    public var baseDistancePrice: String?
    public var watingPriceMinute: String?
    public var nowBookingFee: String?
    public var scheduledCancelFee: String?
    public var currency: String?
    public var baseDistance: String?
    public var cityId: String?
    public var cancelRideLaterFreeMin: String?
    public var cancelFee: String?
    public var carTypeId: String?
    public var cancelRideNowFreeMin: String?
    public var commission: String?
    public var distanceUnit: String?
    public var freeRideMinutes: String?
    public var peakTimeCharge: String?
    public var nightTimeCharge: String?
    public var nightPaymentType: String?
    public var peakTimePaymentType: String?
    
    
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
        priceId = json[kDetailsPriceIdKey].string
        freeWaitingTime = json[kDetailsFreeWaitingTimeKey].string
        basePricePerUnit = json[kDetailsBasePricePerUnitKey].string
        laterBookingFee = json[kDetailsLaterBookingFeeKey].string
        pricePerRideMinute = json[kDetailsPricePerRideMinuteKey].string
        baseDistancePrice = json[kDetailsBaseDistancePriceKey].string
        watingPriceMinute = json[kDetailsWatingPriceMinuteKey].string
        nowBookingFee = json[kDetailsNowBookingFeeKey].string
        scheduledCancelFee = json[kDetailsScheduledCancelFeeKey].string
        currency = json[kDetailsCurrencyKey].string
        baseDistance = json[kDetailsBaseDistanceKey].string
        cityId = json[kDetailsCityIdKey].string
        cancelRideLaterFreeMin = json[kDetailsCancelRideLaterFreeMinKey].string
        cancelFee = json[kDetailsCancelFeeKey].string
        carTypeId = json[kDetailsCarTypeIdKey].string
        cancelRideNowFreeMin = json[kDetailsCancelRideNowFreeMinKey].string
        commission = json[kDetailsCommissionKey].string
        distanceUnit = json[kDetailsDistanceUnitKey].string
        freeRideMinutes = json[kDetailsFreeRideMinutesKey].string
        peakTimeCharge = json[kDetailsPeakTimeChargeKey].string
        nightTimeCharge = json[kDetailsNightTimeChargeKey].string
        nightPaymentType = json[kDetailsNightPaymentTypeKey].string
        peakTimePaymentType = json[kDetailsPeakTimePaymentTypeKey].string

        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if priceId != nil {
            dictionary.updateValue(priceId! as AnyObject, forKey: kDetailsPriceIdKey)
        }
        if freeWaitingTime != nil {
            dictionary.updateValue(freeWaitingTime! as AnyObject, forKey: kDetailsFreeWaitingTimeKey)
        }
        if basePricePerUnit != nil {
            dictionary.updateValue(basePricePerUnit! as AnyObject, forKey: kDetailsBasePricePerUnitKey)
        }
        if laterBookingFee != nil {
            dictionary.updateValue(laterBookingFee! as AnyObject, forKey: kDetailsLaterBookingFeeKey)
        }
        if pricePerRideMinute != nil {
            dictionary.updateValue(pricePerRideMinute! as AnyObject, forKey: kDetailsPricePerRideMinuteKey)
        }
        if baseDistancePrice != nil {
            dictionary.updateValue(baseDistancePrice! as AnyObject, forKey: kDetailsBaseDistancePriceKey)
        }
        if watingPriceMinute != nil {
            dictionary.updateValue(watingPriceMinute! as AnyObject, forKey: kDetailsWatingPriceMinuteKey)
        }
        if nowBookingFee != nil {
            dictionary.updateValue(nowBookingFee! as AnyObject, forKey: kDetailsNowBookingFeeKey)
        }
        if scheduledCancelFee != nil {
            dictionary.updateValue(scheduledCancelFee! as AnyObject, forKey: kDetailsScheduledCancelFeeKey)
        }
        if currency != nil {
            dictionary.updateValue(currency! as AnyObject, forKey: kDetailsCurrencyKey)
        }
        if baseDistance != nil {
            dictionary.updateValue(baseDistance! as AnyObject, forKey: kDetailsBaseDistanceKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId! as AnyObject, forKey: kDetailsCityIdKey)
        }
        if cancelRideLaterFreeMin != nil {
            dictionary.updateValue(cancelRideLaterFreeMin! as AnyObject, forKey: kDetailsCancelRideLaterFreeMinKey)
        }
        if cancelFee != nil {
            dictionary.updateValue(cancelFee! as AnyObject, forKey: kDetailsCancelFeeKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId! as AnyObject, forKey: kDetailsCarTypeIdKey)
        }
        if cancelRideNowFreeMin != nil {
            dictionary.updateValue(cancelRideNowFreeMin! as AnyObject, forKey: kDetailsCancelRideNowFreeMinKey)
        }
        if commission != nil {
            dictionary.updateValue(commission! as AnyObject, forKey: kDetailsCommissionKey)
        }
        if distanceUnit != nil {
            dictionary.updateValue(distanceUnit! as AnyObject, forKey: kDetailsDistanceUnitKey)
        }
        if freeRideMinutes != nil {
            dictionary.updateValue(freeRideMinutes! as AnyObject, forKey: kDetailsFreeRideMinutesKey)
        }
        if peakTimeCharge != nil {
            dictionary.updateValue(peakTimeCharge! as AnyObject, forKey: kDetailsPeakTimeChargeKey)
        }
        if nightTimeCharge != nil {
            dictionary.updateValue(nightTimeCharge! as AnyObject, forKey: kDetailsNightTimeChargeKey)
        }
        if nightPaymentType != nil {
            dictionary.updateValue(nightPaymentType! as AnyObject, forKey: kDetailsNightPaymentTypeKey)
        }
        if peakTimePaymentType != nil {
            dictionary.updateValue(peakTimePaymentType! as AnyObject, forKey: kDetailsPeakTimePaymentTypeKey)
        }
        
        return dictionary
    }
    
}


  /*  internal let kDetailsBasePricePerUnitKey: String = "base_price_per_unit"
    internal let kDetailsFreeWaitingTimeKey: String = "free_waiting_time"
    internal let kDetailsPriceIdKey: String = "price_id"
    internal let kDetailsLaterBookingFeeKey: String = "later_booking_fee"
    internal let kDetailsPricePerRideMinuteKey: String = "price_per_ride_minute"
    internal let kDetailsBaseDistancePriceKey: String = "base_distance_price"
    internal let kDetailsWatingPriceMinuteKey: String = "wating_price_minute"
    internal let kDetailsNowBookingFeeKey: String = "now_booking_fee"
    internal let kDetailsScheduledCancelFeeKey: String = "scheduled_cancel_fee"
    internal let kDetailsBaseDistanceKey: String = "base_distance"
    internal let kDetailsCityIdKey: String = "city_id"
    internal let kDetailsCancelFeeKey: String = "cancel_fee"
    internal let kDetailsCarTypeIdKey: String = "car_type_id"
    internal let kDetailsFreeRideMinutesKey: String = "free_ride_minutes"
    
    
    // MARK: Properties
    public var basePricePerUnit: String?
    public var freeWaitingTime: String?
    public var priceId: String?
    public var laterBookingFee: String?
    public var pricePerRideMinute: String?
    public var baseDistancePrice: String?
    public var watingPriceMinute: String?
    public var nowBookingFee: String?
    public var scheduledCancelFee: String?
    public var baseDistance: String?
    public var cityId: String?
    public var cancelFee: String?
    public var carTypeId: String?
    public var freeRideMinutes: String?
    
    
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
        basePricePerUnit = json[kDetailsBasePricePerUnitKey].string
        freeWaitingTime = json[kDetailsFreeWaitingTimeKey].string
        priceId = json[kDetailsPriceIdKey].string
        laterBookingFee = json[kDetailsLaterBookingFeeKey].string
        pricePerRideMinute = json[kDetailsPricePerRideMinuteKey].string
        baseDistancePrice = json[kDetailsBaseDistancePriceKey].string
        watingPriceMinute = json[kDetailsWatingPriceMinuteKey].string
        nowBookingFee = json[kDetailsNowBookingFeeKey].string
        scheduledCancelFee = json[kDetailsScheduledCancelFeeKey].string
        baseDistance = json[kDetailsBaseDistanceKey].string
        cityId = json[kDetailsCityIdKey].string
        cancelFee = json[kDetailsCancelFeeKey].string
        carTypeId = json[kDetailsCarTypeIdKey].string
        freeRideMinutes = json[kDetailsFreeRideMinutesKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if basePricePerUnit != nil {
            dictionary.updateValue(basePricePerUnit! as AnyObject, forKey: kDetailsBasePricePerUnitKey)
        }
        if freeWaitingTime != nil {
            dictionary.updateValue(freeWaitingTime! as AnyObject, forKey: kDetailsFreeWaitingTimeKey)
        }
        if priceId != nil {
            dictionary.updateValue(priceId! as AnyObject, forKey: kDetailsPriceIdKey)
        }
        if laterBookingFee != nil {
            dictionary.updateValue(laterBookingFee! as AnyObject, forKey: kDetailsLaterBookingFeeKey)
        }
        if pricePerRideMinute != nil {
            dictionary.updateValue(pricePerRideMinute! as AnyObject, forKey: kDetailsPricePerRideMinuteKey)
        }
        if baseDistancePrice != nil {
            dictionary.updateValue(baseDistancePrice! as AnyObject, forKey: kDetailsBaseDistancePriceKey)
        }
        if watingPriceMinute != nil {
            dictionary.updateValue(watingPriceMinute! as AnyObject, forKey: kDetailsWatingPriceMinuteKey)
        }
        if nowBookingFee != nil {
            dictionary.updateValue(nowBookingFee! as AnyObject, forKey: kDetailsNowBookingFeeKey)
        }
        if scheduledCancelFee != nil {
            dictionary.updateValue(scheduledCancelFee! as AnyObject, forKey: kDetailsScheduledCancelFeeKey)
        }
        if baseDistance != nil {
            dictionary.updateValue(baseDistance! as AnyObject, forKey: kDetailsBaseDistanceKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId! as AnyObject, forKey: kDetailsCityIdKey)
        }
        if cancelFee != nil {
            dictionary.updateValue(cancelFee! as AnyObject, forKey: kDetailsCancelFeeKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId! as AnyObject, forKey: kDetailsCarTypeIdKey)
        }
        if freeRideMinutes != nil {
            dictionary.updateValue(freeRideMinutes! as AnyObject, forKey: kDetailsFreeRideMinutesKey)
        }
        
        return dictionary
}

}*/

