//
//  DropViewDelegate.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

// Drop Delegate Functions
struct DropViewDelegate: DropDelegate {
    
    var task: TaskModelDragNDrop
    var taskData: TaskViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        
         return true
    }
    
    func dropEntered(info: DropInfo) {
        
        
        let fromIndex = taskData.tasks.firstIndex { (task) -> Bool in
            return task.id == taskData.currentTask?.id
        } ?? 0
        
        let toIndex = taskData.tasks.firstIndex { (task) -> Bool in
            return task.id == self.task.id
        } ?? 0
        
        // check if same
        if fromIndex != toIndex {
            
            withAnimation(.default) {
                let fromPage = taskData.tasks[fromIndex]
                taskData.tasks[fromIndex] = taskData.tasks[toIndex]
                taskData.tasks[toIndex] = fromPage
            }
            
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}
