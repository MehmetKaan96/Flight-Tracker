//
//  OnboardingModel.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation
import UIKit
import Lottie

struct OnboardingItem {
    let title: String
    let description: String
    let animation: String
}

let onboardingData = [
    OnboardingItem(title: "Flights Around the Globe".localized(), description: "Explore and gather information on all flights across the globe. Gain insight info about destinations worldwide. Whether you're planning your next adventure or simply curious about air traffic worldwide.".localized(), animation: "main"),
    OnboardingItem(title: "Favorite Flights".localized(), description: "Keep track of your favorite flights by adding them to your list of favorites, ensuring easy access to their updates, status changes, and important notifications.".localized(), animation: "favorite"),
    OnboardingItem(title: "Let's Take Off!".localized(), description: "Prepare for takeoff! Immerse yourself in the world of effortless flight tracking and embark on an exhilarating journey.".localized(), animation: "start")
]
