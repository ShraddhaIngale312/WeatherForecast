//
//	Sy.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Sy: NSObject {

	var country : String!
	var id : Int!
	var sunrise : Int!
	var sunset : Int!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		country = dictionary["country"] as? String
		id = dictionary["id"] as? Int
		sunrise = dictionary["sunrise"] as? Int
		sunset = dictionary["sunset"] as? Int
		type = dictionary["type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if country != nil{
			dictionary["country"] = country
		}
		if id != nil{
			dictionary["id"] = id
		}
		if sunrise != nil{
			dictionary["sunrise"] = sunrise
		}
		if sunset != nil{
			dictionary["sunset"] = sunset
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}
}
