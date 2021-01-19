//
//  ListModel.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import Foundation

struct ListModel: Hashable, Codable, Identifiable {
  static func == (lhs: ListModel, rhs: ListModel) -> Bool {
    if lhs.id == rhs.id &&
      lhs.created_at == rhs.created_at &&
      lhs.updated_at == rhs.updated_at &&
      lhs.url == rhs.url &&
      lhs.title == rhs.title &&
      lhs.position == rhs.position &&
      lhs.active_completed_tasks_count == rhs.active_completed_tasks_count &&
      lhs.active_tasks_count == rhs.active_tasks_count &&
      lhs.active_uncompleted_tasks_count == rhs.active_uncompleted_tasks_count &&
      lhs.archived_at == rhs.archived_at &&
      lhs.archived_completed_tasks_count == rhs.archived_completed_tasks_count &&
      lhs.archived_tasks_count == rhs.archived_tasks_count &&
      lhs.archived_uncompleted_tasks_count == rhs.archived_uncompleted_tasks_count {
     return true
    }
    return false
  }
  
  var id: UUID?
  var created_at: String
  var updated_at: String
  
  var url: String
  
  // List stuff lists for sure have
  var title: String
  var position: Int
  
  var active_completed_tasks_count: Int
  var active_tasks_count: Int
  var active_uncompleted_tasks_count: Int
  
  var archived_at: String?
  var archived_completed_tasks_count: Int
  var archived_tasks_count: Int
  var archived_uncompleted_tasks_count: Int
  
//}
//
//extension GoudaState {
  
  // creates a nil empty list to be edited and changed and stuff
  static func emptyList() -> ListModel {
    return ListModel(id: nil, created_at: "", updated_at: "", url: "", title: "", position: 1000, active_completed_tasks_count: 0, active_tasks_count: 0, active_uncompleted_tasks_count: 0, archived_at: nil, archived_completed_tasks_count: 0, archived_tasks_count: 0, archived_uncompleted_tasks_count: 0)
  }
}
