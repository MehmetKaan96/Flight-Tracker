//
//  AppDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import Hero
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var settings: UNNotificationSettings?
    private let center = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        
        NotificationCenter.default.addObserver(self, selector: #selector(showNotification), name: NSNotification.Name("statusChanged"), object: nil)
        
        if !hasSeenOnboarding {
            showOnboarding()
        } else {
            showMainScreen()
        }
        
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge ,.sound]) {granted,
            error in
            if granted {
                print("We have permission")
            } else {
                print("Permission denied")
            }
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
            if let favoriteViewController = window?.rootViewController as? FavoriteViewController {
                favoriteViewController.startUpdateTimer()
            }
        }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping
        (UNNotificationPresentationOptions) -> Void
    ) {
        print("Received local notification \(notification)")
    }
    
    @objc private func showNotification(notification: Notification) {
        if let flight = notification.object as? FlightInfo {
            self.showLocalNotification(flight: flight)
        }
    }
    
    private func showLocalNotification(flight: FlightInfo) {
        let content = UNMutableNotificationContent()
        guard let iata = flight.response.flightIata, let status = flight.response.status else { return }
        content.title = "Your flight's status changed!"
        content.body = "Your flight \(iata)'s status has changed to \(status)"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 10,
            repeats: false)
        let request = UNNotificationRequest(
            identifier: "MyNotification",
            content: content,
            trigger: trigger)
        center.add(request)
    }
    
    func showOnboarding() {
        window = UIWindow()
        let onboardingViewController = OnboardingViewController()
        window?.rootViewController = onboardingViewController
        window?.makeKeyAndVisible()
    }
    
    func showMainScreen() {
        window = UIWindow()
        let navController = UINavigationController()
        let customTabBarController = CustomTabBarController()
        navController.viewControllers = [customTabBarController]
        
        window?.rootViewController = navController
        //        window?.rootViewController = FavoriteViewController()
        window?.makeKeyAndVisible()
    }
    
}

