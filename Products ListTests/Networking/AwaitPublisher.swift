//
//  AwaitPublisher.swift
//  Products ListTests
//
//  Created by yacob kazal on 7/2/2023.
//

import XCTest
import Combine

extension XCTestCase {
    func AwaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10) -> Result<T.Output, Error>? {
            var result: Result<T.Output, Error>?
            let expectation = self.expectation(description: "Awaiting publisher")
            let cancellable = publisher.sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        result = .failure(error)
                    case .finished:
                        break
                    }
                    expectation.fulfill()
                },
                receiveValue: { value in
                    result = .success(value)
                }
            )
            waitForExpectations(timeout: timeout)
            cancellable.cancel()
            return result
        }
}
