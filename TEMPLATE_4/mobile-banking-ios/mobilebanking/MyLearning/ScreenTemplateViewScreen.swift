import Foundation
import SwiftUI
import MBCore
import CoreLocation
import CustomHalfSheet
import SwiftUI
import SwiftUIDigitalSignature
import Localize_Swift
import Combine
import MapKit
import CodeScanner

struct ScreenTemplateViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTemplateViewScreen()
    }
}


struct ScreenTemplateViewScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var isShowingHalfASheet = false
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
extension ScreenTemplateViewScreen {
    
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
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label:{
                    HStack{
                        Image(systemName: "chevron.backward")
//                            .resizable()
//                            .frame(width: 18,height: 15)
//                            .scaledToFit()
                            .foregroundColor(.black)
                        ///*
                        
                        Text("Back")
                            .foregroundColor(Color.blue)
                        //*/
                    }
                })
               
            )
        .navigationBarItems(
            trailing:
                HStack{
                    Button(action: {
                        // Action to perform when the "Next" button is tapped
                      //submitAction()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Continue")
                            .foregroundColor(Color.blue)
                    })
                }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ///*
                Button(action: {
                    // Action to perform when the "Next" button is tapped
                  submitAction()
                }, label: {
                    Text("Next")
                        .foregroundColor(Color.blue)
                })
                 //*/
            }
        }
        
    }
    
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension ScreenTemplateViewScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Text("Next"), isActive: $navigateTo).opacity(0)
            VStack(){
                /*
                HeaderView(
                    title: "",
                    textColor: .white,
                    imageIcon: "arrow.backward",
                    isSystemImage: true,
                    action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ) //.frame(height: UIScreen.main.bounds.height * 0.1)
                */
                
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
                
            }
        }
    }
    
}



extension ScreenTemplateViewScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
//        guard !setMaximumAmount.isEmpty else {
//            showCustomizedSwiftMessages(title: "Error", body:"DOB Required")
//            return false
//        }
        // All validations passed
        return true
    }
    
    private func submitAction(){
        if validateFields(){
            sharedViewModel.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                sharedViewModel.isLoading = false
                self.navigateTo.toggle()
            }
        }
    }
}
