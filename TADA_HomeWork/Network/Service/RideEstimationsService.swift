//
//  RideEstimationsService.swift
//  Network
//
//  Created by apple on 2021/05/27.
//

import Foundation
import Moya

enum RideEstimationsService {
    case getRideEstimations
    case getRideEstimationsWithCoupon(coupon: String)
}

extension RideEstimationsService: TargetType {
    var baseURL: URL {
        URL(string: BaseURL.base.rawValue)!
    }
    
    var path: String {
        switch self {
        case .getRideEstimations: return "ListRideEstimations"
        case .getRideEstimationsWithCoupon(_): return "ListRideEstimations"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getRideEstimations: return .get
        case .getRideEstimationsWithCoupon(_): return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getRideEstimations: return .requestPlain
        case .getRideEstimationsWithCoupon(let coupon): return .requestParameters(parameters: ["coupon": coupon], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}

class RideEstimationsServiceManager: BaseManager<RideEstimationsService> { }
