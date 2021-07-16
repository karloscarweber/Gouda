//
//  InspectorView.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct InspectorView: View {
    
    @ObservedObject var goudaState: GoudaState
    
    var body: some View {
        
            List {
  
//                NavigationLink(destination: ListDetailScreen(goudaState, withList: list)) {
//                  Text("\(list.position) \(list.title)")
//                }
                
                if let user = goudaState.user {
                    Text("Username goes here")
                } else {
                    Text("No User")
                }
                
                if goudaState.lists.count > 0 {
                    NavigationLink(destination: AllListsView(goudaState: goudaState)) {
                        Text("\(goudaState.lists.count) Lists")
                    }
                }
                
                if goudaState.tasks.count > 0 {
                    Text("\(goudaState.tasks.count) Tasks")
                }
                
                
//              ForEach(goudaState.lists, id: \.id) { list in
//
//                NavigationLink(destination: ListDetailScreen(goudaState, withList: list)) {
//                  Text("\(list.position) \(list.title)")
//                }
//
//              }
              
            }
            .listStyle(PlainListStyle())
            .navigationTitle(
              Text("Data")
            )
        
    }
}
//
//struct InspectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        InspectorView()
//    }
//}
