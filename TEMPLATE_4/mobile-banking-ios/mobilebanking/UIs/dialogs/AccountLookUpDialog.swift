//
//  AccountLookUpDialog.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import SwiftUI
import MBCore

struct OpenAccountDialog:View{
    @Binding var show : Bool
    
    //
    @State var navigateToNext:Bool = false
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
            //
            NavigationLink("",destination: TypesofAccountsScreen(), isActive: $navigateToNext).opacity(0)
            //
            VStack(spacing: 5){
                //Spacer()
                LottieView(name: LottieFiles.GRANT_PERMISION)
                    .frame(width: 150,height: 150)
                
                Text("Sorry you don’t have an account registered!")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom(CustomFontNames.NunitoSans_Bold, size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hexString: CustomColors.black))
                
                Text("We didn’t find an account registered to +2547123***678. Would you like to open an account with us? If you have An account with us kindly use your account number.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hexString: CustomColors.gray))
                
                
                CustomButtonFilled(
                    action: {
                        //show.toggle()
                        navigateToNext = true
                        
                    },
                    title: "OPEN AN ACCOUNT",
                    bgColor: Color(hexString:CustomColors.lightBlue),
                    textColor: Color.white
                )
                
                CustomButtonStroke(
                    action: {
                        show = false
                    },
                    title: "TRY AGAIN",
                    bgColor: Color.white,
                    textColor: Color(hexString:CustomColors.lightBlue),
                    strokeColor: Color(hexString:CustomColors.lightBlue),
                    strokeWidth: 1
                )
                //Spacer()
            }
            .padding(.horizontal,15)
            .padding(.vertical,20)
            .background(Color.white)
            .cornerRadius(15)
            .padding(5)
            
        }
        .onDisappear{
          //  show = false
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        //.background(BlurView().opacity(0.9).edgesIgnoringSafeArea(.all))
        .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
        
    }
    
    
}
