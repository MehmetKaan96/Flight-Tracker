//
//  AppDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import Hero
import RealmSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    let realm = try? Realm()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { authorized, error in
            if authorized {
                print("User authorized notifications.")
            } else {
                print(error?.localizedDescription)
            }
        }
        
        if let realm = realm {
            let flights = realm.objects(RealmFlightInfo.self)
            favFlights.removeAll()
            
            for flight in flights {
                favFlights.append(flight)
            }
        }
        
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
        let navController = UINavigationController()
        let customTabBarController = CustomTabBarController()
        navController.viewControllers = [customTabBarController]
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
//        var newDataReceived = false
//        for flight in favFlights {
//            guard let flight = flight.flightIata else { continue }
//            APIManager().fetchFlightInfo(with: flight) { [self] result in
//                switch result {
//                case .success(let flight):
//                    guard let status = flight.response.status else { return }
//                    showLocalNotification(for: flight.response, status: status)
//                    newDataReceived = true
//                case .failure(let failure):
//                    print(failure.localizedDescription)
//                }
//            }
//        }
//        
//        if newDataReceived {
//            completionHandler(.newData)
//        } else {
//            completionHandler(.noData)
//        }
        
        var newDataReceived = false
            let fetchInterval: TimeInterval = 60
            
            for flight in favFlights {
                guard let flight = flight.flightIata else { continue }
                APIManager().fetchFlightInfo(with: flight) { [self] result in
                    switch result {
                    case .success(let flight):
                        guard let status = flight.response.status else { return }
                        showLocalNotification(for: flight.response, status: status)
                        newDataReceived = true
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
            
            if newDataReceived {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: fetchInterval, repeats: false)
                let request = UNNotificationRequest(identifier: "FetchUpdate", content: UNNotificationContent(), trigger: trigger)
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error adding fetch notification request: \(error.localizedDescription)")
                    } else {
                        print("Fetch notification scheduled successfully.")
                    }
                }
                
                completionHandler(.newData)
            } else {
                completionHandler(.noData)
            }
        
    }
        
    func showLocalNotification(for flight: FlightInfo, status: String) {
        guard let flightIATA = flight.flightIata else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Flight Status Update"
        content.body = "The status of your flight \(flightIATA) has been updated to \(status)."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "FlightStatusUpdate", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification request: \(error.localizedDescription)")
            } else {
                print("Local notification scheduled successfully.")
            }
        }
    }
    
}

