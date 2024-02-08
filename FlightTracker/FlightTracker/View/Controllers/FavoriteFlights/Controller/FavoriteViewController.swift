//
//  FavoriteVC.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 2.01.2024.
//

import UIKit
import RealmSwift

final class FavoriteViewController: UIViewController {
    
    private let favoritesTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUI()
        fetchFavFlights()
    }
    
    private func createUI() {
        navigationItem.title = "Favorites".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .dynamicBG
        
        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        view.addSubview(favoritesTableView)
        favoritesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        favoritesTableView.refreshControl = refreshControl
    }
    
    func fetchFavFlights() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let realm = try! Realm()
            let flights = realm.objects(RealmFlightInfo.self)
            favFlights.removeAll()
            
            for flight in flights {
                favFlights.append(flight)
            }
            self.favoritesTableView.reloadData()
        }
        
        for flight in favFlights {
            print(flight.arrCity)
        }
    }
    
    @objc private func refreshTableView(refreshControl: UIRefreshControl) {
        fetchFavFlights()
        refreshControl.endRefreshing()
    }
    
    func fetchStatus(completion: @escaping () -> ()) {
        APIManager().fetchFlights { result in
            switch result {
            case .success(let flights):
                    completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        130
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completionHandler in
            guard let self = self else { return }
            let flight = favFlights[indexPath.row]
            favFlights.remove(at: indexPath.row)
            self.favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            self.swipeDeleteAction(flight: flight)
            
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
    fileprivate func swipeDeleteAction(flight: RealmFlightInfo) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(flight)
            }
        } catch {
            print("Realm error: \(error)")
        }
    }
}

