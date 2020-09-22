//
//	Coord.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Coord : NSObject {

	var lat : Float!
	var lon : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		lat = dictionary["lat"] as? Float
		lon = dictionary["lon"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any] {
		var dictionary = [String:Any]()
		if lat != nil{
			dictionary["lat"] = lat
		}
		if lon != nil{
			dictionary["lon"] = lon
		}
		return dictionary
	}
}
