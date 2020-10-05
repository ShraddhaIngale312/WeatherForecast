//
//	Main.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Main : NSObject {

	var feelsLike : Double!
	var humidity : Int!
	var pressure : Int!
	var temp : Double!
	var tempMax : Double!
	var tempMin : Double!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		feelsLike = dictionary["feels_like"] as? Double
		humidity = dictionary["humidity"] as? Int
		pressure = dictionary["pressure"] as? Int
		temp = dictionary["temp"] as? Double
		tempMax = dictionary["temp_max"] as? Double
		tempMin = dictionary["temp_min"] as? Double
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any] {
		var dictionary = [String:Any]()
		if feelsLike != nil{
			dictionary["feels_like"] = feelsLike
		}
		if humidity != nil{
			dictionary["humidity"] = humidity
		}
		if pressure != nil{
			dictionary["pressure"] = pressure
		}
		if temp != nil{
			dictionary["temp"] = temp
		}
		if tempMax != nil{
			dictionary["temp_max"] = tempMax
		}
		if tempMin != nil{
			dictionary["temp_min"] = tempMin
		}
		return dictionary
	}
}
