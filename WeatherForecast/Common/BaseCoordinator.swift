//
//  BaseCoordinator.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//

import Foundation
import UIKit

class BaseCoordinator: BaseViewModelDelegate {
    /// Dictionary with coordinator class object and class name as a key
    /// E.g. coordinators[String(describing: MyCoordinator.self)] = myCoordinator
    var coordinators = [String: CommonCoordinator]()
    /// Remove all coordinator objects from array
    func clearAllCoordinatores() {
        coordinators.removeAll()
    }
}
