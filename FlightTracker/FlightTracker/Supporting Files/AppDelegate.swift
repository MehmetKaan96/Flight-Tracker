//
//  AppDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import Hero
import BackgroundTasks
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    static let bgAppTaskId = "com.mehmetkaan.FlightTracker"
    var settings: UNNotificationSettings?
    private let center = UNUserNotificationCenter.current()
    var bgTask: BGAppRefreshTask?
    lazy var bgExpirationHandler = {{
        if let task = self.bgTask {
            task.setTaskCompleted(success: true)
        }
    }}()
    
    private var timer: Timer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        
        BGTaskScheduler.shared.register(
                    forTaskWithIdentifier: AppDelegate.bgAppTaskId,
                    using: DispatchQueue.global()
                ) { task in
                    self.handleAppRefresh(task: task as! BGAppRefreshTask)
                }
        
        self.scheduleAppRefresh()

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
    
    func scheduleAppRefresh() {
        do {
            let request = BGAppRefreshTaskRequest(identifier: AppDelegate.bgAppTaskId)
            request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 1)
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Unable to schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
            scheduleAppRefresh() // Schedule the next refresh task

            // Fetch data in the background
            fetchDataInBackground()

            // Mark the task as completed
            task.setTaskCompleted(success: true)
        }

        func fetchDataInBackground() {
            NotificationCenter.default.post(name: NSNotification.Name("appEnterBackground"), object: nil)
        }
        
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping
        (UNNotificationPresentationOptions) -> Void
    ) {
        print("Received local notification \(notification)")
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
}

