import Foundation
import RxSwift
import RxCocoa

class FlightDelaysListViewModel {
    let flightInfo: BehaviorSubject<[FlightInfo]> = BehaviorSubject(value: [])
    let disposeBag = DisposeBag()
    
    func fetchDelayedFlightInfos(duration: String, type: String) {
        APINetwork.shared.fetchDelayedFlights(with: duration, flightType: type)
            .subscribe(onNext: { [weak self] flightInfoResponse in
                self?.flightInfo.onNext(flightInfoResponse.response)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
