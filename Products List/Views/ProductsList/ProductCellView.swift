//
//  ProductCellView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI

struct ProductCellView: View{
    @ObservedObject var imageLoader: ImageLoader
    @State var product: ProductObject
    init(_ product: ProductObject) {
        self.product = product
        imageLoader = ImageLoader(urlString: product.imageURL)
    }
    var body: some View  {
        HStack{
            
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .frame(width: 44, height: 44)
            Text(product.title ?? "")
                .multilineTextAlignment(.leading)
            Spacer()
            if product.number == 0{
                Button {
                    print("add")
                    operate(.increase)
                } label: {
                    Text("Add")
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(Capsule()
                            .stroke(.black, lineWidth: 1)
                        )
                }.buttonStyle(PlainButtonStyle())
            }else{
                HStack(spacing: 10){
                    Button {
                        print("+")
                        operate(.increase)
                    } label: {
                        Text("+")
                            .foregroundColor(.white)
                    }.buttonStyle(PlainButtonStyle())
                    Text("\(product.number)")
                        .foregroundColor(.white)
                    Button {
                        print("-")
                        operate(.decrease)
                    } label: {
                        Text("-")
                            .foregroundColor(.white)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(Capsule()
                        .foregroundColor(.gray)
                        .shadow(color: .black, radius: 1, x: -1, y: 1))
            }
            
                Button {
                    product.isFavourite.toggle()
                    try? product.managedObjectContext?.save()
                } label: {
                    Image(name: product.isFavourite ? .heartFill : .heart)
                }.buttonStyle(PlainButtonStyle())
                .padding([.leading], 8)
            
        }
    }
    enum Operator {
        case increase, decrease
    }
    func operate(_ op: Operator) {
        switch op {
        case .decrease:
            product.number -= 1
        case .increase:
            product.number += 1
        }
        try? product.managedObjectContext?.save()
    }
    
}
