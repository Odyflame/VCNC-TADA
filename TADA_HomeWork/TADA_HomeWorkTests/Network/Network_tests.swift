//
//  Network_testss.swift
//  TADA_HomeWorkTests
//
//  Created by apple on 2021/06/08.
//

import XCTest
@testable import Network

class Network_tests: XCTestCase {

    func test_getRideStatus() {
        let plus = "플러스"
        RideStatusController.shared.getRideStatus(rideType: plus)
    }
}
