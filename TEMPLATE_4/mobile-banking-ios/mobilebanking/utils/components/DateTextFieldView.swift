//
//  DateTextFieldView.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 04/09/2023.
//

import SwiftUI
import MBCore



struct CustomDatePickerTextFieldView: View {
    @Binding  var selectedDate:Date //= Date()
    @Binding  var dob:String //= Date()
    @State private var isDatePickerShowing = false
    
    
    private let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"//"yyyy-MM-dd"
           return formatter
       }()
    
    private let dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            VStack{
                FloatingTextFieldView(
                    text: $dob,
                    label: "Date of birth",
                    placeHolder : "Eg. 01/01/1988",
                    rightIcon : "calendar",
                    isSystemImageRightIcon:false,
                    action: {}
                )
                    .onTapGesture {
                        isDatePickerShowing = true
                    }
            }
            .sheet(isPresented: $isDatePickerShowing) {
                VStack{
                    HStack{
                        CustomTextBold(
                            text: dob,
                            textColor: Color(hexString: CustomColors.darkBlue),
                            fontSize: 16,
                            textAlignment: .leading
                        )
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .scaledToFit()
                            .foregroundColor(Color(hexString: CustomColors.darkBlue))
                            .onTapGesture {
                                self.isDatePickerShowing.toggle()
                                dob = dateFormatter.string(from: selectedDate)
                            }
                    }
                    .padding()
                    //
                    Divider()
                    //
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        //.datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding()
                        .onChange(of: selectedDate) { newValue in
                            dob = dateFormatter.string(from: newValue)
                        }
                    
                    ///*
                    CustomButtonFilled(action: {
                        self.isDatePickerShowing.toggle()
                    }, title: "Apply", bgColor: Color(hexString: CustomColors.blue), textColor: Color.white, paddingVertical: 10)
                    .vSpacingWithMaxWidth()
                    .padding(.vertical,4)
                    //*/
                    
                    Spacer()
                }
                .padding(8)
                .onAppear{
                    dob = dateFormatter.string(from: selectedDate)
                }
                .onDisappear{
                    dob = dateFormatter.string(from: selectedDate)
                }
            }
        }.padding(.vertical,8)
    }
    
 
}

struct DateTextFieldView: View {
    
    @Binding var selectedDate : Date
    var label:String
    @Binding var text:String
    var hint : String
    @State private var isDatePickerVisible = false
    @Binding var  startDate :Date //= Calendar.current.date(from: DateComponents(year: 1900)) ?? Date()//Date()
    @Binding var  endDate: Date //= Calendar.current.date(from: DateComponents(year: 2015)) ?? Date()
    
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter
//    }
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter
       }()
    
    var body: some View {
        DatePickerSection()
    }
}

extension DateTextFieldView {
    @ViewBuilder
    func DatePickerSection() -> some View{
        VStack {
            Text(label)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16).weight(.medium))
                .foregroundColor(Color.black)
                .padding(.top, 4)
                //.padding(.leading, 10)
                .padding(.trailing, 10)
            
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                isDatePickerVisible.toggle()
                text = dateFormatter.string(from: selectedDate)
            }) {
                VStack{
                    HStack{
                        //Text(dateFormatter.string(from: selectedDate)) // Show selected date in button text
                        TextField("dd/mm/yyyy", text: $text  )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .foregroundColor(.black)
                            .disabled(true)
                        
                        
                        Image(systemName: "calendar")
                            .font(.callout)
                            .foregroundColor(.blue)
                            .padding(.trailing,10)
                            .frame(width: 40,alignment: .trailing)
                    }.vSpacingWithMaxWidth(.leading)
                }.background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(CustomColors.gray).opacity(0.05)) // Set the background color to gray
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(CustomColors.gray), lineWidth: 0.5) // Set the stroke (border) color to black
                        )
                )
            }
            
            if isDatePickerVisible {
                    VStack{
                        DatePicker("", selection: $selectedDate,in: startDate...endDate,displayedComponents: [.date] )
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                        HStack{
                            Button(action:{
                                isDatePickerVisible.toggle()
                                text = dateFormatter.string(from: selectedDate)
                            }) {
                                HStack {
                                    
                                    Text("Apply")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                }.frame(maxWidth: .infinity,alignment: .center)
                                    .padding(.top)
                                    .padding(.bottom)
                                    .background(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(.white, lineWidth: 1)
                                            .background(Color.blue)
                                    )
                                    .cornerRadius(40)
                                
                            }
                        }.padding(20)
                    }.background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(.blue, lineWidth: 1)
                            .background(Color.white)
                    )
                
            }
        }
    }
}

