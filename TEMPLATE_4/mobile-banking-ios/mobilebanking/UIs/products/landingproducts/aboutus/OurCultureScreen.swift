//
//  OurCultureScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 14/02/2024.
//

import SwiftUI
import MBCore

struct OurCultureScreen: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing: 0){
                SetUpUiSection()
            }
        }
    }
    
    
    @ViewBuilder
    func SetUpUiSection()->some View {
        VStack{
            CustomTextRegular(
                text: "Our culture is inclusive and inspirational. We believe in empowering our people to think and act independently. It’s core to our success. Empowered people are motivated, proactive, and have a sense of clarity.",
                textColor: Color(hexString: CustomColors.black),
                fontSize: 16,
                textAlignment: .leading
            )
            HappinessSection()
            
            CustomerExperienceSection()
            
            ButtonSection()
        }
    }
    
    func HappinessSection()->some View {
        VStack{
            HStack{
                Image("happiness")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                VStack(alignment: .leading,spacing:0){
                    CustomTextBold(
                        text: "Happiness",
                        textColor: Color(hexString: CustomColors.darkBlue),
                        fontSize: 16,
                        textAlignment: .leading
                    )
                    .vSpacingWithMaxWidth(.leading)
                    
                    
                    CustomTextRegular(
                        text: "We believe it, we live it, we share it. Happiness plays a central part of our organization through the below ways:",
                        textColor: Color(hexString: CustomColors.black),
                        fontSize: 14,
                        textAlignment: .leading
                    ).vSpacingWithMaxWidth(.leading)
                    
                    Spacer()
                }
            }
            
            let moreDetails = """
                        Games aren’t only for kids, yes you heard it well. We have happy hour on Fridays from 3pm.The team engages in several games such as Play Station and boardgames.
                        
                        On Fridays, we go casual. Not only does this create a more relaxing environment but it also encourages interaction between colleagues which is proven to boost happiness.
                        
                        We take time to celebrate wins by having get togethers. This is done by sharing a meal together, either lunch or dinner or having cake and also rewarding the team members for a job well done. We offer support for everyone in the team that achieves a milestone in life by coming together to celebrate the person during special occasions. This is done whenever we have new hires, new borns, birthdays, graduations and weddings.
                        
                        All work and no play is not good for the soul. We regularly participate in outdoor activities like hikes, team building activities and tours around our beautiful country. Excellent customer experience can only be achieved if the people who must give it are happy. Our Customer Experience and Support Department are making it easy for all of us to find a reason to smile and wow our clients which in turn enables us to always deliver the best.
                        
                        Fun in the workplace has fostered more positive attitudes among our teams which has resulted in us becoming more cohesive and helping each employee deal with or recover from stressful work experiences while also developing stronger relationships.
                        """
            
            CustomTextRegular(
                text: moreDetails,
                textColor: Color(hexString: CustomColors.black),
                fontSize: 14,
                textAlignment: .leading
            ).vSpacingWithMaxWidth(.leading)
        }
    }
    
        
    func CustomerExperienceSection()->some View {
        VStack{
            HStack{
                VStack(alignment: .leading,spacing:0){
                    CustomTextBold(
                        text: "Customer Experience",
                        textColor: Color(hexString: CustomColors.darkBlue),
                        fontSize: 16,
                        textAlignment: .leading
                    )
                    .vSpacingWithMaxWidth(.leading)
                    
                    
                    CustomTextRegular(
                        text: "Customers are at the centre of our thinking and actions. WOW is such a short, simple word, but it really encompasses a lot of things that we believe in Eclectics when it comes to our customers.",
                        textColor: Color(hexString: CustomColors.black),
                        fontSize: 14,
                        textAlignment: .leading
                    ).vSpacingWithMaxWidth(.leading)
                    
                    Spacer()
                }
                
                Image("happiness")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
            }
            
            let moreDetails = """
                        To WOW, you must differentiate yourself, which means do something a little unconventional and innovative.
                        
                        You must WOW (go above and beyond what’s expected) in every interaction with co-workers, vendors, customers, the community, investors – with everyone. Whatever you do must have an emotional impact on the receiver. We are not an average company, our service is not average, and we don’t want our people to be average. We expect every employee to deliver WOW.
                        
                        Whether internally with co-workers or externally with our customers and partners, delivering WOW results is our believe.
                        """
            
            CustomTextRegular(
                text: moreDetails,
                textColor: Color(hexString: CustomColors.black),
                fontSize: 14,
                textAlignment: .leading
            ).vSpacingWithMaxWidth(.leading)
        }
    }
    
    
    @ViewBuilder
    func ButtonSection()->some View{
        VStack{
            Button(action: {
                
            }, label: {
                HStack{
                    CustomTextRegular(text: "Find Out more", textColor: Color(hexString: "#F69414"), fontSize: 14, textAlignment: .center)
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .frame(width: 18,height: 15)
                        .scaledToFit()
                        .foregroundColor(Color(hexString: "#F69414"))
                }
            })
        }
    }
}

struct OurCultureScreen_Previews: PreviewProvider {
    static var previews: some View {
        OurCultureScreen()
    }
}
