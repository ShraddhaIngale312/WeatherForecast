//
//	Weather.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Weather : NSObject {

	var descriptionField : String!
	var icon : String!
	var id : Int!
	var main : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		descriptionField = dictionary["description"] as? String
		icon = dictionary["icon"] as? String
		id = dictionary["id"] as? Int
		main = dictionary["main"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if icon != nil{
			dictionary["icon"] = icon
		}
		if id != nil{
			dictionary["id"] = id
		}
		if main != nil{
			dictionary["main"] = main
		}
		return dictionary
	}
}
