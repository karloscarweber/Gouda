//
//  MainScreen.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct MainScreen: View {
  
//  @EnvironmentObject var goudaState: GoudaState
  @ObservedObject var goudaState: GoudaState
  
  @State var isEditing = false
  @State var isAddingList = false
  
    var body: some View {
      NavigationView {
        ZStack {
          List {
            
            ForEach(goudaState.lists, id: \.id) { list in
              
              NavigationLink(destination: ListDetailScreen(listId: list.id!, proxy: ListProxy(goudaState, withList: list)  ) ) {
                Text("\(list.position) \(list.title)")
              }
            }
            
          }
          .listStyle(PlainListStyle())
          .navigationTitle(
            Text("Lists")
          )
          
          
        }
        // end of ZStack
        
//        VStack {
//          Spacer()
//          Button {
//            isAddingList = true
//          } label: {
//            RoundedButton(title: "New List")
//          }
//        }.padding()
        
      }
//      .environmentObject(goudaState)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
      MainScreen(goudaState: GoudaState())
    }
}
