//
//  CommonCoordinator.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//

import UIKit

protocol CommonCoordinator: class {
    func start()
}

/// Module Wise Story Board Names
enum StoryBoards: String {
    case main = "Main"

    func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}

extension UIViewController {
    /// to get instance of VC
    ///
    /// - Parameter storyboard: name of storyboard
    /// - Returns: instance of VC
    class func instanceController(_ storyboard: StoryBoards) -> UIViewController? {
        return storyboard.storyboard().instantiateViewController(withIdentifier: self.nameOfClass)
    }
}

extension NSObject {
    /// It will return name of class
    static var nameOfClass: String {
        guard let className = NSStringFromClass(self).components(separatedBy: ".").last else {
            return ""
        }
        return className
    }

    /// Getting ClassName in string format
    class var className: String {
        return String(describing: self)
    }
}
