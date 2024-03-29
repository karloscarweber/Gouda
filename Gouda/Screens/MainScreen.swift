//
//  MainScreen.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct MainScreen: View {
  
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.goudaState) private var goudaState
  
  @State var isAddingList = false
  
    var body: some View {
        
        TabView {
              NavigationView {
                ZStack {
                    
                  List {
                    ForEach(activeLists(), id: \.id) { list in
                      NavigationLink(destination: SequenceComposeView()) {
                        ListRowView(position: list.position, title: list.title)
                      }
                    }
                    .onMove(perform: move)
                  }
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
        var stateLists = goudaState.lists
        stateLists.move(fromOffsets: source, toOffset: destination)
        self.goudaState.reorderLists(from: stateLists)
    }
    
    func activeLists() -> [ListModel] {
        goudaState.sortedLists()
    }
    
}

struct MainScreen_Previews: PreviewProvider {
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.goudaState) private var goudaState
    
    static var previews: some View {
      MainScreen()
        .environment(\.appDatabase, AppDatabase.shared)
        .environment(\.goudaState, GoudaState.shared)
    }
}
