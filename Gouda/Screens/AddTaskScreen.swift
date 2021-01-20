//
//  AddTaskScreen.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct AddTaskScreen: View {
  @ObservedObject var goudaState: GoudaState
  
  @State private var task = TaskModel.emptyTask()
  var list: ListModel
  
  @Environment(\.presentationMode) private var presentationMode
  
  init(goudaState gouda: GoudaState, list theList: ListModel) {
    goudaState = gouda
    list = theList
//    task.list_id = list.id!
    print("current Task: \(_task)")
//    task.list_id = list.id!
  }

  var body: some View {
    NavigationView {
      
      TaskForm(task: $task, list: list)
        .navigationTitle("New Task")
        .navigationBarItems(leading: Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }, trailing: Button("Save") {
          goudaState.createOrUpdateTask(fromModel: task)
          presentationMode.wrappedValue.dismiss()
        })
      
    }
  }
}

//struct AddTaskScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskScreen()
//    }
//}
