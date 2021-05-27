//
//  RideStatusController.swift
//  Network
//
//  Created by apple on 2021/05/27.
//

import Foundation
import RxSwift

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
}
