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
//        let customTabBarController = CustomTabBarController()
//        window?.rootViewController = customTabBarController
        window?.rootViewController = MiniDetailPageViewController()
        window?.makeKeyAndVisible()
    }
    
}

