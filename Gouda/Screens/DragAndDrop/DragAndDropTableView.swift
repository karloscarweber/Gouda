//
//  DragAndDropTableView.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import ASCollectionView
import SwiftUI

struct DragAndDropTableView: View
{
    @State var groupA: [String] = (0 ... 20).map { "Item A-\($0)" }
    @State var groupB: [String] = (0 ... 4).map { "Item B-\($0)" }
    @State var groupC: [String] = (0 ... 4).map { "Item C-\($0)" }
    @State var groupD: [String] = (0 ... 4).map { "Item D-\($0)" }
    
    var body: some View {
        VStack {
            Text("Drag within a tableview to move. \nDrag between tableviews to copy.")
                .padding()
            
            HStack {
                
                ASTableView {
                    ASSection<Int>(
                        id: 0,
                        data: groupA,
                        dataID: \.self,
                        dragDropConfig: ASDragDropConfig(dataBinding: $groupA),
                        onSwipeToDelete: { index, _-> Bool in
                            withAnimation
                            {
                                _ = self.groupA.remove(at: index)
                            }
                            return true
                        })
                    { item, _ in
//                        Text(item)
//                            .padding()
//                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ListRowView(position: 0, title: item)
                        
                    }
                }
            } // End HStack
            
        }
    }
    
    
}
