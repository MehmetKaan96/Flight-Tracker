//
//  FavoriteVC.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 2.01.2024.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .dynamicBG
        
        let realm = try! Realm()
        
        let favorites = realm.objects(RealmFlightInfo.self)
        
        for fav in favorites {
            print(fav.arrCity)
        }
    }
    
}
