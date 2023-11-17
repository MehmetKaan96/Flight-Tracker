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
    OnboardingItem(title: "Flight Around the Globe", description: "View all flights around the world.", animation: "main"),
    OnboardingItem(title: "Get Notifications", description: "Get notifications about the flight you're tracking.", animation: "notify"),
    OnboardingItem(title: "Let's Take Off!", description: "Get ready for takeoff! Explore the world of seamless flight tracking and enjoy the journey.", animation: "start")
]
