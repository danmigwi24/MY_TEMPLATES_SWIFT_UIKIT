//
//  CustonTextFields.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 24/08/2023.
//

import SwiftUI
import MBCore

struct CustomTextFieldView: View {
    @Binding var text : String
    var hint : String
    var labelText : String
    let hasLabel : Bool = true
    var leadingIcon:Image? = nil
    var trailingIcon: Image?  = nil
    var isPassword : Bool = false
    var isIconNeeded : Bool = false
    var isTrailingIconNeeded : Bool = false
    var isEnabled : Bool? = true
    var keybaordType : UIKeyboardType = .default
    
    var body: some View {
        
        VStack{
            
            if hasLabel {
                Text(labelText)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16).weight(.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                //.padding(.leading,10)
                //.padding(.trailing,10)
            }
            
            ZStack{
                VStack{
                    HStack{
                        if isIconNeeded {
                            leadingIcon
                                .font(.callout)
                                .foregroundColor(.gray)
                                .frame(width: 40,alignment: .leading)
                        }
                        VStack{
                            if isPassword {
                                SecureField(hint,text: $text)
                                    .autocapitalization(.none) 
                                    .padding(.horizontal,4)
                                    .padding(.vertical,12)
                            }else {
                                TextField(hint,text: $text)
                                    .autocapitalization(.none)
                                    .padding(.horizontal,4)
                                    .padding(.vertical,12)
                                    .keyboardType(keybaordType)
                            }
                        }
                        if isTrailingIconNeeded {
                            trailingIcon
                                .font(.callout)
                                .foregroundColor(.blue)
                                .frame(width: 40,alignment: .trailing)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hexString: CustomColors.white).opacity(0.05)) // Set the background color to gray
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hexString: CustomColors.black), lineWidth: 0.5) // Set the stroke (border) color to black
                        )
                )
                //.padding(.horizontal,9)
                
            }
            
        }
        
        
    }
}

struct PasswordTextFieldWithIcon: View {
    @Binding var text : String
    var hint : String
    var labelText : String
    var trailingIcon: Image = Image("")
    @Binding var isPassword : Bool 

    var body: some View {
        VStack{
                Text(labelText)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16).weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                //.padding(.leading,10)
                //.padding(.trailing,10)
            ZStack{
                VStack{
                    HStack {
                        if isPassword {
                            SecureField(hint,text: $text)
                                .autocapitalization(.none)
                                .padding(.horizontal,4)
                                .padding(.vertical,12)
                                .hSpacing(.leading)
                        } else {
                                TextField(hint,text: $text)
                                .autocapitalization(.none)
                                    .padding(.horizontal,4)
                                    .padding(.vertical,12)
                                    .hSpacing(.leading)
                            }
                        Button(action: {
                            self.isPassword.toggle()
                        }, label: {
                            trailingIcon
                                .foregroundColor(.blue)
                                .frame(width: 40,alignment: .trailing)
                                .padding(.vertical,4)
                                .padding(.horizontal,4)
                        })
                        
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hexString: CustomColors.gray).opacity(0.05)) // Set the background color to gray
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hexString: CustomColors.gray), lineWidth: 0.5) // Set the stroke (border) color to black
                        )
                )
            }
            
        }
    }
}

struct PhoneNumberTextFieldWithCountryCode: View {
    
    @Binding var text : String
    @Binding var selectedOption: CountryModel
    
    var hint : String
    var labelText : String
    var trailingIcon: Image = Image("")
    private var onSelect: (CountryModel) -> Void
    
   // @ObservedObject var viewModel = PhoneNumberTextFieldViewModel()
 
    init(
        text: Binding<String>,
        hint: String, labelText: String,
        trailingIcon: Image = Image(""),
        selectedOption:Binding<CountryModel>,
        onSelect: @escaping (CountryModel) -> Void) {
           self._text = text // Initialize the @Binding property
           self.hint = hint
           self.labelText = labelText
           self.trailingIcon = trailingIcon // Initialize the trailingIcon property
            self._selectedOption = selectedOption
           self.onSelect = onSelect
       }
    
     let defaultSelection =  COUNTRYPICKER[0]
    
    var body: some View {
        VStack{
            Text(labelText)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16).weight(.medium))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack{
                VStack{
                    HStack(spacing:10) {
                        
                        Picker("", selection: $selectedOption) {
                            //
                            //Text(defaultSelection.countryInitials).tag(nil as CountryModel?)
                            //
                            ForEach(COUNTRYPICKER, id: \.self) { option in
                                Text("\(option.countryFlag)\(option.countryCallingCodeWithPlus)")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 18).weight(.semibold))
                                    .onTapGesture {
                                        onSelect(option)
                                    }
                                    .tag(option as CountryModel?)
                                
                            }
                        }.padding(.leading,2)
                            //.frame(maxWidth: .infinity ,alignment: .leading)
                        
                        TextField(hint, text: $text)
                            .autocapitalization(.none)
                            .keyboardType(.numberPad)
                            .padding(.vertical,12)
                            .hSpacing(.leading)
                        
                    }.vSpacingWithMaxWidth(.leading)
                }.frame(maxWidth: .infinity)
//                .onReceive(viewModel.$selectedOption) { newValue in
//                    if let option = newValue {
//                        onSelect(option)
//                        Logger("\(option)")
//                    }else {
//                        onSelect(newValue ?? CountryModel(countryAbbreviation: "KE", countryName: "Kenya", countryCallingCode: "254", countryCallingCodeWithPlus: "+254", countryFlag: "🇰🇪"))
//                    }
//                }
//
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hexString: CustomColors.gray).opacity(0.05)) // Set the background color to gray
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hexString: CustomColors.gray), lineWidth: 0.5) // Set the stroke (border) color to black
                        )
                )
            }

        }
    }
}


struct MBTextFieldView : View {
    @Binding var text : String
    var hint : String
    var labelText : String
    let hasLabel : Bool = true
    var leadingIcon:Image? = nil
    var trailingIcon: Image?  = nil
    var isPassword : Bool = false
    var isIconNeeded : Bool = false
    var isTrailingIconNeeded : Bool = false
    var isEnabled : Bool? = true
    var keybaordType : UIKeyboardType = .default
    
    var body: some View {
        VStack{
            Form {
                TextField(text: $text, prompt: Text("Required")) {
                    Text("Username")
                }
                
                SecureField(text: $text, prompt: Text("Required")) {
                    Text("Password")
                }
            }

        }
    }
}



struct MBTextFieldViewPreviews : View {
    @State var text : String = ""
    var body: some View{
        VStack{
            Form{
                //Section{
                TextField(text: $text, prompt: Text("Required")) {
                    Text("Username")
                }
                TextField(text: $text, prompt: Text("Required")) {
                    Text("Username")
                }
                //}
            }
        }.background(.red)
    }
}


