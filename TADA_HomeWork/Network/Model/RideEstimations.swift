//
//  RideEstimations.swift
//  Network
//
//  Created by apple on 2021/05/27.
//

import Foundation

public class RideEstimations: Codable {
    public let rideEstimations: [RideEstimation]
}

public class RideEstimation: Codable {
    public let rideType: RideType
    public let estimateCost: Int?
}

public class RideType: Codable {
    public let value: String?
    public let image: Image?
    public let name: String?
    public let description: String?
}

public class Image: Codable {
    public let url: String?
    public let width: Int?
    public let height: Int?
}
