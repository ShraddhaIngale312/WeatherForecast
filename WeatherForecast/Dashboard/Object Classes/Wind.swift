//
//	Wind.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Wind : NSObject {

	var deg : Int!
	var speed : Double!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]) {
		deg = dictionary["deg"] as? Int
		speed = dictionary["speed"] as? Double
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any] {
		var dictionary = [String:Any]()
		if deg != nil{
			dictionary["deg"] = deg
		}
		if speed != nil{
			dictionary["speed"] = speed
		}
		return dictionary
	}
}
