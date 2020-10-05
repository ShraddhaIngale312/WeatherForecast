//
//  CommonMethods.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/21/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//

import Foundation
import UIKit

class CommonMethods: NSObject {

static let sharedInstance = CommonMethods()
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    /// Convert date to string
    ///
    /// - Parameter date: Date to convert
    ///   - dateFormat: date formatter
    ///   - timeZone: time zone if required to convert
    /// - Returns: Date String
    func convertDateToString(date: Date, timeZone: TimeZone? = nil) -> String {
        /// Statard date formatter string
        let standardDateFormatter = "MM/dd/yyyy"
        let dateFormatter = DateFormatter()
        if let time = timeZone {
            dateFormatter.timeZone = time
        }
        dateFormatter.dateFormat = standardDateFormatter
        return dateFormatter.string(from: date)
    }

    /// Function To Convert UTC date to date format to get string
    ///
    /// - Parameter timeInterval: time
    /// - Returns: return String Format Date
    func getDateFromTimeInterval(timeInterval: Int) -> String {
        let date = getDateFrom(timeInterval: timeInterval)
        return self.convertDateToString(date: date)
    }

    /// Function To Convert UTC date to date format to get Date
    ///
    /// - Parameter timeInterval: time
    /// - Returns: return String Format Date
    func getDateFrom(timeInterval: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timeInterval / 1000))
    }

    /**
     Set Primary Theme Color, applicable to boder of view
     - returns: UIColor
     */
    func blackBorderColorWithlessAlpha() -> UIColor {
        return UIColor(red: 80 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 0.3)
    }

}

extension UIView {
    /// set Corner Radius to view
       ///
       /// - Parameter radius: to set corner radius
       func setCornerRadius(_ radius: CGFloat = 0.0, isCircularCorner: Bool = false) {
           let layer = self.layer
           layer.cornerRadius = radius
           if isCircularCorner {
               layer.cornerRadius = self.frame.height / 2
           }
           layer.masksToBounds = true
       }
    /// TO SET SHADOW TO VIEW
    ///
    /// - Parameters:
    ///   - color: COLOR for shadow
    ///   - opacity: opacity of the layer’s shadow.
    ///   - offSet: The offset (in points) of the layer’s shadow
    ///   - radius: radius for shadow
    ///   - scale: The scale at which to rasterize content, relative to the coordinate space of the layer.
    func dropShadowToTF(color: UIColor = UIColor.black, opacity: Float = 0.3, offSet: CGSize = CGSize.zero, radius: CGFloat = 1, cornerRadius: CGFloat = 10, scale: Bool = true) {
        self.clipsToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }

    /// SET BORDER WIDTH WITH BORDER COLOR
    ///
    /// - Parameters:
    ///   - width: width of border
    ///   - borderColor: border Color
    ///   - corner: corner for corner to fold
    ///   - withShadow: is require Shadow or not
    func setBorderWidth(width: CGFloat, borderColor: UIColor, corner: CGFloat = 0.0, withShadow: Bool = false) {
        let layer = self.layer
        layer.borderWidth = width
        layer.borderColor = borderColor.cgColor
        if withShadow {
            self.layer.shadowOffset = CGSize(width: 5, height: 5)
            self.layer.shadowRadius = 5
            self.layer.shadowOpacity = 0.5
        } else {
            layer.masksToBounds = true
            layer.cornerRadius = corner
        }
    }
}
