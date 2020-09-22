//
//	CurrentWeatherData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CurrentWeatherData : NSObject {

	var base : String!
	var clouds : Cloud!
	var cod : Int!
	var coord : Coord!
	var dt : Int!
	var id : Int!
	var main : Main!
	var name : String!
	var rain : Rain!
	var sys : Sy!
	var timezone : Int!
	var visibility : Int!
	var weather : [Weather]!
	var wind : Wind!

    override init() {
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		base = dictionary["base"] as? String
		if let cloudsData = dictionary["clouds"] as? [String:Any]{
			clouds = Cloud(fromDictionary: cloudsData)
		}
		cod = dictionary["cod"] as? Int
		if let coordData = dictionary["coord"] as? [String:Any]{
			coord = Coord(fromDictionary: coordData)
		}
		dt = dictionary["dt"] as? Int
		id = dictionary["id"] as? Int
		if let mainData = dictionary["main"] as? [String:Any]{
			main = Main(fromDictionary: mainData)
		}
		name = dictionary["name"] as? String
		if let rainData = dictionary["rain"] as? [String:Any]{
			rain = Rain(fromDictionary: rainData)
		}
		if let sysData = dictionary["sys"] as? [String:Any]{
			sys = Sy(fromDictionary: sysData)
		}
		timezone = dictionary["timezone"] as? Int
		visibility = dictionary["visibility"] as? Int
		weather = [Weather]()
		if let weatherArray = dictionary["weather"] as? [[String:Any]]{
			for dic in weatherArray{
				let value = Weather(fromDictionary: dic)
				weather.append(value)
			}
		}
		if let windData = dictionary["wind"] as? [String:Any]{
			wind = Wind(fromDictionary: windData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any] {
		var dictionary = [String:Any]()
		if base != nil{
			dictionary["base"] = base
		}
		if clouds != nil{
			dictionary["clouds"] = clouds.toDictionary()
		}
		if cod != nil{
			dictionary["cod"] = cod
		}
		if coord != nil{
			dictionary["coord"] = coord.toDictionary()
		}
		if dt != nil{
			dictionary["dt"] = dt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if main != nil{
			dictionary["main"] = main.toDictionary()
		}
		if name != nil{
			dictionary["name"] = name
		}
		if rain != nil{
			dictionary["rain"] = rain.toDictionary()
		}
		if sys != nil{
			dictionary["sys"] = sys.toDictionary()
		}
		if timezone != nil{
			dictionary["timezone"] = timezone
		}
		if visibility != nil{
			dictionary["visibility"] = visibility
		}
		if weather != nil{
			var dictionaryElements = [[String:Any]]()
			for weatherElement in weather {
				dictionaryElements.append(weatherElement.toDictionary())
			}
			dictionary["weather"] = dictionaryElements
		}
		if wind != nil{
			dictionary["wind"] = wind.toDictionary()
		}
		return dictionary
	}
}
