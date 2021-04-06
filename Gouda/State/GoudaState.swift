//
//  GoudaState.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

/*
 Gouda State is the state machine for this app. The Global, VIEW MODEL, if you will.
 Views and data are added and removed from Gouda State to change the presentation of
 the app. Persistence is achieved between the Cheddar Store, and the Gouda Store.
 Gouda Store persists app specific data, Cheddar Store persists Cheddar data locally.
 */

import UIKit
import SwiftUI
import Combine

class GoudaState: ObservableObject {
  
  var cheddarStore = CheddarStore()
  var hopper = Hopper()
  
  var cancellables = Set<AnyCancellable>()

//  // published data
  @Published var user: UserModel? // add this when we add logging in.
  @Published var lists: [ListModel]
  @Published var tasks: [TaskModel]
  
  // List Proxy Stuff
  @Published var currentTasks: [TaskModel]
  
  
  
  init() {
    self.user = nil
    self.lists = []
    self.tasks = []
    self.currentTasks = []
    
    // This should update our tasks whenever the dat
    cheddarStore.$tasks.sink(receiveValue: { updatedTasks in
      self.tasks = updatedTasks
    }).store(in: &cancellables)
    
    sampleData()
  }
  
  func sampleData() {
    let list_id = UUID(uuidString: "BBFB4E01-AF68-4C8E-BC80-0B22D9581626")
    let list_id_2 = UUID()
    lists.append(ListModel(id: list_id, created_at: "", updated_at: "", url: "", title: "First List", position: 1000, active_completed_tasks_count: 0, active_tasks_count: 0, active_uncompleted_tasks_count: 0, archived_at: nil, archived_completed_tasks_count: 0, archived_tasks_count: 0, archived_uncompleted_tasks_count: 0))
    
    lists.append(ListModel(id: list_id_2, created_at: "", updated_at: "", url: "", title: "Second List", position: 1000, active_completed_tasks_count: 0, active_tasks_count: 0, active_uncompleted_tasks_count: 0, archived_at: nil, archived_completed_tasks_count: 0, archived_tasks_count: 0, archived_uncompleted_tasks_count: 0))
    
//    for list in lists {
//      print(" list_id: \(list.id!)")
//    }
    tasks = cheddarStore.tasks // get the tasks from the store
    
//    tasks.append(contentsOf: [
//      TaskModel(id: UUID(), created_at: "", updated_at: "", url: "", archived_at: nil, completed_at: nil, display_text: "Hello World", text: "Hello World", display_html: "<p>Hello World</p>", list_id: list_id, position: 1),
//
//      TaskModel(id: UUID(), created_at: "", updated_at: "", url: "", archived_at: nil, completed_at: nil, display_text: "I'm really happy to see you.", text: "I'm *really* happy to see you.", display_html: "<p>I'm <em>really</em> happy to see you.</p>", list_id: list_id, position: 2),
//
//      TaskModel(id: UUID(), created_at: "", updated_at: "", url: "", archived_at: nil, completed_at: nil, display_text: "Jim", text: "Jim", display_html: "<p>Jim</p>", list_id: list_id, position: 3),
//
//      TaskModel(id: UUID(), created_at: "", updated_at: "", url: "", archived_at: nil, completed_at: nil, display_text: "Bones", text: "Bones", display_html: "<p>Bones</p>", list_id: list_id, position: 4),
//
//      TaskModel(id: UUID(), created_at: "", updated_at: "", url: "", archived_at: nil, completed_at: nil, display_text: "Sulu", text: "**Sulu**", display_html: "<p><strong>Sulu</strong></p>", list_id: list_id, position: 5),
//
//      TaskModel(id: UUID(), created_at: "", updated_at: "", url: "", archived_at: nil, completed_at: nil, display_text: "Get this to work", text: "Get this to work **work**", display_html: "<p>Get this to <strong>work</strong></p>", list_id: list_id_2, position: 2),
//
//      TaskModel(id: UUID(), created_at: "", updated_at: "", url: "", archived_at: nil, completed_at: nil, display_text: "Move to Portland", text: "**Move to Portland**", display_html: "<p><strong>Move to Portland</strong></p>", list_id: list_id_2, position: 1),
//
//    ])
    
  }

}

// User Functions
extension GoudaState {
  
  func createOrUpdateUser(fromModel model: UserModel) {
    if model.id == nil {
      createUser(fromModel: model)
    } else {
      updateUser(fromModel: model)
    }
  }
  
  func createUser(fromModel model: UserModel) {
    user = model
  }
  
  func updateUser(fromModel model: UserModel) {
    user = model
  }
  
  func deleteUser() {
    user = nil
  }
  
}

// List Functions
extension GoudaState {
  func createOrUpdateList(fromModel model: ListModel) {
    if model.id == nil {
      createList(fromModel: model)
    } else {
      updateList(fromModel: model)
    }
  }
  
  func createList(fromModel model: ListModel) {
    var mutableModel = model
    mutableModel.id = UUID()
    lists.append(mutableModel)
  }
  
  func updateList(fromModel model: ListModel) {
    var filteredLists = lists.filter ( { $0.id == model.id } )
    filteredLists.append(model)
    lists = filteredLists
  }
  
  func deleteList(fromModel model: ListModel) {
    lists = lists.filter ( { $0.id == model.id } )
  }
  
  func sortLists() {
    lists = lists.sorted(by: { $0.position < $1.position })
  }
  
  func reorder(from models: [ListModel]) {
    lists = models
  }
  
}


// Task Functions
extension GoudaState {
  func createOrUpdateTask(fromModel model: TaskModel) {
    
//    print("Create or update task called")
//    print("task: \(model)")
    
    if model.id == nil {
      print("createTask")
      createTask(fromModel: model)
    } else {
      print("updateTask")
      updateTask(fromModel: model)
    }
  }
  
  func createTask(fromModel model: TaskModel) {
    cheddarStore.updateOrCreateTask(fromModel: model)
    
//    var mutableModel = model
//    mutableModel.id = UUID()
//    tasks.append(mutableModel)
  }
  
  func updateTask(fromModel model: TaskModel) {
    cheddarStore.updateOrCreateTask(fromModel: model)
//    var filteredTasks = tasks.filter ( { $0.id == model.id } )
//    filteredTasks.append(model)
//    tasks = filteredTasks
  }
  
  func deleteTask(fromModel model: TaskModel) {
    lists = lists.filter ( { $0.id == model.id } )
  }
  
  func reorderTasks(from models: [TaskModel]) {
    
    var reorderedModels = models
    
    var order = Int64(1)
    for index in 0..<reorderedModels.count {
        reorderedModels[index].position = order
        order += 1
    }
    
    for task in reorderedModels {
        self.createOrUpdateTask(fromModel: task)
    }
    
  }
  
}


/*
 Query Functions
 */
extension GoudaState {
  
  // get list from id
  func list(for id: UUID) -> ListModel? {
    let lis = lists.filter({ $0.id == id })
    if lis.count > 0 {
      return lis.first
    }
    return nil
  }

  // get tasks from a list model
  func tasks(in list: ListModel) -> [TaskModel] {
    return tasks.filter( { $0.list_id == list.id } )
  }

  // doesn't really sort them, just returns an ordered list of them instead of un ordered.
  func sortedTasks(in list: ListModel) -> [TaskModel] {
    var tasksFromList = tasks(in: list)
    print("*********************************")
    print(tasksFromList)
    tasksFromList = tasksFromList.sorted(by: { $0.position < $1.position })
    return tasksFromList
  }
}


// List Proxy Functions
extension GoudaState {
  
  // sets the current tasks to match a new list
  func setCurrentTasks(toList list: ListModel) {
    self.currentTasks = sortedTasks(in: list)
  }
  
}
