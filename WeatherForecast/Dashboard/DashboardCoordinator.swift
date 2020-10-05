//
//  DashboardCoordinator.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//



import UIKit

class DashboardCoordinator: BaseCoordinator, CommonCoordinator {
    var navigationController: UINavigationController

    init(navController: UINavigationController) {
        self.navigationController = navController
    }

    func start() {
        guard let vc = DashboardViewController.instanceController(StoryBoards.main) as? DashboardViewController else {
            return
        }
        vc.viewModel.baseViewModelDelegate = self
        vc.viewModel.dashboardModelDelegate = self
        self.navigationController.pushViewController(vc, animated: false)
    }
}

extension DashboardCoordinator: DashboardViewModelDelegate {
    func pushDailyForecastViewController(city: String) {
    }
}
