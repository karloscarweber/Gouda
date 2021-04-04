//
//  ListForm.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct ListForm: View {
  @Binding var list: ListModel
  
    var body: some View {
        
        Form {
            Section(header: Text ("What's yoru project?")) {
                TextField("Name your project.", text: $list.title)
            }
        }
        
    }
}

//struct ListForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ListForm()
//    }
//}
