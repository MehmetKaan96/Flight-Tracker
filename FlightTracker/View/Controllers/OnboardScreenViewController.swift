//
//  OnboardScreenViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.07.2023.
//

import UIKit

struct OnboardingPage {
    let image: UIImage
    let mainText: String
    let subText: String
}

class OnboardScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    let userDefaults = UserDefaults.standard
    
    var currentPage = 0
    
    let onboardPages: [OnboardingPage] = [
        OnboardingPage(image: UIImage(named: "img1")!, mainText: "Flight Tracker'a hoş geldiniz", subText: "Uçuşlarınızı kolaylıkla takip edin!"),
        OnboardingPage(image: UIImage(named: "img2")!, mainText: "Gerçek zamanlı güncellemeler", subText: "Uçuşlarınızda gerçek zamanlı güncellemeler alın!"),
        OnboardingPage(image: UIImage(named: "img3")!, mainText: "Başlamaya hazır mısın?", subText: "Hadi, Başlayalım!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        

    }
        
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentPage = min(currentPage + 1, onboardPages.count - 1)
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
    }
    
    
}


extension OnboardScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardPages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardCollectionViewCell
        let page = onboardPages[indexPath.row]
        cell.configure(with: page)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(round(scrollView.contentOffset.x/collectionView.frame.width))
        nextButton.isHidden = currentPage == onboardPages.count - 1
        startButton.isHidden = !nextButton.isHidden
    }
}
