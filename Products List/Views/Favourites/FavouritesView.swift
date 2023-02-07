//
//  FavouritesView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//
import SwiftUI

struct FavouritesView: View{
    @FetchRequest(sortDescriptors: []) var productObjects: FetchedResults<ProductObject>
    @ObservedObject var productState = ProductState()
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        let favourites = productObjects.filter{$0.isFavourite}
        if favourites.count > 0 {
            
            List(favourites, id: \.self) { product in
                Text("\(product.title ?? "")")
                    .onTapGesture {
                        productState.product = product
                        productState.showProduct = true
                    }
            }
            .sheet(isPresented: $productState.showProduct) {
                ProductDetailsView(product: productState.product)
            }
        }else{
            Text("You can add products to your favourites list from product list page")
                .multilineTextAlignment(.center)
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
