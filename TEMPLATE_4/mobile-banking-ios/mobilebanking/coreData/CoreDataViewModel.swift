//
//  CoreDataViewModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 24/02/2024.
//

import Foundation
import SwiftUI
import CoreData


public class CoreDataViewModel:ObservableObject{
    
    public let container:NSPersistentContainer
    @Published public var savedUsersEntities:[UsersDataEntity] = []
    @Published public var savedNewOnboardEntities:[NewOnboardEntity] = []
    
    public init(){
        container = NSPersistentContainer(name: "MBContainer")
        container.loadPersistentStores { nSPersistentStoreDescription, error in
            if let error = error {
                print("ERROR LOADING COREDATA \(error)")
            }else{
                print("SUCCESS LOADING COREDATA")
            }
        }
        //
        fetchUser()
    }
    
    //
    public  func saveData(){
        do{
         try container.viewContext.save()
            fetchUser()
        }catch let error{
            print("Error  \(error)")
        }
    }
    
    //
    public func fetchUser() {
       // let fetchRequest = NSFetchRequest<UsersDataEntity>(entityName: "UsersDataEntity")
        let fetchRequest: NSFetchRequest<UsersDataEntity> = UsersDataEntity.fetchRequest()
        do{
        savedUsersEntities = try container.viewContext.fetch(fetchRequest)
        }catch let error{
            print("Error  \(error)")
        }
    }
    
    //
    public func addUser(text:String) {
        let newUser = UsersDataEntity(context: container.viewContext)
        newUser.name = text
        saveData()
    }
    
    //
    public func deleteUser(indexSet:IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedUsersEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    //
    public func updateUser(userEntity:UsersDataEntity){
        let currentName = userEntity.name ?? ""
        let newName = currentName + "*Updated"
        userEntity.name = newName
        saveData()
    }
    
    public func updateUser2(userEntity:UsersDataEntity,newName:String){
        if let index = savedUsersEntities.firstIndex(of: userEntity) {
            print("Index of '\(userEntity.name ?? "")' is \(index)")
            userEntity.name = newName
            saveData()

        } else {
            print("Item not found")
        }
    }
    
    
    //MARK: NewOnboardEntity
    
    //
    public  func saveNewOnboardEntity(){
        do{
         try container.viewContext.save()
            fetchNewOnboardEntity()
        }catch let error{
            print("Error  \(error)")
        }
    }
    
    //
    public func fetchNewOnboardEntity() {
        let request = NSFetchRequest<NewOnboardEntity>(entityName: "NewOnboardEntity")
        do{
            savedNewOnboardEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Error  \(error)")
        }
    }
    
    //
    public func addNewOnboardEntity(text:String) {
        let newUser = NewOnboardEntity(context: container.viewContext)
        newUser.first_name = text
        newUser.last_name = text
        saveData()
    }
    
    
    
}

