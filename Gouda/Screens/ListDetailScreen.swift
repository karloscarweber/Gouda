//
//  ListDetailScreen.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct ListDetailScreen: View {
  
  @ObservedObject var goudaState: GoudaState
  @State private var list: ListModel
  @State private var isAddingTask = false
  @State var isEditing = false
  
  init(_ gouda: GoudaState, withList aList: ListModel) {
    self.goudaState = gouda
    self._list = State(initialValue: aList)
  }
  
    var body: some View {
      
      ZStack {
      
        // tasks list
        List {
          ForEach(goudaState.sortedTasks(in: list), id: \.id) { task in
            Text(task.text)
          }
        }
//        .listStyle(PlainListStyle())
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(
          Text("\(list.title)")
        )
        .navigationBarItems(trailing: Button("add task", action: {
            isAddingTask = true
        }))
        .sheet(isPresented: $isAddingTask) {
          AddTaskScreen(goudaState: goudaState, list: list)
        }
      
        // Add Task Button
        VStack {
          Spacer()
          Button( action: {
            isAddingTask = true
          } ) {
            RoundedButtonView(text: "Add Task")
          }
          .padding()
          
        }
      
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
