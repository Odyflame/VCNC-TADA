//
//  RideStatusViewModel.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/30.
//

import Foundation
import Network
import RxSwift
import RxCocoa

protocol RideStatusViewModelInput {
    func getToastMessage(message: String)
}

protocol RideStatusViewModelOutput {
    var rideToast: BehaviorRelay<String> { get }
}

protocol RideStatusViewModelType {
    var input: RideStatusViewModelInput { get }
    var output: RideStatusViewModelOutput { get }
}

final class RideStatusViewModel: RideStatusViewModelInput, RideStatusViewModelOutput, RideStatusViewModelType {
    
    var rideToast: BehaviorRelay<String>
    
    var input: RideStatusViewModelInput { return self }
    
    var output: RideStatusViewModelOutput { return self }
    let disposeBag = DisposeBag()
    
    init() {
        rideToast = BehaviorRelay<String>(value: "")
    }
    
    func getToastMessage(message: String) {
        RideStatusController.shared.getRideStatus(rideType: message)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] response in
    
                guard let self = self,
                      let element = response.element else {
                    return
                }
                
                self.rideToast.accept(element.statusMessage ?? "")
            }.disposed(by: disposeBag)
    }
    
}



