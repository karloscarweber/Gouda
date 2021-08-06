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
    @Environment(\.goudaState) private var goudaState
  
  // The actual State object we're using for everything.
//  let goudaState = GoudaState.shared
  
  var body: some Scene {
    WindowGroup {
//      MainScreen()
////        .environmentObject(self.goudaState)
//        .environment(\.appDatabase, AppDatabase.shared)
//        .environment(\.goudaState, GoudaState.shared)
        
        UserView()
            .environment(\.goudaState, GoudaState.shared)
    }
  }
}


// MARK: - Environment
// The below keys and Environment values allow us to use the app database as an environment variable.

// Let SwiftUI views access the database through the SwiftUI environment
private struct AppDatabaseKey: EnvironmentKey {
    static let defaultValue: AppDatabase = AppDatabase.shared
}
private struct GoudaStateKey: EnvironmentKey {
    static let defaultValue: GoudaState = GoudaState.shared
}

extension EnvironmentValues {
    var appDatabase: AppDatabase {
        get { self[AppDatabaseKey.self] }
        set { self[AppDatabaseKey.self] = newValue }
    }
    var goudaState: GoudaState {
        get { self[GoudaStateKey.self] }
        set { self[GoudaStateKey.self] = newValue }
    }
}
