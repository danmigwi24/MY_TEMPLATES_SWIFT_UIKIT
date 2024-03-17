//
//  ActivateYourBiometricsDialog.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import SwiftUI
import MBCore

struct ActivateYourBiometricsDialog: View {
    

    let action:()->()
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Image("fingerprint")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .scaledToFill()
                Image("face_recognition")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .scaledToFill()
                Image("voice_logo")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .scaledToFill()
            }
            
            Text("Activate your biometrics")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom(CustomFontNames.NunitoSans_Bold, size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(hexString: CustomColors.black))
            
            Text("You don’t have any biometrics activated yet on Your account. Activate biometrics for easier Login and authorisation")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(hexString: CustomColors.gray))
            
            CustomButtonFilled(
                action: {
                    action()
                },
                title: "ACTIVATE",
                bgColor: Color(hexString:CustomColors.lightBlue),
                textColor: Color.white,
                paddingVertical:12
            )
            
            
        }
    }
}



struct ActivateUseVoiceIDBiometricsDialog: View {
    

    let action:()->()
    
    @State var isSpeaking:Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                Image("voice_logo")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .scaledToFill()
            }
            if isSpeaking == false {
                Text("Use Voice ID")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom(CustomFontNames.NunitoSans_Bold, size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hexString: CustomColors.black))
                
                Text("Repeat the following words to capture your voice to Login “My voice is my password”")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hexString: CustomColors.gray))
            }
            Text("My voice is my password")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(hexString: CustomColors.lightBlue))
            if isSpeaking{
                LottieView(name: LottieFiles.VOICE_RECORDING,loopMode:.loop)
                    .frame(width: 100,height: 100)
            }
            
            CustomButtonFilled(
                action: {
                    if isSpeaking {
                        action()
                        //isSpeaking = false
                    }else{
                        isSpeaking = true
                    }
                    
                },
                title: isSpeaking == false ? "SPEAK" : "STOP",
                bgColor: Color(hexString:CustomColors.lightBlue),
                textColor: Color.white,
                paddingVertical:12
            )
            
            
        }
    }
}



