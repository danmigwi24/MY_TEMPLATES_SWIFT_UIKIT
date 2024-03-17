//
//  TaskRealmViewModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/03/2024.
//

import Foundation
import RealmSwift

class TaskRealmViewModel: ObservableObject {
    private var realmConfiguration = Realm.Configuration(schemaVersion: 1)
    private var realm = try! Realm()
    
    //@Published var tasks: Results<TaskRealmModel> = try! Realm().objects(TaskRealmModel.self)
    @Published var tasks: [TaskRealmModel] = []
    
    
    init(){
        do{
            self.realm = try Realm(configuration: self.realmConfiguration)
            print("SUCCESS FULLY LOADED REALM DB")
        }catch{
            print("Error laod ream db: \(error.localizedDescription)")
        }
        
        getAllTaskRealm()
    }
    
    
    // MARK: - CRUD Operations
    
    func addTask(title: String, details: String?) {
        do {
            try realm.write {
                let task = TaskRealmModel()
                task.title = title
                task.details = details
                realm.add(task)
                getAllTaskRealm()
            }
        } catch {
            print("Error adding task: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(task: TaskRealmModel) {
        do {
            try realm.write {
                realm.delete(task)
                getAllTaskRealm()
            }
        } catch {
            print("Error deleting task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(task: TaskRealmModel, title: String, details: String?) {
        do {
            try realm.write {
                task.title = title
                task.details = details
            }
        } catch {
            print("Error updating task: \(error.localizedDescription)")
        }
    }
    
    func getAllTasks() -> Results<TaskRealmModel> {
        return realm.objects(TaskRealmModel.self)
    }
    
    func getAllTaskRealm()  {
        for task in realm.objects(TaskRealmModel.self) {
            tasks.append(task)
        }
    }
    
    
    func clearAllTasks() {
        do {
            try realm.write {
                realm.delete(realm.objects(TaskRealmModel.self))
            }
        } catch {
            print("Error clearing tasks: \(error.localizedDescription)")
        }
    }
    
    
    func clearAllDataFromReam() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error clearing tasks: \(error.localizedDescription)")
        }
    }
}

