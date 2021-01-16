//
//  HopperPersistence.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import UIKit
import CoreData

class HopperPersistenceManager {
  
  static let shared = HopperPersistenceManager()
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Gouda")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved erro \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  init() {
    let center = NotificationCenter.default
    let notification = UIApplication.willResignActiveNotification
    
    center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
      guard let self = self else { return }
      
      if self.persistentContainer.viewContext.hasChanges {
        try? self.persistentContainer.viewContext.save()
      }
    }
  }
}
