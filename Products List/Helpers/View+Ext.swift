//
//  View+Ext.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI

extension View {
    func tabViewWithNavigationTitle(with label: String, systemImage: ImageName) -> some View {
        NavigationView{
            self.navigationBarTitle(label)
        }.tabItem {
            Label(label, systemImage: systemImage.rawValue)
        }
    }
    
    func flipRotate(_ degrees : Double) -> some View {
        return rotation3DEffect(Angle(degrees: degrees), axis: (x: 0, y: 1, z: 0.0))
    }
    
    func placedOnCard(_ color: Color) -> some View {
        return padding(5)
            .frame(width: 250, height: 150, alignment: .center)
            .background(color)
    }
}
