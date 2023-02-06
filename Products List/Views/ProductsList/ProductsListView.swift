//
//  ProductsListView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI

struct ProductsListView: View{
    @ObservedObject var productState = ProductState()
    var body: some View {
        List(1..<4, id: \.self) { i in
            Text("Product \(i)")
                .onTapGesture {
                    productState.showProduct = true
                }
        }
        .sheet(isPresented: $productState.showProduct) {
            ProductDetailsView()
        }
    }
}
