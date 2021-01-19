//
//  CSUserExtension.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import Foundation
import CoreData
import SwiftUI
import Combine

extension CheddarStore {
//  func updateOrCreateTask(fromModel model: TaskModel) {} // just chooses createTask() or updateTask()
//  func delete(_ model: TaskModel) {}
//  func createCompletion(for task: Binding<TaskModel>) {}
  
//  private func createTask(fromModel model: TaskModel) {}
//  private func updateTask(fromModel model: TaskModel) {}
//  private func apply(model: TaskModel, to task: ManagedTask) {}
//  private func updateTasks() {}
//  private func managedTask(for task: TaskModel) -> ManagedTask? {}

  func updateOrCreateUser(fromModel model: UserModel) {
    if model.id == nil {
      createUser(fromModel: model)
    } else {
      updateUser(fromModel: model)
    }
    
    persistentContainer.viewContext.saveOrRollback()
  }
  
  func delete(_ model: UserModel) {
    guard let id = model.id else { return }
    
    let request: NSFetchRequest<NSFetchRequestResult> = CSManagedUser.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    
    _ = try! persistentContainer.viewContext.execute(deleteRequest)
    persistentContainer.viewContext.saveOrRollback()
  }
  
  func createUser(fromModel model: UserModel) {
    let user = CSManagedUser(context: persistentContainer.viewContext)
    user.id = UUID()
    
    apply(model: model, to: user)
  }
  
  func updateUser(fromModel model: UserModel) {}
  
  func apply(model: UserModel, to user: CSManagedUser) {
    user.username = model.username
    
    user.id = model.id
    user.remote_id = model.remote_id
    user.created_at = model.created_at
    user.updated_at = model.updated_at
    user.url = model.url
    user.has_plus = model.has_plus
    
  }
  
}
