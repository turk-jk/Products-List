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
}
