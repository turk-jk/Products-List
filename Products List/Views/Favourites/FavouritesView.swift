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
            VStack{
                
                List(favourites, id: \.self) { product in
                    ProductCellView(product)
                        .onTapGesture {
                            productState.product = product
                            productState.showProduct = true
                        }
                }
                .sheet(isPresented: $productState.showProduct) {
                    ProductDetailsView(product: productState.product)
                }
                if productObjects.filter({$0.number > 0}).count > 0{
                    CartView().padding([.bottom], 6)
                }
            }
        }else{
            Text("You can add products to your favourites list from product list page")
                .multilineTextAlignment(.center)
        }
    }
}
