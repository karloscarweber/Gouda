//
//  ListDetailScreen.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct ListDetailScreen: View {
  
//  @ObservedObject var goudaState: GoudaState
  @ObservedObject var listProxy: ListProxy
  
  @State var isEditing = false
  @State var isAddingTask = false
  
  init(listId: UUID, proxy: ListProxy) {
    
    listProxy = proxy
    
//    self.goudaState = gouda
//    if let listData = goudaState.list(for: listId) {
//      print("listIdlistIdlistIdlistIdlistId: \(listId)")
//      list = listData
//      let allTasks = goudaState.tasks(in: list)
//
//      for task in allTasks {
//        print("task")
//      }
//
//      activeTasks = allTasks.filter({ $0.archived_at == nil })
//      for task in activeTasks {
//        print("task")
//      }
//    } else {
//
//      print("for some reason we get no list data")
//
//    }
  }
  
    var body: some View {
      List {
        ForEach(listProxy.tasks, id: \.id) { task in
          Text(task.text)
        }
      }
      .listStyle(PlainListStyle())
      .navigationTitle(
        Text("\(listProxy.list.title)")
      )
      .navigationBarItems(trailing: Button("add task", action: {
          isAddingTask = true
      }))
      .sheet(isPresented: $isAddingTask) {
          AddTaskScreen()
      }
      
    }
}
//
//struct ListDetailScreen_Previews: PreviewProvider {
//
//    static var previews: some View {
//      ListDetailScreen(listId: UUID())
//    }
//}
