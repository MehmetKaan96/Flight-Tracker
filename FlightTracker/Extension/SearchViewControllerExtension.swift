//
//  SearchViewControllerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 24.07.2023.
//

import UIKit

//MARK: - TableViewDelegate

extension SearchViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let selectedIndexPaths = searchCollectionView.indexPathsForSelectedItems,
               let indexPath = selectedIndexPaths.first {
                let selectedRow = indexPath.row
                let flight = viewModel.filteredFlights.value[selectedRow]
                if let flightIata = flight.flightIata {
                    let detailVC = segue.destination as! DetailsViewController
                    let flightInfoVM = FlightInfoViewModel()
                    flightInfoVM.fetchFlightInfo(flightIata: flightIata)
                    detailVC.viewModel = flightInfoVM
                }
            }
        }
    }
}
