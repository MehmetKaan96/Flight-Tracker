//
//  ViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import Lottie
import SnapKit

class OnboardingViewController: UIViewController {
    let titleLabel = UILabel()
    var onboardingAnimation =  LottieAnimationView()
    let descriptionLabel = UILabel()
    let pageControl = UIPageControl()
    let nextButton = UIButton()
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        view.setGradientBackground()
        view.backgroundColor = .dynamicBG
    }
    
    private func setupUI() {
        view.addSubview(onboardingAnimation)
        onboardingAnimation.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .dynamicText
        titleLabel.font = .boldSystemFont(ofSize: 25)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingAnimation.snp.bottom).offset(5)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .dynamicText
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(45)
        }
        
        if #available(iOS 15.0, *) {
            nextButton.configuration = .plain()
        } else {
            // Fallback on earlier versions
        }
        nextButton.backgroundColor = .theme
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(100)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(55)
        }
        
        pageControl.numberOfPages = onboardingData.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .white
        if #available(iOS 16.0, *) {
            pageControl.direction = .leftToRight
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        setPage(index: 0)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if currentPage == onboardingData.count - 1 {
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            let service: FlightDataService = APIManager()
            let viewModel = RealtimeFlightsViewModel(flightsService: service)
            let mainViewController = MainViewController(viewModel: viewModel)
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true)
        } else {
            let nextIndex = min(currentPage + 1, onboardingData.count - 1)
            setPage(index: nextIndex)
        }
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        setPage(index: sender.currentPage)
    }
    
    private func setPage(index: Int) {
        guard index >= 0 && index < onboardingData.count else {
            return
        }
        
        let item = onboardingData[index]
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        onboardingAnimation.animation = LottieAnimation.named(item.animation)
        onboardingAnimation.loopMode = .loop
        onboardingAnimation.play()
        
        pageControl.currentPage = index
        currentPage = index
        
        if index == onboardingData.count - 1 {
            nextButton.setTitle("Get Started", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
}
