//
//  BaseViewModelDelegate.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//

import Foundation
import UIKit

@objc protocol BaseViewModelDelegate: class {
    /// Remove all coordinator objects
    func clearAllCoordinatores()
}

class BaseViewModel: NSObject {
    weak var baseViewModelDelegate: BaseViewModelDelegate?
    /// Call delegate to clear coordinator objects
    func clearCoordinatorObjects() {
        baseViewModelDelegate?.clearAllCoordinatores()
    }
}
