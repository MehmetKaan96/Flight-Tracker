//
//  FavouritesViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.07.2023.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var favouritesTableView: UITableView!
    let disposeBag = DisposeBag()
    let favouriteFlightsRelay = BehaviorRelay<[FavouriteFlights]>(value: [])
    var notificationToken: NotificationToken?
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteFlightsRelay.asObservable().bind(to: favouritesTableView.rx.items(cellIdentifier: Constants.favouritesCell, cellType: FavouritesTableViewCell.self)) { row, model, cell in
            cell.status.text = model.status
            cell.flightiata.text = model.flightIata
            cell.arriata.text = model.arrIata
            cell.depiata.text = model.depIata
            cell.aircrafticao.text = model.aircraftIcao
        }.disposed(by: disposeBag)
        favouritesTableView.delegate = self
        view.setupGradientBackground()
        favouritesTableView.setupGradientBackground(isVertical: false, alpha: 0.4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        let favourites = realm.objects(FavouriteFlights.self).filter("isFavourite == true")
        
        notificationToken = favourites.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial, .update(_, _, _, _):
                self?.updateFavouriteFlights(favourites: favourites)
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationToken?.invalidate()
    }
    
    private func updateFavouriteFlights(favourites: Results<FavouriteFlights>) {
        let favouriteFlightsArray = Array(favourites)
        favouriteFlightsRelay.accept(favouriteFlightsArray)
    }
    
}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            self.deleteFavouriteFlight(at: indexPath)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func deleteFavouriteFlight(at indexPath: IndexPath) {
        let realm = try! Realm()
        let favouriteFlight = favouriteFlightsRelay.value[indexPath.row]
        let cell = favouritesTableView.cellForRow(at: indexPath) as? FlightsCollectionViewCell
        cell?.deleteFlightFromRealm(favouriteFlight)
        try! realm.write {
            realm.delete(favouriteFlight)
        }
    }
}
