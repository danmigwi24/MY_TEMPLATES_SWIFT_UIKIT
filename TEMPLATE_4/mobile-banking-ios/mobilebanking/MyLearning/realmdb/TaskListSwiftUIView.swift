//
//  TaskListSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/03/2024.
//

import SwiftUI

struct TaskListSwiftUIView: View {
    @ObservedObject var viewModel: TaskRealmViewModel = TaskRealmViewModel()
    @State private var newTaskTitle = ""
    @State private var newTaskDetails = ""
    
    var body: some View {
        List {
            Section(header: Text("Add New Task")) {
                TextField("Enter title", text: $newTaskTitle)
                TextField("Enter details", text: $newTaskDetails)
            }
            
            ForEach(viewModel.tasks) { task in
                TaskRowView(task: task, viewModel: viewModel)
            }
            .onDelete(perform: deleteTask)
            
            
        }
        .navigationTitle("Tasks")
        .navigationBarItems(trailing: addButton)
        
    }
    
    private var addButton: some View {
        HStack{
            Button(action: addTask) {
                Image(systemName: "plus")
            }
            Button(action: {
                clearAllTasks()
            }) {
                Image(systemName: "clear")
            }
        }
    }
    
    private func addTask() {
        if newTaskTitle != "" && newTaskDetails != ""{
            viewModel.addTask(title: newTaskTitle, details: newTaskDetails)
            // Clear input fields after adding task
            newTaskTitle = ""
            newTaskDetails = ""
        }else{
            CustomAlertDailog(title: "", message: "Name and Task detail required", primaryText: "Okay") {
                
            }
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        guard let taskIndex = offsets.first else {
            print("Failed to delete task")
            return
        }
        viewModel.deleteTask(task: viewModel.tasks[taskIndex])
    }
    
    private func clearAllTasks() {
           viewModel.clearAllTasks()
       }
}


struct TaskRowView: View {
    let task: TaskRealmModel
    let viewModel: TaskRealmViewModel
    
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Button(action: {
                viewModel.deleteTask(task: task)
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}

