//
//  DashboardViewModel.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//


import UIKit
import CoreData

protocol DashboardViewModelDelegate: class {
    /// Push VC to NavController
    func pushDailyForecastViewController(city: String)
}

class DashboardViewModel: BaseViewModel {
    var dashboardModelDelegate: DashboardViewModelDelegate?
    var notFirstLoad = false
    var currentWeatherData = CurrentWeatherData()
    var dbObject: NSManagedObject?
    let invalidCharacters = CharacterSet(charactersIn: "{}$#%*&^.,/?!@")

    func getWeatherDataAPICall(cityNAme: String, _ completion: @escaping (_ success: Bool?) -> Void) {
        // Create URL
        let apiURL = Constants.serverBaseURLCommon + Constants.EndPoints.getWeatherDataPart1 + cityNAme + Constants.EndPoints.getWeatherDataPart2 + Constants.appKey
        guard let urlString = apiURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = URL(string: urlString)
        guard let requestUrl = url else { return }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let weakSelf = self {
                // Check if Error took place
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                    if response.statusCode == 404 {
                        completion(false)
                    }
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8), let dict = CommonMethods.sharedInstance.convertToDictionary(text: dataString) {
                    print("Response data string:\n \(dataString)", dict)
                    weakSelf.currentWeatherData = CurrentWeatherData.init(fromDictionary: dict)
                    DispatchQueue.main.async {
                        weakSelf.createData(data: weakSelf.currentWeatherData)
                        completion(true)
                    }
                } else {
                    completion(false)
                }
            }
        }
        task.resume()
    }


   func createData(data: CurrentWeatherData) {
       //As we know that container is set up in the AppDelegates so we need to refer that container.
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       //We need to create a context from this container
       let managedContext = appDelegate.persistentContainer.viewContext
       //Now let’s create an entity and new user records.
       let userEntity = NSEntityDescription.entity(forEntityName: Constants.EntityName.weatherDetailsEntity, in: managedContext)!
       //final, we need to add some data to our newly created record for each keys using
       let weatherData = NSManagedObject(entity: userEntity, insertInto: managedContext)
        if data.name != nil {
            weatherData.setValue(data.name.lowercased(), forKeyPath: Constants.AttributesName.cityName)
        }
        if let cloud = data.clouds, cloud.all != nil {
            weatherData.setValue(cloud.all, forKey: Constants.AttributesName.cloudsAll)
        }
        if let cloud = data.main, cloud.humidity != nil {
            weatherData.setValue(cloud.humidity, forKeyPath: Constants.AttributesName.humidity)
        }
        if data.id != nil {
            weatherData.setValue(data.id, forKey: Constants.AttributesName.id)
        }
        if data.weather.count > 0, let desc = data.weather.first?.descriptionField {
            weatherData.setValue(desc, forKeyPath: Constants.AttributesName.description)
        }
        if let cloud = data.main, cloud.tempMax != nil {
            weatherData.setValue(kelvinToDegree(cloud.tempMax), forKey: Constants.AttributesName.temp_max)
        }
        if let cloud = data.main, cloud.tempMin != nil {
            weatherData.setValue(kelvinToDegree(cloud.tempMin), forKeyPath: Constants.AttributesName.temp_min)
        }
        if let cloud = data.wind, cloud.speed != nil {
            weatherData.setValue(cloud.speed, forKey: Constants.AttributesName.windSpeed)
        }
       weatherData.setValue(CommonMethods.sharedInstance.convertDateToString(date: Date(), timeZone: .current), forKey: Constants.AttributesName.date)
       do {
           try managedContext.save()
       } catch let error as NSError {
           print("Could not save. \(error), \(error.userInfo)")
       }
   }

    func kelvinToDegree(_ val: Double) -> Double {
        return val - 273.15
    }

   func retrieveData(city: String) -> NSManagedObject? {
       //As we know that container is set up in the AppDelegates so we need to refer that container.
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
       //We need to create a context from this container
       let managedContext = appDelegate.persistentContainer.viewContext
       //Prepare the request of type NSFetchRequest  for the entity
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.EntityName.weatherDetailsEntity)
       fetchRequest.fetchLimit = 1
       fetchRequest.predicate = NSPredicate(format: "cityName = %@", city.lowercased())
       do {
           let result = try managedContext.fetch(fetchRequest)
            print("DB data - ", result)
           if result.count > 0, let data = result.first as? NSManagedObject {
               let todaysDate = CommonMethods.sharedInstance.convertDateToString(date: Date(), timeZone: .current)
               if let dbDate = data.value(forKey: Constants.AttributesName.date) as? String, dbDate == todaysDate {
                   return data
               } else {
                   deleteAllData(Constants.EntityName.weatherDetailsEntity)
               }
           } else {
               return nil
           }
       } catch {
           print("Failed")
       }
       return nil
   }

    func deleteAllData(_ entity:String) {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
