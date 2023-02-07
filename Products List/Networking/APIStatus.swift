//
//  APIStatus.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import Foundation

enum APIStatus<T: CodableEquatable> : Equatable{
    case start
    case loading
    case success
    case failure(error: String)
}
