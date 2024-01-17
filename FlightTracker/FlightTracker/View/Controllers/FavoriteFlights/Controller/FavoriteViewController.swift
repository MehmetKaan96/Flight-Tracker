//
//  FavoriteVC.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 2.01.2024.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {
    
    let favoritesTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUI()
    }
    
    private func createUI() {
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .dynamicBG
        
        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        view.addSubview(favoritesTableView)
        favoritesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        fetchFavFlights()
    }
    
    private func fetchFavFlights() {
        let realm = try! Realm()
        try! realm.write {
            let flights = realm.objects(RealmFlightInfo.self)
            favFlights.removeAll()
            
            for flight in flights {
                favFlights.append(flight)
            }
        }
        
        favoritesTableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favFlights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as! FavoritesTableViewCell
        cell.configure(with: favFlights[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            let flight = favFlights[indexPath.row]
            
            self.swipeDeleteAction(flight: flight, indexPath: indexPath)
            
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
    fileprivate func swipeDeleteAction(flight: RealmFlightInfo, indexPath: IndexPath) {
        
    }
    
}
