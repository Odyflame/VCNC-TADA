//
//  RideStatusController.swift
//  Network
//
//  Created by apple on 2021/05/27.
//

import Foundation
import RxSwift
import Moya

public class RideStatusManager {
    public static let shared = RideStatusManager()
    
}

public class RideStatusController {
    public static let shared = RideStatusController()
    private let serviceManger = RideStatusServiceManager()
    
    public func getRideStatus(rideType: String) -> Observable<RideStatus>{
        serviceManger.provider.rx
            .request(RideStatusService.getRideStatus(rideType: rideType))
            .map(RideStatus.self)
            .asObservable()
    }
    
//    public func getRideStatus(rideType: String) -> Observable<Response>{
//        serviceManger.provider.rx
//            .request(RideStatusService.getRideStatus(rideType: rideType))
//            .asObservable()
//    }
}
