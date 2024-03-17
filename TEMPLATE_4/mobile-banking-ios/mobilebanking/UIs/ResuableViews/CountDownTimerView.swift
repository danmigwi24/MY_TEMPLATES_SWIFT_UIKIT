//
//  CountDownTimerView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import SwiftUI
import MBCore

struct CountDownTimerView: View {
    //
    @Binding var remainingTime: Int
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var resendTitle:String
    
    var body: some View {
        VStack{
            CustomTextSemiBold(
                text: "\(resendTitle) : \(formatTimeToShowMinandSeconds(seconds: remainingTime))",
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 16,
                textAlignment: TextAlignment.center
            )
            
            .padding(.vertical,12)
                .vSpacingWithMaxWidth(.center)
                .onReceive(timer) { _ in
                    if remainingTime > 0 {
                        remainingTime -= 1
                    }
                }
        }.frame(maxWidth: .infinity,alignment: .center)
    }
}

struct CountDownTimerView_Previews: PreviewProvider {
    
    //@State private var remainingTime: Int = 120
    
    static var previews: some View {
       // CountDownTimerView(remainingTime: 120, resendTitle: "")
        Text("")
    }
}
