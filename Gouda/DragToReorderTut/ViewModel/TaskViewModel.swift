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
        TaskModelDragNDrop(text: "I have so much to do"),
        TaskModelDragNDrop(text: "Get more stuff done please"),
        TaskModelDragNDrop(text: "Don't ever give up on your dreams"),
        TaskModelDragNDrop(text: "I want to go home but, you know what? I won't."),
        TaskModelDragNDrop(text: "Clean the kitchen.")
    ]

    @Published var currentTask: TaskModelDragNDrop?
}
