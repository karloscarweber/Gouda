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
                            Text("\(list.position) \(list.title)")
                        }
                    }.onMove(perform: move)
                }
                .listStyle(PlainListStyle())
                //              .navigationTitle(
                //                Text("Lists")
                //              )
                .navigationBarItems(trailing: EditButton())
                .sheet(isPresented: $isAddingList) {
                    AddListScreen(goudaState: goudaState)
                }

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
    
    func move(from source: IndexSet, to destination: Int) {
//        users.move(fromOffsets: source, toOffset: destination)
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
      MainScreen(goudaState: GoudaState())
    }
}
