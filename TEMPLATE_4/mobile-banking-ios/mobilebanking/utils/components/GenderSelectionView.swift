//
//  GenderSelectionView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import Foundation

import SwiftUI
import MBCore

struct Gender:Hashable{
    let id: Int
    let name: String
    let abrevication: String
}

struct GenderSelectionView: View {
    @State private var selectedGender: Gender? = nil
    @Binding  var gender: String
    
    let genders = [
        Gender(id: 0, name: "Male",abrevication:"male"),
        Gender(id: 1, name: "Female",abrevication:"female"),
        //Gender(id: 2, name: "Other",abrevication:"O")
    ]
    
    var body: some View {
        VStack {
            Menu(content: {
                VStack{
                    ForEach(genders, id: \.id) { gender in
                        Button(action: {
                            selectedGender = gender
                            self.gender = "\(selectedGender?.name ?? genders[0].name)"
                        }, label: {
                            Text(gender.name).tag(gender as Gender?)
                        })
                        
                        
                    }
                }
            }, label: {
                HStack{
                    FloatingTextFieldView(
                        text: $gender,
                        label: "Gender",
                        placeHolder : "Eg. Male",
                        rightIcon: "arrowtriangle.down.fill",
                        isSystemImageRightIcon: true,
                        action: {}
                    ).vSpacingWithMaxWidth(.leading)
                    Spacer()
                }.vSpacingWithMaxWidth(.leading)
               
            })
           
            
        }
    }
}


