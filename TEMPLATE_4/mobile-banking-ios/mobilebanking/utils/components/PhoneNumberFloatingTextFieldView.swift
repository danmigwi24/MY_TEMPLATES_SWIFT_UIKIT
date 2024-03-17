//
//  PhoneNumberFloatingTextFieldView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import Foundation

import SwiftUI
import MBCore


struct PhoneNumberFloatingTextFieldView : View {
    @Binding var text : String
    var label : String? = nil
    var placeHolder : String? = nil
  
    @Binding  var selectedItem: CountryModel //= COUNTRYPICKER[0]

    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    //@State private var edges = EdgeInsets(top: 0, leading:45, bottom: 0, trailing: 0)
    
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @FocusState private var focusField : Field?
    
    var body: some View {
        ZStack(alignment : .leading) {
            HStack {
                
            
                CountryCodeSection()
                TextField(placeHolder ?? "", text: $text) { status in
                    DispatchQueue.main.async {
                        isEditing = status
                        if isEditing {
                            //edges = EdgeInsets(top: 0, leading:15, bottom: 60, trailing: 0)
                        }
                        else {
                            //edges = EdgeInsets(top: 0, leading:45, bottom: 0, trailing: 0)
                        }
                    }
                }
                .keyboardType(.numberPad)
                .focused($focusField, equals: .fieldName)
                
               
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black))
            
            Text(label ?? "")
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 12))
                .background(Color(UIColor.systemBackground))
                .foregroundColor(Color.black)
                .padding(edges)
                .animation(Animation.easeInOut(duration: 0.4), value: edges)
                .onTapGesture {
                    self.focusField = .fieldName
                }
            
        }
    }
    
    @ViewBuilder
    func CountryCodeSection()-> some View{
        VStack {
            Menu(content: {
                VStack{
                    ForEach(COUNTRYPICKER, id: \.self) { item in
                        Button(action: {
                            selectedItem = item
                        }, label: {
                            CustomTextBold(text: "\(item.countryFlag) (\(item.countryCallingCodeWithPlus))", textColor: .black, fontSize: 14, textAlignment: .leading)
                        })
                        
                        
                    }
                }
            }, label: {
                HStack{
                    CustomTextBold(text: "\(selectedItem.countryFlag) (\(selectedItem.countryCallingCodeWithPlus))", textColor: .black, fontSize: 14, textAlignment: .leading)
                    Rectangle().fill(.black).frame(width: 1,height: 22)
//                    Image(systemName: "chevron.down")
//                        //.frame(width: 18,height: 15)
//                        //.scaledToFit()
//                        .foregroundColor(.black)
                }
            })
           
            
        }
    }
}


struct PhoneNumberFloatingTextFieldViewForPreview : View {
    @State private var firstName:String = ""
    @State private var selectedCountry: CountryModel = COUNTRYPICKER[0]
    var body: some View{
        VStack{
            
            Text("SELECTED COUNTRY IS : \(selectedCountry.countryName)\n INPUT IS :  \(selectedCountry.countryCallingCode)\(firstName)")
            
            PhoneNumberFloatingTextFieldView(text: $firstName, label: "Label", placeHolder: "Eg: Test", selectedItem: $selectedCountry)
            
            CustomButtonFilled(action: {
                print("SELECTED COUNTRY IS : \(selectedCountry)")
                print("INPUT IS : \(firstName)")
            }, title: "CONTINUE", bgColor: .blue, textColor: .white)
        }
    }
}

struct PhoneNumberFloatingTextFieldView_Previews: PreviewProvider {
   
    static var previews: some View {
        PhoneNumberFloatingTextFieldViewForPreview().padding()
    }
}
