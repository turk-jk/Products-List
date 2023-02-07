//
//  BadgeView.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI
import CoreData

struct BadgeView : View {
    @FetchRequest(sortDescriptors: []) var productObjects: FetchedResults<ProductObject>
    var body: some View {
        ZStack {
            Capsule().fill(Color.red).frame(width: 15 * CGFloat(numOfDigits()), height: 20, alignment: .topTrailing).position(point)
            Text("\(number())")
                .foregroundColor(Color.white)
                .font(Font.system(size: 10).bold()).position(point)
        }
    }
    func numOfDigits() -> Float {
        let numOfDigits = Float(String(number()).count)
        return numOfDigits == 1 ? 1.5 : numOfDigits
    }
    var point: CGPoint{
        CGPoint(x: 22, y: 10)
    }
    func number() -> Int {
        productObjects
            .map{Int($0.number)}
            .reduce(0, +)
    }
}

