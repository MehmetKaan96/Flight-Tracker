import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController, UIScrollViewDelegate, UISearchBarDelegate {
    
    let viewModel = FlightsListViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        viewModel.filteredFlights
            .bind(to: searchCollectionView.rx.items(cellIdentifier: "searchCell", cellType: SearchCollectionViewCell.self)) { (index, flight: Flights, cell) in
                if let iata = flight.flightIata, let arr_iata = flight.arrIata, let status = flight.status, let dep_iata = flight.depIata {
                    cell.arrIATA.text = arr_iata
                    cell.depIATA.text = dep_iata
                    cell.statusLabel.text = status
                    cell.flightIATA.text = iata
                }
            }
            .disposed(by: disposeBag)
        view.setupGradientBackground(isVertical: false)
        
        viewModel.fetchFlights()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    func setupCollectionView() {
        searchCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    @objc func hidekeyboard() {
        searchBar.resignFirstResponder()
    }
}
