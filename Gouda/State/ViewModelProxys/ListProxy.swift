//
//  ListProxy.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import Foundation
import UIKit
import CoreData
import SwiftUI


class ListProxy: ObservableObject {

  @ObservedObject var goudaState: GoudaState
  
//  // published data
//  @Published var user: UserModel? // add this when we add logging in.
  @Published var list: ListModel
  @Published var tasks: [TaskModel]
  
  init(_ gouda: GoudaState , withList theList: ListModel) {
    self.goudaState = gouda // add the global state
    self.list = theList
    self.tasks = [TaskModel]()
    
    updateTasks()
    
    print("list_id: \(list.id!)")
    if tasks.count > 0 {
      print("task_parent_list_id: \(tasks.first!.list_id)")
    }
    
    
  }
  
  func updateTasks() {
    tasks = goudaState.sortedTasks(in: list)
  }
  
}
