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
    private var updateTimer: Timer?
    var currentStatus = "en-route"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUI()
        fetchFavFlights()
        
        startUpdateTimer()
    }
    
    func startUpdateTimer() {
            updateTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fetchFlightStatusInBackground), userInfo: nil, repeats: true)
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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        favoritesTableView.refreshControl = refreshControl
    }
    
    private func fetchFavFlights() {
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
    }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        fetchFavFlights()
        refreshControl.endRefreshing()
    }
    
    @objc private func fetchFlightStatusInBackground() {
            let config = URLSessionConfiguration.background(withIdentifier: "com.example.myApp.background")
            let backgroundSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)

            for flight in favFlights {
                guard let url = URL(string: "https://airlabs.co/api/v9/flight?flight_iata=\(flight.flightIata!)&api_key=\(Constants.API_KEY)") else {
                    print("Invalid URL")
                    return
                }

                // URLRequest oluştur
                var request = URLRequest(url: url)
                request.httpMethod = "GET"

                let task = backgroundSession.dataTask(with: request)
                task.resume()
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

extension FavoriteViewController: URLSessionDelegate, URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
            do {
                let flightInfo = try JSONDecoder().decode(FlightInfo.self, from: data)
                handleFlightInfo(flightInfo)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }

        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    
    func handleFlightInfo(_ flightInfo: FlightInfo) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                if let status = flightInfo.response.status {
                    if self.currentStatus == status {
                        NotificationCenter.default.post(name: NSNotification.Name("statusChanged"), object: flightInfo)
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name("statusChanged"), object: flightInfo)
                    }
                }

                // Diğer işlemleri buraya ekleyebilirsiniz
            }
        }
}
