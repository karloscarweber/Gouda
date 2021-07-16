//
//  PageViewModel.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

class TaskViewModel: ObservableObject {
    
    // Selected tab...
    @Published var selectedTab = "tabs"
    
    @Published var tasks = [
        TaskModelDragNDrop(text: "I have so much to do", color: Color.blue),
        TaskModelDragNDrop(text: "Get more stuff done please", color: Color.red),
        TaskModelDragNDrop(text: "Don't ever give up on your dreams", color: Color.blue),
        TaskModelDragNDrop(text: "I want to go home but, you know what? I won't.", color: Color.orange),
        TaskModelDragNDrop(text: "Clean the kitchen.", color: Color.blue)
    ]

    @Published var currentTask: TaskModelDragNDrop?
}
