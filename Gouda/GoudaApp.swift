//
//  GoudaApp.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

@main
struct GoudaApp: App {
//  let persistenceManager = PersistenceManager.shared
  
//  @StateObject var cheddarStore = CheddarStore()
//  @StateObject var hopper = Hopper()
  
//  @StateObject var goudaState = GoudaState()
  
  // The actual State object we're using for everything.
  let goudaState = GoudaState()
  
//  @StateObject private var userSettings = UserSettings()

  var body: some Scene {
    WindowGroup {
//      MainScreen(goudaState: goudaState)
//        .environmentObject(self.goudaState)
        
        Home()
    }
  }
}
