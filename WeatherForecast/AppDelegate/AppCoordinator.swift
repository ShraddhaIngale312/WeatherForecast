//
//  AppCoordinator.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//



import UIKit

class AppCoordinator: CommonCoordinator {
    var window: UIWindow
  
    init(windowObject: UIWindow) {
        self.window = windowObject
    }

    func start() {
        let navigationController = UINavigationController()
        if self.window.rootViewController != nil {
            self.window.rootViewController = nil
        }
        self.window.rootViewController = navigationController
        let coordinator = DashboardCoordinator(navController: navigationController)
        coordinator.start()
        self.window.rootViewController = navigationController
    }
}
