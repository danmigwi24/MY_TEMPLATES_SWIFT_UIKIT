//
//  TEST.swift
//  MB IOS App
//
//  Created by Eclectics on 29/03/2023.
//

import SwiftUI
import MBCore
import Combine


struct CountryDropDownFloatingTextFieldView : View {
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
                
                CountryCodeSection().frame(maxWidth: .infinity).frame(alignment: .leading)
                
                
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
        
        Menu(content: {
            VStack{
                ForEach(COUNTRYPICKER, id: \.self) { item in
                    Button(action: {
                        selectedItem = item
                    }, label: {
                        Text("\(item.countryFlag)  \(item.countryName)")
                    })
                    
                    
                }
            }
        }, label: {
            HStack{
                CustomTextBold(text: "\(selectedItem.countryFlag) \(selectedItem.countryName) ", textColor: .black, fontSize: 14, textAlignment: .leading)
                Spacer()
            }
        })
        
        
    }
}


//MARK: CUSTOM Menu
struct CustomDropDownWithMenuView<Content:View> : View {
    var label : String //? = nil
    var placeHolder : String //? = nil
    let content : Content
    
    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    
    init(
        label: String,
        placeHolder: String,
        @ViewBuilder content:()-> Content,
        isEditing: Bool = false,
        edges: EdgeInsets = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    ){
        self.label = label
        self.placeHolder = placeHolder
        self.content = content()
        self.isEditing = isEditing
        self.edges = edges
        
    }
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @FocusState private var focusField : Field?
    
    var body: some View {
        ZStack(alignment : .leading) {
            HStack {
                //MenuSection().frame(maxWidth: .infinity).frame(alignment: .leading)
                content.frame(maxWidth: .infinity).frame(alignment: .leading)
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black))
            
            Text(label)
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
    
    
}


//MARK: CUSTOM PICKER
struct CustomDropDownWithPickerView<T:Hashable> : View {
    let filterCountry:[DropdownItem<T>] //= COUNTRYPICKER.map { $0.toDropDownItems() }
    @Binding  var selectedDropdownItem: DropdownItem<T> //= COUNTRYPICKER[0].toDropDownItems()
    var label : String
    var placeHolder : String
    //
    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    
    init(
        listOfOptions:[DropdownItem<T>],
        selectedItem:Binding<DropdownItem<T>>,
        label: String,
        placeHolder: String,
        isEditing: Bool = false,
        edges: EdgeInsets = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    ){
        self.filterCountry = listOfOptions
        self._selectedDropdownItem = selectedItem
        self.label = label
        self.placeHolder = placeHolder
        self.isEditing = isEditing
        self.edges = edges
        
    }
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @FocusState private var focusField : Field?
    
    var body: some View {
        ZStack(alignment : .leading) {
            HStack {
                PickerSection(filterCountry: filterCountry, selectedDropdownItem: $selectedDropdownItem).frame(maxWidth: .infinity).frame(alignment: .leading)
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black))
            
            Text(label)
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
    
    
}

//MARK: CUSTOM PICKER
struct CustomDropDownWithLeftIconPickerView<T:Hashable> : View {
    let filterCountry:[DropdownItem<T>] //= COUNTRYPICKER.map { $0.toDropDownItems() }
    @Binding  var selectedDropdownItem: DropdownItem<T> //= COUNTRYPICKER[0].toDropDownItems()
    var label : String
    var placeHolder : String
    //
    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    
    init(
        listOfOptions:[DropdownItem<T>],
        selectedItem:Binding<DropdownItem<T>>,
        label: String,
        placeHolder: String,
        isEditing: Bool = false,
        edges: EdgeInsets = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    ){
        self.filterCountry = listOfOptions
        self._selectedDropdownItem = selectedItem
        self.label = label
        self.placeHolder = placeHolder
        self.isEditing = isEditing
        self.edges = edges
        
    }
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @FocusState private var focusField : Field?
    
    var body: some View {
        ZStack(alignment : .leading) {
            HStack {
                PickerSectionWithLeftIcon(filterCountry: filterCountry, selectedDropdownItem: $selectedDropdownItem).frame(maxWidth: .infinity).frame(alignment: .leading)
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black))
            
            Text(label)
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
    
    
}



//MARK: SampleMenuSection
struct SampleMenuSection:View{
    @State  var selectedItem: CountryModel = COUNTRYPICKER[0]
    @State private var selectedCountryIndex = 0
    var body: some View{
        CountryCodeSection()
    }
    
    @ViewBuilder
    func CountryCodeSection()-> some View{
        
        Menu(content: {
            VStack{
                ForEach(COUNTRYPICKER, id: \.self) { item in
                    Button(action: {
                        
                    }, label: {
                        Text("\(item.countryName)")
                        
                    })
                    
                    
                }
            }
        }, label: {
            HStack{
                CustomTextBold(text: "\(selectedItem.countryName) ", textColor: .black, fontSize: 14, textAlignment: .leading)
                Spacer()
            }
        })
        
    }
}


//MARK: PickerSection
struct PickerSection<T:Hashable>:View{
    let filterCountry:[DropdownItem<T>]
    @Binding  var selectedDropdownItem: DropdownItem<T>
    
    let names = ["John", "Alice", "Bob", "Emily"]
    
    //
    @State private var isShowingHalfASheet = false
    var body: some View{
        CountryCodeSection()
    }
    
    @ViewBuilder
    func CountryCodeSection()-> some View{
        ZStack{
            VStack {
                Button(action: {
                    isShowingHalfASheet.toggle()
                }) {
                    HStack{
                        Text("\(selectedDropdownItem.title)")
                            .vSpacingWithMaxWidth(.leading)
                        
                        Image(systemName: isShowingHalfASheet ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill" )
                            .frame(width: 18,height: 15)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }
                }
                
                /*
                 if isShowingHalfASheet {
                 PopoverDropDownItemsSection()
                 }
                 */
                
            }
            .frame(maxWidth: .infinity)
            .actionSheet(isPresented: $isShowingHalfASheet) {
                ActionSheet(title: Text("Select"), message: nil, buttons: {
                    self.filterCountry.map { item in
                        return .default(Text(item.title)) {
                            // Handle selection of the name
                            print("Selected: \(item.title)")
                            selectedDropdownItem = item
                        }
                    }
                }() + [.cancel()])
            }
            /*
             .popover(
             isPresented: $isShowingHalfASheet
             //attachmentAnchor: .point(.topLeading)
             //arrowEdge: .top
             ) {
             PopoverDropDownItemsSection()//.presentationDetents([.medium])
             
             }
             */
            
            
        }
    }
    
    
    @ViewBuilder
    private func PopoverDropDownItemsSection()-> some View{
        VStack(spacing: 10) {
            
            HStack{
                CustomTextBold(
                    text: "Selected Item :\(selectedDropdownItem.title)", textColor: .black, fontSize: 24, textAlignment: .center)
                .vSpacingWithMaxWidth(.center)
                .padding(.vertical)
                
                Button(action: {
                    withAnimation(){
                        isShowingHalfASheet.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 28,weight: .bold))
                        .foregroundColor(Color(hexString: CustomColors.blue))
                }).padding()
            }
            // .padding()
            Divider()
            //
            Picker("", selection: $selectedDropdownItem) {
                ForEach(filterCountry ,id: \.self) { item in
                    VStack{
                        Text("\(item.title)")
                    }.padding(5)
                        .padding(.vertical,20)
                        .cornerRadius(5)
                        .tag(item)
                    
                    
                }
            }
            .onChange(of: selectedDropdownItem) { newValue in
                print("[PopoverDropDownItemsSection] returnedModel \(newValue.returnedModel)")
                withAnimation {
                    isShowingHalfASheet.toggle()
                }
                
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))
            
            CustomButtonFilled(action: {
                withAnimation {
                    isShowingHalfASheet.toggle()
                }
            }, title: "Select", bgColor: Color(hexString: CustomColors.blue), textColor: .white, paddingVertical: 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
}


//MARK: PickerSectionWithLeftIcon
struct PickerSectionWithLeftIcon<T:Hashable>:View{
    let filterCountry:[DropdownItem<T>]
    @Binding  var selectedDropdownItem: DropdownItem<T>
    
    //
    @State private var isShowingHalfASheet = false
    var body: some View{
        CountryCodeSection()
    }
    
    @ViewBuilder
    func CountryCodeSection()-> some View{
        ZStack{
            VStack {
                Button(action: {
                    isShowingHalfASheet.toggle()
                }) {
                    HStack{
                        //
                        Image("\(selectedDropdownItem.description)")
                            .resizable()
                            .frame(width: 28,height: 20)
                            .scaledToFit()
                            .foregroundColor(.black)
                        //
                        CustomTextRegular(
                            text: "\(selectedDropdownItem.title)", textColor: .black, fontSize: 14, textAlignment: .leading)
                        .vSpacingWithMaxWidth(.leading)
                        //
                        Image(systemName: isShowingHalfASheet ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill" )
                            .frame(width: 18,height: 15)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }
                }
                
                /*
                 if isShowingHalfASheet {
                 PopoverDropDownItemsSection()
                 }
                 */
                
            }
            .frame(maxWidth: .infinity)
            ///*
            .popover(
                isPresented: $isShowingHalfASheet
                //attachmentAnchor: .point(.topLeading)
                //arrowEdge: .top
            ) {
                PopoverDropDownItemsSection()//.presentationDetents([.medium])
                
            }
            //*/
            
            
        }
    }
    
    
    @ViewBuilder
    private func PopoverDropDownItemsSection()-> some View{
        VStack(spacing: 10) {
            
            HStack{
                CustomTextBold(
                    text: "Selected Item :\(selectedDropdownItem.title)", textColor: .black, fontSize: 24, textAlignment: .center)
                .vSpacingWithMaxWidth(.center)
                .padding(.vertical)
                
                Button(action: {
                    withAnimation(){
                        isShowingHalfASheet.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 28,weight: .bold))
                        .foregroundColor(Color(hexString: CustomColors.blue))
                }).padding()
            }
            // .padding()
            Divider()
            //
            Picker("", selection: $selectedDropdownItem) {
                ForEach(filterCountry ,id: \.self) { item in
                    VStack{
                        HStack{
                            //
                            Image("\(item.description)")
                                .resizable()
                                .frame(width: 28,height: 22)
                                .scaledToFit()
                                .foregroundColor(.black)
                            //
                            CustomTextRegular(
                                text: "\(item.title)", textColor: .black, fontSize: 24, textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                            
                        }
                    }.padding(5)
                        .padding(.vertical,20)
                        .cornerRadius(5)
                        .tag(item)
                    
                    
                }
            }
            .onChange(of: selectedDropdownItem) { newValue in
                print("[PopoverDropDownItemsSection] returnedModel \(newValue.returnedModel)")
                withAnimation {
                    isShowingHalfASheet.toggle()
                }
                
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))
            
            CustomButtonFilled(action: {
                withAnimation {
                    isShowingHalfASheet.toggle()
                }
            }, title: "Select", bgColor: Color(hexString: CustomColors.blue), textColor: .white, paddingVertical: 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
}





