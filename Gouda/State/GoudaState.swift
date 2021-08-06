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
  
    // database layer
    var cheddarStore = CheddarStore()
    // network layer
    var hopper = Hopper()
    
    // new database layer
    var appDatabase = AppDatabase.shared
  
    var cancellables = Set<AnyCancellable>()
    
    //  // published data
    @Published var user: User? // add this when we add logging in.
    @Published var lists: [ListModel] // this is all lists
    @Published var tasks: [TaskModel] // this is a task
    
    // List Proxy Stuff
    @Published var currentTasks: [TaskModel]
    @Published var filteredLists: [UUID: ListModel] = [:] // for storing the filtered lists.
  
  init() {
    self.user = nil
    self.lists = []
    self.tasks = []
    self.currentTasks = []
    
    // This should update our tasks whenever the data is updates
    cheddarStore.$tasks.sink(receiveValue: { updatedTasks in
      self.tasks = updatedTasks
    }).store(in: &cancellables)
    
    cheddarStore.$lists.sink(receiveValue: { updatedLists in
        self.lists = updatedLists
    }).store(in: &cancellables)
   
    // Load the data
    lists = cheddarStore.lists
    tasks = cheddarStore.tasks
    
    // get user from database
    do {
        self.user = try appDatabase.user()
    } catch {
        fatalError("Something went wrong trying to get the User from the database.")
    }
    
  }

}

// User Functions
extension GoudaState {
  
//  func createOrUpdateUser(fromModel model: UserModel) {
//    if model.id == nil {
//      createUser(fromModel: model)
//    } else {
//      updateUser(fromModel: model)
//    }
//  }
//  
//  func createUser(fromModel model: UserModel) {
//    user = model
//  }
//  
//  func updateUser(fromModel model: UserModel) {
//    user = model
//  }
//  
//  func deleteUser() {
//    user = nil
//  }
  
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
    cheddarStore.updateOrCreateList(fromModel: model)
  }
  
  func updateList(fromModel model: ListModel) {
    cheddarStore.updateOrCreateList(fromModel: model)
  }
  
  func deleteList(fromModel model: ListModel) {
    lists = lists.filter ( { $0.id == model.id } )
  }
  
  func sortLists() {
    lists = lists.sorted(by: { $0.position < $1.position })
  }
  
  func reorderLists(from models: [ListModel]) {
    var reorderedModels = models

    var order = Int64(1)
    for index in 0..<reorderedModels.count {
        reorderedModels[index].position = Int(order)
        order += 1
    }
    
    for list in reorderedModels {
        self.createOrUpdateList(fromModel: list)
    }
    
  }
  
}

// Task Functions
extension GoudaState {
  func createOrUpdateTask(fromModel model: TaskModel) {
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
  }
  
  func updateTask(fromModel model: TaskModel) {
    cheddarStore.updateOrCreateTask(fromModel: model)
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
    
    // doesn't really sort them, just returns an ordered list of them instead of un ordered.
    func sortedLists() -> [ListModel] {
      var theLists = lists
      print("*********************************")
      print(theLists)
        theLists = theLists.sorted(by: { $0.position < $1.position })
      return theLists
    }
}


// List Proxy Functions
extension GoudaState {
  
  // sets the current tasks to match a new list
  func setCurrentTasks(toList list: ListModel) {
    self.currentTasks = sortedTasks(in: list)
  }
  
}


// MARK: - Persistence
extension GoudaState {
    static let shared = makeShared()
    
    private static func makeShared() -> GoudaState {
        return GoudaState()
    }
}
