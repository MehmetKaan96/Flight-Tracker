//
//  AppDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import Hero

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        
        if !hasSeenOnboarding {
            showOnboarding()
        } else {
            showMainScreen()
        }
        return true
    }
    
    func showOnboarding() {
        window = UIWindow()
        let onboardingViewController = OnboardingViewController()
        window?.rootViewController = onboardingViewController
        window?.makeKeyAndVisible()
    }

    func showMainScreen() {
        window = UIWindow()
//        let service: FlightDataService = APIManager()
//        let viewModel = RealtimeFlightsViewModel(flightsService: service)
//        let mainViewController = MainViewController(viewModel: viewModel)
//        let navCon = UINavigationController(rootViewController: mainViewController)
//        navCon.isHeroEnabled = true
//        window?.rootViewController = navCon
        let vc = FlightDetailViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
}

