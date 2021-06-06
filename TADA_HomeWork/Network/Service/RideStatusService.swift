//
//  RideStatusService.swift
//  Network
//
//  Created by apple on 2021/05/27.
//

import Foundation
import Moya
import Alamofire

enum RideStatusService {
    case getRideStatus(rideType: String)
}

extension RideStatusService: TargetType {
    var baseURL: URL {
        URL(string: BaseURL.base.rawValue)!
    }
    
    var path: String {
        switch self {
        case .getRideStatus: return "RideStatus"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getRideStatus: return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getRideStatus(let rideType): return .requestParameters(parameters: ["rideType": rideType], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}

class RideStatusServiceManager: BaseManager<RideStatusService> { }
