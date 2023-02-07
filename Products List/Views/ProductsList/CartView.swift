//
//  CartView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI
import CoreData

struct CartView: View {
    @FetchRequest(sortDescriptors: []) var productObjects: FetchedResults<ProductObject>
    var body: some View {
        VStack{
            Divider()
            HStack (spacing: 16){
                Button {
                    print("did tap View Cart")
                } label: {
                    Text(S.ViewCart)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                .background(Capsule().foregroundColor(.blue))
                    .buttonStyle(PlainButtonStyle())
                Image(name: .cart).flipRotate(180)
                    .font(.system(size: 40)).overlay(BadgeView())

            }
        }
    }
}
