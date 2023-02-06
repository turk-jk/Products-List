//
//  Products_ListApp.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI

@main
struct Products_ListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView{
                ProductsListView()
                    .tabViewWithNavigationTitle(with: S.Products, systemImage: .listDash)
                FavouritesView()
                    .tabViewWithNavigationTitle(with: S.Favorites, systemImage: .heart)
            }
        }
    }
}
