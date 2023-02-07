//
//  ProductsListViewModelTests.swift
//  Products ListTests
//
//  Created by yacob kazal on 7/2/2023.
//

import XCTest
import Combine
@testable import Products_List

class ProductsListViewModelTests: XCTestCase {
    private var mockSession: MockURLSession!
    private var viewModel: ProductsListViewModel!
    private var cancelables = Set<AnyCancellable>()
    override func setUp() {
    }
    
    override func tearDown() {
        mockSession = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_fetchProducts_200() throws {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "ProductsSesuccessResult", andStatusCode: 200, andError: nil)
        viewModel = ProductsListViewModel(withSession: mockSession, moc: PersistenceController.preview.container.viewContext)
        let exp = expectation(description: "Test after 1 seconds")
        XCTAssertEqual(viewModel.currentState, .start)
        viewModel.fetchProducts()
        let result = XCTWaiter.wait(for: [exp], timeout: 1)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.currentState, .success)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_fetchProducts_404() throws {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "ProductsSesuccessResult", andStatusCode: 404, andError: nil)
        viewModel = ProductsListViewModel(withSession: mockSession, moc: PersistenceController.preview.container.viewContext)
        let exp = expectation(description: "Test after 1 seconds")
        XCTAssertEqual(viewModel.currentState, .start)
        viewModel.fetchProducts()
        let result = XCTWaiter.wait(for: [exp], timeout: 1)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.currentState, .failure(error: "The operation couldn’t be completed. (Products_List.NetworkError error 4.)"))
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
