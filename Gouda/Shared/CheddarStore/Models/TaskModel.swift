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
  
  var list_id: UUID?
  var position: Int64
}

extension TaskModel {
  static func emptyTask() -> TaskModel {
    return TaskModel(id: nil,
                     created_at: "",
                     updated_at: "",
                     url: "",
                     archived_at: nil,
                     completed_at: nil,
                     display_text: "",
                     text: "",
                     display_html: "",
                     list_id: nil,
                     position: 1000)
  }
}


extension TaskModel {
  init(task: CSManagedTask) {
    id = task.id
    archived_at = task.archived_at
    created_at = task.created_at!
    updated_at = task.updated_at!
    url = task.url!
    completed_at = task.completed_at
    display_text = task.display_text!
    text = task.text!
    list_id = task.list_id
    position = task.position
    
    // unexpectedly found nil
    display_html = ""
  }
}
