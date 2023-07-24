import Foundation
import RxSwift
import RxCocoa

class FlightInfoViewModel {
    let flightInfo: BehaviorSubject<FlightInfo?> = BehaviorSubject(value: nil)
    let flightDuration: BehaviorSubject<Int?> = BehaviorSubject(value: nil)
    let disposeBag = DisposeBag()

    func fetchFlightInfo(flightIata: String) {
        APINetwork.shared.fetchFlightInfo(flightIata: flightIata)
            .subscribe(onNext: { [weak self] flightInfo in
                self?.flightInfo.onNext(flightInfo)
                self?.flightDuration.onNext(flightInfo.duration)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
