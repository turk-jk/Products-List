//
//  ProductDetailsView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//
import SwiftUI
import CoreData

struct ProductDetailsView: View {
    let product: ProductObject
    @ObservedObject var imageLoader: ImageLoader
    init(_ product: ProductObject) {
        self.product = product
        imageLoader = ImageLoader(urlString: product.imageURL)
    }

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button {
                    product.isFavourite.toggle()
                    try? product.managedObjectContext?.save()
                } label: {
                    Image(name: product.isFavourite ? .heartFill : .heart)
                }.buttonStyle(PlainButtonStyle())
                    .padding([.leading], 8)
            }
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width:300, height:300)
            
            Text(product.title ?? "")
                .bold()
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            HStack{
                Text("Price: $ \(String(format: "%.2f", product.price))")
                    .font(.headline)
                
                Spacer()
            }.padding([.top],8)
            
            HStack{
                Text("Ratings:  \(String(format: "%.1f", product.ratingCount))")
                    .font(.headline)
                
                Spacer()
            }
            
            Spacer()
        }.padding(32)
    }
}
