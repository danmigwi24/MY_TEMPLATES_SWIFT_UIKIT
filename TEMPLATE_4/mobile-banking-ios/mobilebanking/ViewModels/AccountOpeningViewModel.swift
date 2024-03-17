//
//  AccountOpeningViewModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/03/2024.
//

import Foundation
import RealmSwift
import MBCore

class AccountOpeningViewModel: ObservableObject {
    
    private var realm:Realm?
    @Published var personalDetailsModelList: [PersonalDetailsModel] = []
    @Published var personalDetailsModel: PersonalDetailsModel = PersonalDetailsModel()
    
    
    init(){
        do{
            let realmConfiguration = Realm.Configuration(schemaVersion: 1)
            self.realm = try Realm(configuration: realmConfiguration)
            print("SUCCESS FULLY LOADED REALM DB")
        }catch{
            print("Error laod ream db: \(error.localizedDescription)")
        }
        
       // self.getPersonalDetailsModel()
    }
    
    //MARK: - ALL MODELS
    func getPersonalDetailsModel()  {
        guard let realm = self.realm else {
            print("FAILED TO LOAD DATA FROM REALM DB")
            return
        }
        for item in realm.objects(PersonalDetailsModel.self) {
            personalDetailsModelList.append(item)
            print("FETCHING PERSONA DETAILS\n\(item)")
        }
    }
    
    
    // MARK: - Add
    func addPersonalDetails(item: PersonalDetailsModel) {
        guard let realm = self.realm else {
            print("FAILED TO LOAD DATA FROM REALM DB")
            return
        }
        
        do {
            if self.findDataByID(id: 1)?.id == item.id {
                updateTaskWithID(id: 1, updatedItem: item)
            }else{
                try realm.write {
                    realm.add(item)
                    print("SAVED TO REALM DB")
                }
            }
        } catch {
            print("Error adding task: \(error.localizedDescription)")
        }
    }
    //
    func updateTaskWithID(id: Int, updatedItem: PersonalDetailsModel) {
        guard let realm = self.realm else {
            print("FAILED TO LOAD DATA FROM REALM DB")
            return
        }
        
        if let itemToUpdate = realm.object(ofType: PersonalDetailsModel.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    //itemToUpdate = updatedItem
                    //
                    itemToUpdate.phoneNumber = updatedItem.phoneNumber
                    itemToUpdate.reqType = updatedItem.reqType
                    itemToUpdate.transactionType = updatedItem.transactionType
                    itemToUpdate.accountType = updatedItem.accountType
                    itemToUpdate.currency = updatedItem.currency
                    itemToUpdate.firstName = updatedItem.firstName
                    itemToUpdate.middleName = updatedItem.middleName
                    itemToUpdate.lastName = updatedItem.lastName
                    itemToUpdate.documentType = updatedItem.documentType
                    itemToUpdate.grantType = updatedItem.grantType
                    itemToUpdate.gender = updatedItem.gender
                    itemToUpdate.emailAddress = updatedItem.emailAddress
                    itemToUpdate.idNumber = updatedItem.idNumber
                    //
                }
            } catch {
                print("Error updating task: \(error.localizedDescription)")
            }
        }
    }
    //
    func findDataByID(id: Int)  -> PersonalDetailsModel?{
        guard let realm = self.realm else {
            print("FAILED TO LOAD DATA FROM REALM DB")
            return nil
        }
        
        guard let data = realm.object(ofType: PersonalDetailsModel.self, forPrimaryKey: id) else {
            return nil
        }
        //
        
        personalDetailsModel = data
        return data
    }
    // MARK: - Delete Model
    func clearAllPersonalDetails() {
        guard let realm = self.realm else {
            print("FAILED TO LOAD DATA FROM REALM DB")
            return
        }
        
        do {
            try realm.write {
                realm.delete(realm.objects(TaskRealmModel.self))
            }
        } catch {
            print("Error clearing tasks: \(error.localizedDescription)")
        }
    }
    
}









