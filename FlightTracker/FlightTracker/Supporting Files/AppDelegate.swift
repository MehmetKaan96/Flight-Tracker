//
//  AppDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit

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
//        let service: MovieService = APIManager()
//        let viewModel = MoviesViewModel(movieService: service)
//        let mainViewController = MainViewController(viewModel: viewModel)
        let mainViewController = MainViewController()
        let navCon = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navCon
        window?.makeKeyAndVisible()
    }
    
}

