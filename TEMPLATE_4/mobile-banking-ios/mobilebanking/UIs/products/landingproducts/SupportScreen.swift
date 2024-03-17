//
//  SupportScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 16/02/2024.
//

import Foundation
import SwiftUI
import MBCore

import CoreLocation
import CustomHalfSheet
import SwiftUI
import SwiftUIDigitalSignature

struct SupportScreen_Previews: PreviewProvider {
    static var previews: some View {
        SupportScreen()
    }
}


struct SupportScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var isShowingHalfASheet = true
    //
    @State private var digitalSignature: UIImage? = nil
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
extension SupportScreen {
    
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
        .navigationBarTitle("Support Center",displayMode: .inline)
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
    
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension SupportScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Text(""), isActive: $navigateTo).opacity(0)
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
            
            //MARK: HalfASheet
            HalfASheet(isPresented: $isShowingHalfASheet, title: "") {
                VStack(spacing: 0) {
                    CustomSpacer(height: 10)
                    SignatureView(availableTabs: [.image,.type],
                                  onSave: { image in
                        self.digitalSignature = image
                    }, onCancel: {
                        
                    })
                }
                .padding(5)
            }
            // Customise by editing these.
            .height(.proportional(0.70))
            //.closeButtonColor(UIColor.white)
            //.backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
            
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                CustomTextBold(text: "Call Support", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 24, textAlignment: .center)
            }
        }
    }
    
}



