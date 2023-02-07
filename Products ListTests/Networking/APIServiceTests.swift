//
//  APIServiceTests.swift
//  Products ListTests
//
//  Created by yacob kazal on 7/2/2023.
//

import XCTest
import Combine
@testable import Products_List

class APIServiceTests: XCTestCase {
    private var mockSession: MockURLSession!
    private var cancelables = Set<AnyCancellable>()
    override func setUp() {
    }
    
    override func tearDown() {
        mockSession = nil
        super.tearDown()
    }
    
    func test_fetchProductsTests_200() throws {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "ProductsSesuccessResult", andStatusCode: 200, andError: nil)
        let service = APIService(withSession: mockSession)
        let products = AwaitPublisher(service.fetchProducts())
        let results = try XCTUnwrap( products?.get())
        XCTAssertEqual(results.products.count, 21 )
        XCTAssertEqual(results.products.first?.title,  "Diamond Label Shiraz")
    }
    
    func test_fetchProductsTests_badData() throws {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "badData", andStatusCode: 200, andError: nil)
        APIService(withSession: mockSession).fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    XCTAssertEqual(error, .badData)
                }
            } receiveValue: { response in
                XCTFail("No value should be received")
            }.store(in: &cancelables)
    }
    
    func test_fetchProductsTests_404() throws {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "ProductsSesuccessResult", andStatusCode: 404, andError: nil)
        APIService(withSession: mockSession).fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure (let error):
                    XCTAssertEqual(error, .badURL)
                }
            } receiveValue: { response in
                XCTFail("No value should be received")
            }.store(in: &cancelables)
    }
    
    
    func test_fetchProductsTests_error() throws {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "ProductsSesuccessResult", andStatusCode: 200, andError: NetworkError.noData)
        APIService(withSession: mockSession).fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure (let error):
                    XCTAssertEqual(error, .noData)
                }
            } receiveValue: { response in
                XCTFail("No value should be received")
            }.store(in: &cancelables)
    }
    
    func test_fetchProductsTests_unhandledCode() throws {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "ProductsSesuccessResult", andStatusCode: 500, andError: NetworkError.noData)
        APIService(withSession: mockSession).fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure (let error):
                    XCTAssertEqual(error, .unhandledCode("statusCode: \(500)"))
                }
            } receiveValue: { response in
                XCTFail("No value should be received")
            }.store(in: &cancelables)
    }
}
