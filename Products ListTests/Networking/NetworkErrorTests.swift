//
//  NetworkErrorTests.swift
//  Products ListTests
//
//  Created by yacob kazal on 7/2/2023.
//
import XCTest

@testable import Products_List
class NetworkErrorTests: XCTestCase {
    
    func testNetworkErrorcases() {
        XCTAssertEqual(NetworkError.noData, NetworkError.noData)
        XCTAssertEqual(NetworkError.badData, NetworkError.badData)
        XCTAssertEqual(NetworkError.badURL, NetworkError.badURL)
        XCTAssertEqual(NetworkError.unhandledCode("404"), NetworkError.unhandledCode("404"))
        
        XCTAssertNotEqual(NetworkError.noData, NetworkError.badData)
    }
    
}
