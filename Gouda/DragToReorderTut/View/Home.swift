//
//  Home.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import SwiftUI

struct Home: View {
    
    @StateObject var taskData = TaskViewModel()
    // Slide Animation...
    @Namespace var animation
    
    // Coumns...
    let columns = Array(repeating: GridItem(.flexible(), spacing: 15),  count: 1)
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image(systemName: "eyeglasses")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(taskData.selectedTab == "private" ? .black : .white)
                    .frame(width: 80, height: 45)
                    .background(
                        ZStack {
                            if  taskData.selectedTab != "private" {
                                Color.clear
                            }
                            else {
                                Color.white
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            taskData.selectedTab = "private"
                        }
                    }
                
                Text("1")
                    .frame(width: 35, height: 35)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(taskData.selectedTab == "tabs" ? Color.black : Color.white, lineWidth: 3))
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(taskData.selectedTab == "tabs" ? .black : .white)
                    .frame(width: 80, height: 45)
                    .background(
                        ZStack {
                            if  taskData.selectedTab != "tabs" {
                                Color.clear
                            }
                            else {
                                Color.white
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            taskData.selectedTab = "tabs"
                        }
                    }
                
                Image(systemName: "laptopcomputer")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(taskData.selectedTab == "device" ? .black : .white)
                    .frame(width: 80, height: 45)
                    .background(
                        ZStack {
                            if  taskData.selectedTab != "device" {
                                Color.clear
                            }
                            else {
                                Color.white
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            taskData.selectedTab = "device"
                        }
                    }
            }
            .background(Color.white.opacity(0.15))
            .cornerRadius(15)
            .padding(.top)
            
            ScrollView {
                
                // Tabs With Pages....
                
                LazyVGrid(columns: columns, spacing: 0, content: {
                    
                    ForEach(taskData.tasks) { task in
                        
                        FauxTaskView(backgroundColor: task.color, foregroundColor: .white, text: task.text)
                            .onDrag({
                                taskData.currentTask = task
                                return NSItemProvider(contentsOf: URL(string: "\(task.id)")!)! // URL in this case is, well the "url" of the task. which could pretty much be it's ID
                            })
                            .onDrop(of: [.url], delegate: DropViewDelegate(task:task, taskData: taskData))
                    }
                })
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
