//
//  CSTasksExtension.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import Foundation
import CoreData
import SwiftUI
import Combine

extension CheddarStore {
  
  func updateOrCreateTask(fromModel model: TaskModel) {
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
  
}
