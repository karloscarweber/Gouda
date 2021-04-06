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
  
  init(_ gouda: GoudaState, withList aList: ListModel) {
    self.goudaState = gouda
    self._list = State(initialValue: aList)
  }
  
    var body: some View {
      
      ZStack {
      
        // tasks list
        List {
          ForEach(tasksInThisList(), id: \.id) { task in
            Text(task.text)
          }
          .onMove(perform: move)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(
          Text("\(list.title)")
        )
        .navigationBarItems(trailing: EditButton())
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
    
    func move(from source: IndexSet, to destination: Int) {
        var tasks = tasksInThisList()
        tasks.move(fromOffsets: source, toOffset: destination)
        self.goudaState.reorderTasks(from: tasks)
    }
    
    func tasksInThisList() -> [TaskModel] {
        goudaState.sortedTasks(in: list)
    }
    
}
//
//struct ListDetailScreen_Previews: PreviewProvider {
//
//    static var previews: some View {
//      ListDetailScreen(listId: UUID())
//    }
//}
