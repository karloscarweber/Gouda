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
  
//  @Published var tasksInList: [TasksForList]
  
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
    setupSavePersistence()
    
    updateTasks()
    updateLists()
  }
  
    private func updateData() {
        //    let request: NSFetchRequest
    }
    
    internal func updateTasks() {
        let request: NSFetchRequest<CSManagedTask> = CSManagedTask.fetchRequest()
        tasks = try! persistentContainer.viewContext.fetch(request).map(TaskModel.init)
    }
    
    internal func updateLists() {
        let request: NSFetchRequest<CSManagedList> = CSManagedList.fetchRequest()
        lists = try! persistentContainer.viewContext.fetch(request).map(ListModel.init)
    }
    
    // Internal properties
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // standard ISO 8601
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
  
}

// Date utilities
extension CheddarStore {
    
    func now() -> String {
        return dateFormatter.string(from: Date())
    }
    
    // A way to return a date from a string
    func dateFromString(_ dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }
    
}
