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
  
  @State var isAddingList = false
  
    var body: some View {
        
        TabView {
          NavigationView {
            ZStack {
                
              List {
                ForEach(goudaState.lists, id: \.id) { list in
                  NavigationLink(destination: ListDetailScreen(goudaState, withList: list)) {
                    ListRowView(position: list.position, title: list.title)
                  }
                }
                .onMove(perform: move)

                
              }
//              .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
//              .environment(\.editMode, .constant(.active) )
              .listStyle(InsetGroupedListStyle())
              .navigationTitle(
                Text("Lists")
              )
              .navigationBarItems(trailing: EditButton())
              .sheet(isPresented: $isAddingList) {
                AddListScreen(goudaState: goudaState)
              }
              // end List
              
              // Add List Button
              VStack {
                Spacer()
                Button( action: {
                  isAddingList = true
                } ) {
                  RoundedButtonView(text: "Add List")
                }
                .padding()
            }
              
          }
        
        }// End NavigationView 1
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }
          
        NavigationView {
          InspectorView(goudaState: goudaState)
        } // End Navigation View 2
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Inspector")
        }

    }// End TabView
      
      
    }
  
    func move(from source: IndexSet, to destination: Int) {
//        users.move(fromOffsets: source, toOffset: destination)
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
      MainScreen(goudaState: GoudaState())
    }
}
