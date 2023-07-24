import Foundation
import RxSwift
import RxCocoa

class FlightsListViewModel {
    var flights: BehaviorRelay<[Flights]> = BehaviorRelay(value: [])
    var filteredFlights: BehaviorRelay<[Flights]> = BehaviorRelay(value: [])
    var searchText: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let disposeBag = DisposeBag()

    init() {
        fetchFlights()
    }

    func fetchFlights() {
        APINetwork.shared.fetchFlights()
            .compactMap { $0 }
            .bind(to: flights)
            .disposed(by: disposeBag)

        APINetwork.shared.startFetchingFlights(every: 1500)
            .compactMap { $0 }
            .bind(to: flights)
            .disposed(by: disposeBag)

        searchText.asObservable().subscribe(onNext: { [weak self] text in
            guard let self = self else { return }
            self.filteredFlights.accept(self.flights.value.filter {
                $0.flightIata?.range(of: text, options: .caseInsensitive) != nil
            })
        }).disposed(by: disposeBag)
    }
}
