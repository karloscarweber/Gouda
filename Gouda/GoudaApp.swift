//
//  GoudaApp.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

@main
struct GoudaApp: App {
    let persistenceManager = PersistenceManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceManager.persistentContainer.viewContext)
        }
    }
}
