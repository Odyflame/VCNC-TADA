//
//  RideEstimationsViewModel.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/28.
//

import Foundation
import Network
import RxSwift
import RxCocoa

protocol RideEstimationsViewModelOutput {
    var liteEstimation: BehaviorRelay<RideEstimation?> { get }
    var plusEstimation: BehaviorRelay<RideEstimation?> { get }
}

protocol RideEstimationsViewModelInput {
    func getRideEstimations()
    func getRideEstimationsWithCoupon(coupon: String)
}

protocol RideEstimationsViewModelType {
    var input: RideEstimationsViewModelInput { get }
    var output: RideEstimationsViewModelOutput { get }
}

class RideEstimationsViewModel: RideEstimationsViewModelOutput, RideEstimationsViewModelInput, RideEstimationsViewModelType {

    var liteEstimation: BehaviorRelay<RideEstimation?>
    var plusEstimation: BehaviorRelay<RideEstimation?>
    
    var input: RideEstimationsViewModelInput { return self }
    var output: RideEstimationsViewModelOutput { return self }
    
    let disposeBag = DisposeBag()
    
    init() {
        plusEstimation = BehaviorRelay<RideEstimation?>(value: nil)
        liteEstimation = BehaviorRelay<RideEstimation?>(value: nil)
    }
    
    func getRideEstimations() {
        RideEstimationsController.shared.getRideEstimations()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] response in
                guard let self = self,
                      let element = response.element else {
                    
                    return
                }
                
                print("getRideEstimations 된다")
                self.setEstimationValue(value: element.rideEstimations)
                
            }.disposed(by: disposeBag)
    }
    
    func getRideEstimationsWithCoupon(coupon: String) {
        RideEstimationsController.shared.getRideEstimationsWithCoupon(coupon: coupon)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] response in
                guard let self = self,
                      let element = response.element else {
                    
                    return
                }
                
                print("getRideEstimationsWithCoupon 된다")
                self.setEstimationValue(value: element.rideEstimations)
                
            }.disposed(by: disposeBag)
    }
    
    private func setEstimationValue(value: [RideEstimation]) {

        value.forEach {
            switch $0.rideType.value {
            case "LITE": self.liteEstimation.accept($0)
            case "PLUS": self.plusEstimation.accept($0)
            default: break
            }
        }
    }
}
