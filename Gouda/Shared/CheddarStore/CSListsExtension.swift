//
//  CSListsExtension.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import Foundation
import CoreData
import SwiftUI
import Combine

extension CheddarStore {
  
  func updateOrCreateList(fromModel model: ListModel) {
    if model.id == nil {
      createList(fromModel: model)
    } else {
      updateList(fromModel: model)
    }
    
    try? persistentContainer.viewContext.save()
    
    updateLists()
  }
  
  private func createList(fromModel model: ListModel) {
    let list = CSManagedList(context: persistentContainer.viewContext)
    list.id = UUID()
    list.created_at = now()
    list.updated_at = now()
    
    apply(model: model, to: list)
  }
  
  private func updateList(fromModel model: ListModel) {
    guard let id = model.id else { return }
    
    let request: NSFetchRequest<CSManagedList> = CSManagedList.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
    guard let lists = try? persistentContainer.viewContext.fetch(request),
          let list = lists.first, lists.count == 1 else { return }
    
    apply(model: model, to: list)
  }
  
  private func apply(model: ListModel, to list: CSManagedList) {
    
    list.active_completed_tasks_count = Int64(model.active_completed_tasks_count)
    list.active_tasks_count = Int64(model.active_tasks_count)
    list.active_uncompleted_tasks_count = Int64(model.active_uncompleted_tasks_count)
    list.archived_at = model.archived_at
    list.created_at = model.created_at
//    list.id = model.id
    list.position = Int64(model.position)
//    list.remote_id = model.remote_id ?? Int64(0)
//    list.remote_position = model.remote_position
    list.title = model.title
    list.updated_at = model.updated_at
    list.url = model.url
  }
  
}
