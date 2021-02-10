//
//  AddListScreen.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct AddListScreen: View {
  @ObservedObject var goudaState: GoudaState
  
  @State private var list = ListModel.emptyList()
  
  @Environment(\.presentationMode) private var presentationMode
  
  init(goudaState gouda: GoudaState) {
    goudaState = gouda
  }

  var body: some View {
    NavigationView {
      
      ListForm(list: $list)
        .navigationTitle("New List")
        .navigationBarItems(leading: Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }, trailing: Button("Save") {
          goudaState.createOrUpdateList(fromModel: list)
          presentationMode.wrappedValue.dismiss()
        })
      
    }
  }
}

//struct AddListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddListScreen()
//    }
//}
