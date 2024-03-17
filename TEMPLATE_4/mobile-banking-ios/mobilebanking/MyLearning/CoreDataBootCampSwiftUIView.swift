//
//  CoreDataBootCampSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 23/02/2024.
//

import SwiftUI
import MBCore
import CoreData
import CustomTextField

struct CoreDataBootCampSwiftUIView: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State var userName :String = ""
    @State var errorText = "*Required"
    @State var errorUserName = false
    //
    @State var itemToUpdateUserEntity : UsersDataEntity? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 20) {
                ///*
                EGTextField(text: $userName)
                    .setTitleText("User Name")
                    .setTitleColor(.black)
                    .setTitleFont(.body)
                    .setPlaceHolderText("Eg. Dan")
                    .setPlaceHolderTextColor(Color.gray)
                    .setError(errorText: $errorText, error: $errorUserName)
                //*/
                
                CustomButtonStroke(action: {
                    if validateFields(){
                        if let itemToUpdateUserEntity = itemToUpdateUserEntity{
                            print("UPDATING THIS USER : \(userName)")
                            vm.updateUser2(userEntity: itemToUpdateUserEntity,newName: userName)
                            self.itemToUpdateUserEntity = nil
                        }else{
                            print("ADDING THIS USER : \(userName)")
                            vm.addUser(text: userName)
                        }
                        userName = ""
                    }
                }, title: "Add", bgColor: .white, textColor: .blue, strokeColor: .blue, strokeWidth: 1, paddingVertical: 4, cornerRadius: 15)
                
                List {
                    ForEach(vm.savedUsersEntities){entity in
                        CustomTextMedium(text: entity.name ?? "", textColor: .black, fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                            .onTapGesture {
                                userName = entity.name ?? ""
                                itemToUpdateUserEntity = entity
                                //vm.updateUser(userEntity: entity)
                                
                            }
                    }.onDelete { indexSet in
                        vm.deleteUser(indexSet: indexSet)
                    }
                    .toolbar { EditButton() }
                    
                }.listStyle(PlainListStyle())
            }
        }.padding(10)
    }
}


/**
 BUSINESS LOGICS
 */
extension CoreDataBootCampSwiftUIView{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        //        guard !userName.isEmpty else {
        //            self.errorUserName.toggle()
        //            return false
        //        }
        // All validations passed
        return true
    }
    
}


#Preview {
    CoreDataBootCampSwiftUIView()
}
