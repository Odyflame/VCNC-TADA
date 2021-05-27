//
//  RideEstimationController.swift
//  Network
//
//  Created by apple on 2021/05/27.
//

import Foundation
import RxSwift

public class RideEstimationsManager {
    public static let shared = RideEstimationsManager()
    
}

public class RideEstimationsController {
    public static let shared = RideEstimationsController()
    private let serviceManger = RideEstimationsServiceManager()
    
    public func getRideEstimations() -> Observable<RideEstimations>{
        serviceManger.provider.rx
            .request(RideEstimationsService.getRideEstimations)
            .map(RideEstimations.self)
            .asObservable()
    }
    
    public func getRideEstimationsWithCoupon(coupon: String) -> Observable<RideEstimations> {
        serviceManger.provider.rx
            .request(RideEstimationsService.getRideEstimationsWithCoupon(coupon: coupon))
            .map(RideEstimations.self)
            .asObservable()
    }
}
