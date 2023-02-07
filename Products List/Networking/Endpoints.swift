//
//  Endpoints.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//
import Foundation

enum Endpoints {
    case products
    var url: String {
        switch self {
        case .products:
            return "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328"
        }
    }
}
