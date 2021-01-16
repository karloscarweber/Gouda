//
//  GoudaApp.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

@main
struct GoudaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
