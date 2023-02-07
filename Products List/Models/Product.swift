//
//  Product.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import Foundation
struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: CodableEquatable{
    let title: String
    let id: String
    let imageURL: String
    let price: [Price]
    let ratingCount: Double
}

struct Price: CodableEquatable{
    let value: Double
    let isOfferPrice: Bool
}
