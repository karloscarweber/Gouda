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
                lhs.remote_id == rhs.remote_id &&
                lhs.title == rhs.title &&
                lhs.position == rhs.position &&
                lhs.active_completed_tasks_count == rhs.active_completed_tasks_count &&
                lhs.active_tasks_count == rhs.active_tasks_count &&
                lhs.active_uncompleted_tasks_count == rhs.active_uncompleted_tasks_count &&
                lhs.archived_at == rhs.archived_at {
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
  
    // probably unneccessary.
    var active_completed_tasks_count: Int
    var active_uncompleted_tasks_count: Int
    var active_tasks_count: Int

    var archived_at: String?
    
    var remote_id: Int?
    
    // these are not stored in core data
//    var archived_completed_tasks_count: Int
//    var archived_tasks_count: Int
//    var archived_uncompleted_tasks_count: Int
    
  // creates a nil empty list to be edited and changed and stuff
    static func emptyList() -> ListModel {
        return ListModel(id: nil, created_at: "", updated_at: "", url: "", title: "", position: 1000, active_completed_tasks_count: 0, active_uncompleted_tasks_count: 0, active_tasks_count: 0, archived_at: nil, remote_id: 0)
    }
}

extension ListModel {
  init(list: CSManagedList) {
    id = list.id
    
    print("\(list)")
    created_at = list.created_at!
    updated_at = list.updated_at!
    
    url = list.url!
    
    title = list.title!
    position = Int(list.position)
    
    active_completed_tasks_count = Int(list.active_completed_tasks_count)
    active_uncompleted_tasks_count = Int(list.active_uncompleted_tasks_count)
    active_tasks_count = Int(list.active_tasks_count)
    
    archived_at = list.archived_at
    
    // unexpectedly found nil
//    display_html = ""
  }
}
