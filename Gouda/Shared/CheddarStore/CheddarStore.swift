//
//  CheddarStore.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import Foundation
import CoreData
import SwiftUI
import Combine

class CheddarStore: ObservableObject {
  @Published var user: [UserModel]
  @Published var lists: [ListModel]
  @Published var tasks: [TaskModel]
  @Published var tasksInList: [TasksForList]
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CheddarStore")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func setupSavePersistence() {
    let center = NotificationCenter.default
    let notification = UIApplication.willResignActiveNotification
    
    center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
      guard let self = self else { return }
      
      if self.persistentContainer.viewContext.hasChanges {
        try? self.persistentContainer.viewContext.save()
      }
    }
  }
  
  init() {
    self.user = []
    self.lists = []
    self.tasks = []
    self.tasksInList = []
    setupSavePersistence()
  }
  
  private func updateData() {
//    let request: NSFetchRequest
  }
  
}

extension CheddarStore {
  
}
