//
//  CalculatorScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore



struct CalculatorScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct CalculatorScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    
    
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension CalculatorScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry: geometry)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                     
                       
                    //
                }
                
            }
            
        }
        .onAppear {
            
            
        }
        .alert(isPresented: $sharedViewModel.showAlert){
            CustomAlert(
                isPresented: $sharedViewModel.showAlert,
                title: "Info",
                decription: sharedViewModel.alertMessage
            )
        }
        .actionSheet(isPresented: self.$sharedViewModel.showActionSheet) {
            CustomActionSheet(
                isPresented: $sharedViewModel.showActionSheet,
                title: "Info",
                decription: sharedViewModel.actionSheetMessage
            )
        }
        .navigationBarTitle("Calculator",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundColor(Color.blue)
                    }
                })
            }
        }
        .toolbar {
            /*
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                        self.navigateToContinue.toggle()
                    
                }, label: {
                    Text("Next")
                        .foregroundColor(Color.blue)
                })
            }
             */
        }
        
    }

    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            //NavigationLink("", destination: UnsecuredLoanCalculatorScreen(), isActive: $navigateTo)
           
            VStack(spacing: 0){
                    //
                //CustomSpacer(height: 20)
                ContentView(geometry:geometry)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .frame(minHeight: geometry.size.height * 0.8)
                Spacer()
            }
            
            
            
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ZStack(alignment: Alignment.top){
            VStack(spacing:10){ //
                TitleAndDescriptionView(
                    title: "Choose a calculator that suits the type of loan you want",
                    description: "Select one that suits your needs and proceed with it"
                )
                
                ScrollView {
                    
                    ForEach(listOfCalculatorItemModel) { item in
                        NavigationLink(destination: UnsecuredLoanCalculatorScreen(calculatorItemModel: item)) {
                            CalculatorItemView(item: item)
                        }
                       
                    }
                    
                }
                
            }.padding(10)
        }
    }
    
}



struct CalculatorItemView: View {
    let item: CalculatorItemModel
    
    var body: some View {
        ZStack {
            HStack(spacing:0){
                ZStack{
                    Image(item.image)
                        .resizable()
                        .frame(width: 40,height: 40,alignment: .bottomTrailing)
                        .aspectRatio(contentMode: .fill)
                        .padding(2)
                }.background(Circle().fill(Color.white))
                
                VStack(spacing: 0) {
                    CustomTextSemiBold(
                        text: item.title,
                        textColor: .black,
                        fontSize: 16,
                        textAlignment: TextAlignment.leading
                    )
                    .vSpacingWithMaxWidth(.leading)
                    
                    
                    CustomTextRegular(
                        text: item.description,
                        textColor: Color(hexString: CustomColors.gray),
                        fontSize: 14,
                        textAlignment: TextAlignment.leading
                    )
                    .vSpacingWithMaxWidth(.leading)
                }.padding(.horizontal,10)
                
                Image(systemName: "chevron.forward")
                    //.resizable()
                    //.frame(width: 10,height: 12)
                    //.scaledToFit()
                    .foregroundColor(.black)
                
            }
            .padding(10)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
        }
    }
}
