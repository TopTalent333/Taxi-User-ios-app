//
//  Steps.swift
//
//  Created by ApporioMac8 on 31/05/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Steps: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let startLocation = "start_location"
    static let endLocation = "end_location"
    static let polyline = "polyline"
    static let travelMode = "travel_mode"
    static let distance = "distance"
    static let htmlInstructions = "html_instructions"
    static let maneuver = "maneuver"
    static let duration = "duration"
  }

  // MARK: Properties
  public var startLocation: StartLocation?
  public var endLocation: EndLocation?
 // public var polyline: Polyline?
  public var travelMode: String?
  public var distance: Distance?
  public var htmlInstructions: String?
  public var maneuver: String?
  public var duration: Duration?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    startLocation = StartLocation(json: json[SerializationKeys.startLocation])
    endLocation = EndLocation(json: json[SerializationKeys.endLocation])
  //  polyline = Polyline(json: json[SerializationKeys.polyline])
    travelMode = json[SerializationKeys.travelMode].string
    distance = Distance(json: json[SerializationKeys.distance])
    htmlInstructions = json[SerializationKeys.htmlInstructions].string
    maneuver = json[SerializationKeys.maneuver].string
    duration = Duration(json: json[SerializationKeys.duration])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = startLocation { dictionary[SerializationKeys.startLocation] = value.dictionaryRepresentation() }
    if let value = endLocation { dictionary[SerializationKeys.endLocation] = value.dictionaryRepresentation() }
  /*  if let value = polyline { dictionary[SerializationKeys.polyline] = value.dictionaryRepresentation() }*/
    if let value = travelMode { dictionary[SerializationKeys.travelMode] = value }
    if let value = distance { dictionary[SerializationKeys.distance] = value.dictionaryRepresentation() }
    if let value = htmlInstructions { dictionary[SerializationKeys.htmlInstructions] = value }
    if let value = maneuver { dictionary[SerializationKeys.maneuver] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.startLocation = aDecoder.decodeObject(forKey: SerializationKeys.startLocation) as? StartLocation
    self.endLocation = aDecoder.decodeObject(forKey: SerializationKeys.endLocation) as? EndLocation
 //   self.polyline = aDecoder.decodeObject(forKey: SerializationKeys.polyline) as? Polyline
    self.travelMode = aDecoder.decodeObject(forKey: SerializationKeys.travelMode) as? String
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? Distance
    self.htmlInstructions = aDecoder.decodeObject(forKey: SerializationKeys.htmlInstructions) as? String
    self.maneuver = aDecoder.decodeObject(forKey: SerializationKeys.maneuver) as? String
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? Duration
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(startLocation, forKey: SerializationKeys.startLocation)
    aCoder.encode(endLocation, forKey: SerializationKeys.endLocation)
  //  aCoder.encode(polyline, forKey: SerializationKeys.polyline)
    aCoder.encode(travelMode, forKey: SerializationKeys.travelMode)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(htmlInstructions, forKey: SerializationKeys.htmlInstructions)
    aCoder.encode(maneuver, forKey: SerializationKeys.maneuver)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
  }

}
