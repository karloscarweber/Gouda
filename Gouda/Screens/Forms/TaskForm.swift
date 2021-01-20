//
//  TaskForm.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct TaskForm: View {
  @Binding var task: TaskModel
  var list: ListModel
  
    var body: some View {
      Form {
        Section(header: Text ("What do you need to do?")) {
          TextField("Everything you need to do.", text: $task.text)
        }
      }.onAppear {
        task.list_id = list.id!
      }
    }
}
//
//struct TaskForm_Previews: PreviewProvider {
//    static var previews: some View {
//      TaskForm(task: TaskModel())
//    }
//}
