//
//  CustomTabBarController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 25.11.2023.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        adjustTabBarLayout()
//    }
    
    private func setupTabs() {
//        self.tabBar.setGradientBackground()
        self.tabBar.backgroundColor = .dynamicBG
        self.tabBar.unselectedItemTintColor = .dynamicText
        
        let service: FlightDataService = APIManager()
        let mapViewModel = RealtimeFlightsViewModel(flightsService: service)
        let listViewModel = RealtimeFlightsViewModel(flightsService: service)
        let delayViewModel = DelayedFlightViewModel(flightService: service)
        
        let mainVC = self.createNav(with: "Map View", image: UIImage(systemName: "globe"), vc: MainViewController(viewModel: mapViewModel))
        let listVC = self.createNav(with: "List View", image: UIImage(systemName: "tablecells"), vc: MainListViewController(viewModel: listViewModel))
        let delayVC = self.createNav(with: "Delayed Flight", image: UIImage(systemName: "clock.badge.questionmark"), vc: DelayedFlightsViewController(viewModel: delayViewModel))
        let favorites = self.createNav(with: "Favorites", image: UIImage(systemName: "heart"), vc: FavoriteViewController())
        
        setViewControllers([mainVC, listVC, delayVC, favorites], animated: true)
    }
    
    private func createNav(with title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
       return nav
    }
//    
//    private func adjustTabBarLayout() {
//            // Adjust the tab bar layout here
//            self.tabBar.frame.size.height = 60
//            self.tabBar.frame.origin.y = self.view.frame.height - 60
//    }
}
