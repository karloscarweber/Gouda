//
//  TaskModel.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import Foundation

struct TaskModel: Hashable, Codable, Identifiable {
  static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
    if lhs.id == rhs.id &&
      lhs.created_at == rhs.created_at &&
      lhs.updated_at == rhs.updated_at &&
      lhs.url == rhs.url &&
        
      lhs.archived_at == rhs.archived_at &&
      lhs.completed_at == rhs.completed_at &&
      lhs.display_text == rhs.display_text &&
      lhs.display_html == rhs.display_html &&
      lhs.text == rhs.text &&
      lhs.list_id == rhs.list_id &&
      lhs.position == rhs.position {
     return true
    }
    return false
  }
  
  var id: UUID?
  var created_at: String
  var updated_at: String
  
  var url: String
  
  // Task stuff tasks for sure have
  var archived_at: String?
  var completed_at: String?
  
  var display_text: String
  var text: String
  var display_html: String
  
  var list_id: UUID
  var position: Int
}

// a lightweight struct for putting the tasks associated with a list into an array
struct TasksForList {
    var list_id = UUID()
    var tasks = [TaskModel]()
}
