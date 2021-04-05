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
  }
  
  private func updateData() {
//    let request: NSFetchRequest
  }
  
}

extension CheddarStore {
  
  func updateOrCreateTask(fromModel model: TaskModel) {
    print("creating a task in the store!")
    if model.id == nil {
      createTask(fromModel: model)
    } else {
      updateTask(fromModel: model)
    }
    
    try? persistentContainer.viewContext.save()
    
    updateTasks()
  }
  
  private func createTask(fromModel model: TaskModel) {
    let task = CSManagedTask(context: persistentContainer.viewContext)
    task.id = UUID()
    
    apply(model: model, to: task)
  }
  
  private func updateTask(fromModel model: TaskModel) {
    guard let id = model.id else { return }
    
    let request: NSFetchRequest<CSManagedTask> = CSManagedTask.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
    guard let tasks = try? persistentContainer.viewContext.fetch(request),
          let task = tasks.first, tasks.count == 1 else { return }
    
    apply(model: model, to: task)
  }
  
  private func apply(model: TaskModel, to task: CSManagedTask) {
    
    print("are we getting this id: \(model.id) or this id: \(task.id)")
    task.display_text = model.display_text
    task.archived_at = model.archived_at
    task.created_at = model.created_at
    task.completed_at = model.completed_at
    task.archived_at = model.archived_at
    task.list_id = model.list_id
    task.position = model.position
    task.text = model.text
    task.updated_at = model.updated_at
    task.url = model.url
  }
  
  private func updateTasks() {
    print("updating tasks!")
    let request: NSFetchRequest<CSManagedTask> = CSManagedTask.fetchRequest()
    tasks = try! persistentContainer.viewContext.fetch(request).map(TaskModel.init)
    
    print("tasks:\(tasks)")
  }
  
}
