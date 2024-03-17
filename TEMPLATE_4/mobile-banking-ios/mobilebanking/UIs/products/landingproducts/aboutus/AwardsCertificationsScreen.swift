//
//  AwardsCertificationsScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 14/02/2024.
//

import Foundation
import SwiftUI
import MBCore


struct AwardsCertificationsScreen : View {
    var body: some View{
        VStack{
            SetUiSection()
        }
        
    }
    
    @ViewBuilder
    func SetUiSection() -> some View{
        VStack{
            CustomTextRegular(
                text: "As an endorsement of the Fintech that Eclectics International is, the company has received several industry certifications, awards and partnerships over the years.",
                textColor: Color(hexString: CustomColors.black),
                fontSize: 14,
                textAlignment: .leading
            )
            
            ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            
                            let data = (1...20).map { $0 }
                            
                            ForEach(listOfAwardsAndCertificationsModel, id: \.self) { item in
                                AwardsCertificationSection(item: item)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        
                    }
        }
    }
    
    @ViewBuilder
    func AwardsCertificationSection(item:AwardsAndCertificationsModel) -> some View{
        VStack(spacing: 0){
            Image(item.image)
                .resizable()
                .frame(minWidth: 80,maxWidth: 100,minHeight: 50,maxHeight: 70)
                //.frame(width: 55,height: 100)
                .scaledToFit()
                .padding(.horizontal,40)
                
            CustomTextSemiBold(
                text: item.title,
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 16,
                textAlignment: .center
            )
            
            CustomTextRegular(
                text:item.description,
                textColor: Color(hexString: CustomColors.gray),
                fontSize: 12,
                textAlignment: .center
            )
            
            CustomTextMedium(
                text: item.date,
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 12,
                textAlignment: .center
            )
            
        }.padding(.vertical,10)
        .background(Color(hexString: CustomColors.lightGray))
            .cornerRadius(10)
            //.padding(10)
    }
}
