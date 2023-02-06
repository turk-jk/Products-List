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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
