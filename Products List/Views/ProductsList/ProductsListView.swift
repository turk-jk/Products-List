//
//  ProductsListView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI

struct ProductsListView: View{
    @ObservedObject var viewModel = ProductsListViewModel()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var productObjects: FetchedResults<ProductObject>
    @ObservedObject var productState = ProductState()
    var body: some View {
        switch viewModel.currentState{
        case .start:
            Color.black.opacity(0.05)
                .ignoresSafeArea()
                .onAppear{
                    viewModel.fetchProducts()
                }
        case .loading:
            loaderView()
        case .success:
            List(productObjects, id: \.self) { product in
                Text("\(product.title ?? "")")
                    .onTapGesture {
                        productState.product = product
                        productState.showProduct = true
                    }
            }
            .sheet(isPresented: $productState.showProduct) {
                ProductDetailsView(product: productState.product)
            }
                
        case .failure(let error):
            VStack(alignment: .center) {
                Spacer()
                Text(error)
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
        }
    }
    
    func loaderView() -> some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
    }
}
