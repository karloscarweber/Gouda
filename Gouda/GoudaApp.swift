//
//  GoudaApp.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import GRDB
import SwiftUI

@main
struct GoudaApp: App {
    
    @Environment(\.appDatabase) private var appDatabase
    
//  let persistenceManager = PersistenceManager.shared
  
//  @StateObject var cheddarStore = CheddarStore()
//  @StateObject var hopper = Hopper()
    
//  @StateObject var goudaState = GoudaState()
  
  // The actual State object we're using for everything.
  let goudaState = GoudaState()
  
//  @StateObject private var userSettings = UserSettings()

  var body: some Scene {
    WindowGroup {
      MainScreen(goudaState: goudaState)
        .environmentObject(self.goudaState)
        .environment(\.appDatabase, AppDatabase.shared)
        .environment(\.goudaState, GoudaState.shared)
//        Home()
    }
  }
}


// MARK: - Environment
// The below keys and Environment values allow us to use the app database as an environment variable.

// Let SwiftUI views access the database through the SwiftUI environment
private struct AppDatabaseKey: EnvironmentKey {
    static let defaultValue: AppDatabase? = nil
}
private struct GoudaStateKey: EnvironmentKey {
    static let defaultValue: GoudaState? = nil
}

extension EnvironmentValues {
    var appDatabase: AppDatabase? {
        get { self[AppDatabaseKey.self] }
        set { self[AppDatabaseKey.self] = newValue }
    }
    var goudaState: GoudaState? {
        get { self[GoudaStateKey.self] }
        set { self[GoudaStateKey.self] = newValue }
    }
}
