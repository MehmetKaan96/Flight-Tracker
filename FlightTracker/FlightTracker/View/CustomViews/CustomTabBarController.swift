//
//  CustomTabBarController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 25.11.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        self.tabBar.backgroundColor = .gradientTop.withAlphaComponent(0.4)
        
        let service: FlightDataService = APIManager()
        let mapViewModel = RealtimeFlightsViewModel(flightsService: service)
        let listViewModel = RealtimeFlightsViewModel(flightsService: service)
        
        let mainVC = self.createNav(with: "Map View", image: UIImage(systemName: "globe"), vc: MainViewController(viewModel: mapViewModel))
        let listVC = self.createNav(with: "List View", image: UIImage(systemName: "tablecells"), vc: MainListViewController(viewModel: listViewModel))
        
        
        setViewControllers([mainVC, listVC], animated: true)
    }
    
    private func createNav(with title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
       return nav
    }
}
