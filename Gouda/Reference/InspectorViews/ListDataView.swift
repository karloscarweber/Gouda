//
//  ListDataView.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct ListDataView: View {
    
    var list: ListModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text ("User Visible Data")) {
                Text("Position: \(list.position)")
                Text("Title: \(list.title)")
            }

            Section(header: Text ("Invisible Data")) {
                Text("id: \(list.id?.uuidString ?? "nil")")
                Text("url: \(list.url)")
            }
        }
        
    }
}

//struct ListDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListDataView()
//    }
//}


//var id: UUID?
//var created_at: String
//var updated_at: String
//
//var url: String
//
//// List stuff lists for sure have
//var title: String
//var position: Int
//
//var active_completed_tasks_count: Int
//var active_tasks_count: Int
//var active_uncompleted_tasks_count: Int
//
//var archived_at: String?
//var archived_completed_tasks_count: Int
//var archived_tasks_count: Int
//var archived_uncompleted_tasks_count: Int
