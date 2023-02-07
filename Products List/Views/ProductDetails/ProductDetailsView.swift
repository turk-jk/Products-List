//
//  ProductDetailsView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//
import SwiftUI

struct ProductDetailsView: View{
    let product: ProductObject?
    var body: some View {
        Text("\(product?.title ?? "none")")
    }
}
