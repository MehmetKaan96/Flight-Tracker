//
//  ViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import Lottie
import SnapKit
import AVFoundation

final class OnboardingViewController: UIViewController {
    private let titleLabel = UILabel()
    private let onboardingAnimation =  LottieAnimationView()
    private let descriptionLabel = UILabel()
    private let pageControl = UIPageControl()
    private let nextButton = UIButton()
    private var currentPage = 0
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if !NetworkManager.shared.isConnected {
            let alert = UIAlertController(title: "Error".localized(), message: "No Internet Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                exit(0)
            }))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            avPlayer.play()
            paused = false

            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
                self.avPlayer.seek(to: CMTime.zero)
                self.avPlayer.play()
            }
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        view.setGradientBackground()
        avPlayerLayer.frame = view.layer.bounds
    }
    
    private func setupUI() {
        
        let videoURL: URL = Bundle.main.url(forResource: "backgroundVideo", withExtension: "mp4")!
        avPlayer = AVPlayer(url: videoURL)
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        titleLabel.text = "Flight Finder"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .dynamicText
        titleLabel.font = .boldSystemFont(ofSize: 45)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-75)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        descriptionLabel.text = "Get current information about flights, departure and arrival times, gate numbers, and more. Stay informed about delays, cancellations, and any other changes to your flight schedule. Whether you're a frequent flyer or an occasional traveler, our app ensures you have all the essential details at your fingertips for a smooth and hassle-free journey.".localized()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .dynamicText
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.setTitle("Continue".localized(), for: .normal)
        nextButton.layer.cornerRadius = 30
        nextButton.configuration = .filled()
        view.addSubview(nextButton)
        view.bringSubviewToFront(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(75)
                make.centerX.equalToSuperview()
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
                make.height.equalTo(55)
        }
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            let mainViewController = CustomTabBarController()
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true)
    }
}
