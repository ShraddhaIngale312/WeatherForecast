//
//  Constants.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//
import Foundation

struct Constants {
//"https://api.openweathermap.org/data/2.5/weather?q=maharashtra&appid=300fca411c378c630b8d52e7926f845e"

    static let serverBaseURLCommon = "https://api.openweathermap.org/"
    static let appKey = "300fca411c378c630b8d52e7926f845e"

    enum EndPoints {
        static let getWeatherDataPart1 = "data/2.5/weather?q="
        static let getWeatherDataPart2 = "&appid="
        static let getWeatherIcon = "http://openweathermap.org/img/wn/10d@2x.png"
    }

    enum EntityName {
        static let weatherDetailsEntity = "WeatherDetails"
    }

    enum AttributesName {
        static let cityName = "cityName"
        static let cloudsAll = "cloudsAll"
        static let humidity = "humidity"
        static let id = "id"
        static let description = "descriptionF"
        static let temp_max = "temp_max"
        static let temp_min = "temp_min"
        static let windSpeed = "windSpeed"
        static let date = "date"
    }
}
