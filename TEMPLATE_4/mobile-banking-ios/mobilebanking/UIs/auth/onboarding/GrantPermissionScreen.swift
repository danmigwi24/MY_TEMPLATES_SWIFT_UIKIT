//
//  GrantPermissionScreen.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import SwiftUI
import MBCore


struct GrantPermissionScreen_Previews: PreviewProvider {
    static var previews: some View {
        GrantPermissionScreen()
    }
}


struct GrantPermissionScreen: View {
    @State var showGrantPermision:Bool = true
    
    var body: some View {
        
        GeometryReader{ geometryProxy in
            ZStack{
                VStack{
                    Button(action: {
                        showGrantPermision.toggle()
                    }, label: {
                        VStack{
                            Text("Custom Alert")
                            
                        }
                    })
                }
                if showGrantPermision {
                        GrantPermissionView(show: $showGrantPermision)
                }
            }
        }
    }
}
//

struct GrantPermissionView:View{
    @Binding var show : Bool
    
    @State var showGrantContactPermision:Bool = false
    @State var showGrantStoragePermision:Bool = false
    @State var showGrantLocationPermision:Bool = false
    //
    @State var navigateToNext:Bool = false
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
            NavigationLink("",destination: GetStartedLandingPageScreen(), isActive: $navigateToNext).opacity(0)
            HStack{
                NavigationLink(destination: GetStartedLandingPageScreen(), label: {
                    Text("Skip")
                        .foregroundColor(Color(hexString: CustomColors.darkBlue))
                }).padding()
               
                
                Spacer()
                
                Button(action: {
                    withAnimation(){
                        navigateToNext.toggle()
                    }
                }, label: {
                    Text("Allow")
                        .foregroundColor(Color(hexString: CustomColors.darkBlue))
                       // .foregroundColor(.white)
                }).padding()
                
            }
            .frame(maxWidth: .infinity)
            //.background(Color.red)
                .offset(y:-80)
              
            
            
            
            //
            VStack(spacing: 25){
    
                LottieView(name: LottieFiles.GRANT_PERMISION)
                    .frame(width: 150,height: 150)
                
                Text("Grant permision")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom(CustomFontNames.NunitoSans_Bold, size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hexString: CustomColors.black))
                
                Text("To have a better experience with our product Give permission to the following")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom(CustomFontNames.NunitoSans_SemiBold, size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hexString: CustomColors.gray))
                
                ItemToGrantPermission(
                    title: "Contacts",
                    description: "We access your contacts to make transactions",
                    checked: $showGrantContactPermision
                ){
                    showGrantContactPermision.toggle()
                }
                
                ItemToGrantPermission(
                    title: "Storage",
                    description: "Make downloads of your statements",
                    checked: $showGrantStoragePermision
                ){
                    showGrantStoragePermision.toggle()
                }
                ItemToGrantPermission(
                    title: "Location",
                    description: "Get direction to ATM & Branches",
                    checked: $showGrantLocationPermision
                ){
                    showGrantLocationPermision.toggle()
                }
                
                
            }
            
            .padding(.horizontal,10)
            //.background(Color(hexString: "#DBDBDC"))
            .background(Color(hexString: CustomColors.white))
            .cornerRadius(25)
            .padding(5)
            //
            
            
            
            
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        //.background(Color.primary.opacity(0.35))
        .background(BlurView().edgesIgnoringSafeArea(.all))
        
    }
    
    @ViewBuilder
    func ItemToGrantPermission(
        title:String,
        description:String ,
        checked:Binding<Bool>,// = false,
        action: @escaping () -> ()
    )->some View {
        
        VStack{
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.custom(CustomFontNames.NunitoSans_Bold, size: 18))
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                        .foregroundColor(Color(hexString: CustomColors.black))
                    
                    Text(description)
                        .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(hexString: CustomColors.black))
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    action()
                }, label: {
                    
                    Image(systemName: checked.wrappedValue ? "checkmark" : "")
                        .frame(width: 16,height: 16)
                        .foregroundColor(.black)
                }).padding()
            }
            Rectangle().fill(.gray)
                .frame(height: 0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom,2)
        }.onTapGesture {
            withAnimation(){
                action()
            }
        }
        
    }
}
