//
//  AllListsView.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct AllListsView: View {
    
    @ObservedObject var goudaState: GoudaState
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        List {
            
          ForEach(goudaState.lists, id: \.id) { list in

            NavigationLink(destination: ListDataView(list: list)) {
              Text("\(list.position) \(list.title)")
            }
 
          }
            
        }
        .listStyle(PlainListStyle())
        .navigationTitle(
          Text("List Data")
        )
    }
}

//struct AllListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllListsView()
//    }
//}
