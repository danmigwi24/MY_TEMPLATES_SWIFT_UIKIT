//
//  TakeSelfieScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import Foundation
import SwiftUI
import MBCore




struct TakeSelfieScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct TakeSelfieScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    
    //
    @State private var firstName:String = ""
    @State private var middleName:String = ""
    @State private var lastName:String = ""
    @State private var idNumber:String = ""
    @State private var dob:String = ""
    @State private var gender:String = ""
    //
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
extension TakeSelfieScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 0){
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry:geometry)
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
        .navigationBarTitle("Take Selfie",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
    }
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Text("Next"), isActive: $navigateTo).opacity(0)
            VStack(){
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
                
            }
            
            
            /*
             *DIALOG VISIBILITY
             */
            if showDialog{
                CustomSwiftUIDialog(showDialog: $showDialog) {
                    SampleDailog(showDialog: $showDialog){
                        
                    }
                }
            }
            
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        // ScrollView(.vertical,showsIndicators: false) {
        VStack(spacing:0){
            
            VStack(spacing:10){ //
                CustomTextBold(
                    text: "Take a selfie of yourself",
                    textColor: .black,
                    fontSize: 16,
                    textAlignment: TextAlignment.leading
                )
                .padding(.vertical,10)
                .vSpacingWithMaxWidth(.leading)
                
                CustomTextRegular(
                    text: "Take a selfie and we will do a face match with the photo on Your National ID",
                    textColor: Color(hexString: CustomColors.darkBlue),
                    fontSize: 12,
                    textAlignment: TextAlignment.leading
                )
                .vSpacingWithMaxWidth(.leading)
                
            }
            
            ImageSection(geometry: geometry).vSpacingWithMaxWidth()
            Spacer()
            ButtonSection()
            
        }.padding(10)
        // }
    }
    
    //
    @ViewBuilder
    func ImageSection(geometry:GeometryProxy) -> some View {
        VStack{
            VStack{
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                
            }
            .frame(maxWidth: geometry.size.height * 0.4,maxHeight: geometry.size.height * 0.4) //30%
            //.background(Color.red)
        }
        .frame(maxWidth: .infinity)
        .frame(height: geometry.size.height * 0.6) //60%
        .padding(.vertical,10)
        .padding(.horizontal,10)
        //.background(Color.blue)
        
    }
    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            CustomButtonFilled(
                action: {
                    
                },
                title: "CONTINUE",
                bgColor: Color(hexString: CustomColors.blue),
                textColor: .white
            )
        }.vSpacingWithMaxWidth()
    }
    
}







