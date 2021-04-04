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
        
        TabView {
            
        
          NavigationView {
            ZStack {
              List {
                
                ForEach(goudaState.lists, id: \.id) { list in
                  
                  NavigationLink(destination: ListDetailScreen(goudaState, withList: list)) {
                    Text("\(list.position) \(list.title)")
                  }
                  
                }
                
              }
              .listStyle(PlainListStyle())
              .navigationTitle(
                Text("Lists")
              )
              .navigationBarItems(trailing: Button("add list", action: {
                isAddingList = true
              }))
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
          } // End NavigationView 1
          .tabItem {
            Image(systemName: "house.fill")
            Text("Home")
          }
            
            NavigationView {
                InspectorView(goudaState: goudaState)
            }
            .tabItem {
              Image(systemName: "magnifyingglass")
              Text("Inspector")
            }
        
        } // End TabView

        
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
      MainScreen(goudaState: GoudaState())
    }
}
