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
        case .getRideStatus(let rideType): return .requestParameters(parameters: ["rideType": rideType], encoding: JsonEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}

class RideStatusServiceManager: BaseManager<RideStatusService> { }

/// Json encoding을 위해서 아래의 인코딩을 사용할것
struct JsonEncoding: Moya.ParameterEncoding {

    public static var `default`: JsonEncoding { return JsonEncoding() }


    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `AFError.parameterEncodingFailed` error if encoding fails.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var req = try urlRequest.asURLRequest()
        let json = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = json
        return req
    }

}
