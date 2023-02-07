//
//  Products_ListApp.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import SwiftUI

@main
struct Products_ListApp: App {
    @ObservedObject private var persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView{
                ProductsListView(viewModel: ProductsListViewModel(moc: persistenceController.container.viewContext))
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabViewWithNavigationTitle(with: S.Products, systemImage: .listDash)
                FavouritesView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabViewWithNavigationTitle(with: S.Favorites, systemImage: .heart)
            }
        }
    }
}
