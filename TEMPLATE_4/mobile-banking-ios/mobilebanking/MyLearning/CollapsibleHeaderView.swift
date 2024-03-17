//
//  CollapsibleHeaderView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 22/02/2024.
//

import Foundation
import SwiftUI
import MBCore

struct CollapsibleHeaderView: View {
    @State var offset:CGFloat = 0
    
    var body: some View {
        SetUpUI()
        
    }
    
    
    @ViewBuilder
    func SetUpUI()->some View  {
        GeometryReader{ geometry in
            ZStack(alignment: .top){
                
                let  height = geometry.size.height * 0.5
                ///*
                //MARK: HEADER VIEW
                ZStack{
                   
                    if -getProgress(geometry: geometry) < 1 {
                        Image("about_us")
                            .resizable()
                            .frame(width: getScreenBound().width)
                            .frame(height: height)
                            .scaledToFill()
                            .edgesIgnoringSafeArea([.horizontal])
                        //
                        WhenOpenView()
                            .padding(16)
                            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomLeading)
                    }else {
                        Color(hexString: CustomColors.darkBlue)
                            .frame(width: getScreenBound().width)
                            .frame(height: height)
                        WhenClosedView()
                            .padding(16)
                            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomLeading)
                    }
                    
                }
                .frame(height: height)
                //Moving up...
                .offset(y:getOffset(geometry:geometry))
                .zIndex(1)
                //*/
                
                //MARK: MAIN VIEW
                ScrollView{
                    VStack{
                        MainContentView()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top,height)
                    .padding(.top,-getSafaArea().top)
                    .modifier(OffsetModifier(offset: $offset))
                    /*
                    .overlay(
                     Rectangle()
                        .fill(Color.black)
                            .frame(height: 50) // Set the height of your sticky header
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .opacity(0.9)
                    , alignment: .top)
                     */
                }
                
                
                
            }
            //.ignoresSafeArea(.container, edges: .top)
        }
    }
    
    
}
//UI VIEWS
extension CollapsibleHeaderView{
    
    func WhenOpenView() -> some View {
        VStack{
            StickyHeaderView()
            
            CustomTextSemiBold(
                text: "My Account",
                textColor: .white,
                fontSize: 16,
                textAlignment: .leading)
            .vSpacingWithMaxWidth(.leading)
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                //.vSpacingWithMaxWidth(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                
                VStack{
                    HStack{
                        CustomTextSemiBold(
                            text: "Wallet Account",
                            textColor: Color(hexString: CustomColors.darkBlue),
                            fontSize: 16,
                            textAlignment: .leading)
                        .vSpacingWithMaxWidth(.leading)
                        Spacer()
                        Image("home_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24,height: 24)
                    }
                    
                    CustomTextSemiBold(
                        text: "Account No: ***********2345 - KES",
                        textColor: Color(hexString: CustomColors.darkBlue),
                        fontSize: 16,
                        textAlignment: .leading)
                    .vSpacingWithMaxWidth(.leading)
                    
                    
                    HStack{
                        VStack{
                            CustomTextSemiBold(
                                text: "Actual Balance",
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                            
                            CustomTextSemiBold(
                                text: "100000",
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                        }
                        Spacer()
                        VStack{
                            CustomTextSemiBold(
                                text: "Available Balance",
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                            
                            CustomTextSemiBold(
                                text: "100000",
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                        }
                    }
                    
                    //BUTTONS
                    
                    HStack{
                        CustomButtonStroke(
                            action: {},
                            title: "View Balance",
                            bgColor: Color.clear,
                            textColor: Color(hexString: CustomColors.darkBlue),
                            strokeColor: Color(hexString: CustomColors.darkBlue),
                            strokeWidth: 1,
                            paddingVertical: 4,
                            cornerRadius: 10
                        )
                        Spacer()
                        CustomButtonStroke(
                            action: {},
                            title: "Mini Statement",
                            bgColor: Color.clear,
                            textColor: Color(hexString: CustomColors.darkBlue),
                            strokeColor: Color(hexString: CustomColors.darkBlue),
                            strokeWidth: 1,
                            paddingVertical: 4,
                            cornerRadius: 10
                        )
                    }
                    
                }.padding(10)
            }
            
            CustomTextSemiBold(
                text: "Hello \(getUserData(key:USERDEFAULTS.USER_NAME)), what would you like to do?",
                textColor: .white,
                fontSize: 16,
                textAlignment: .leading)
            .vSpacingWithMaxWidth(.leading)
        }
    }
    
    func WhenClosedView() -> some View{
        VStack{
            StickyHeaderView()
        }
    }
    
    
    func MainContentView() -> some View{
        VStack{
            ///*
            ForEach(0..<40){index in
               
                Text(" Item \(index)")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                
            }
            //*/
        }
        .padding()
        .background(Color.blue)
    }
    
    
    
    func StickyHeaderView() -> some View{
        HStack{
            Image("mb_logo_card")
                .resizable()
                .frame(width: 54,height: 40)
                .aspectRatio(contentMode: .fill)
               
            Spacer()
            
            Image("mb_logo_card")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44,height: 30)
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44,height: 44)
                .clipShape(Circle())
                .foregroundColor(Color.white)
        }
    }
    
    
    
}

//BUSINESS LOGICS
extension CollapsibleHeaderView{
    
    func getOffset(geometry:GeometryProxy)-> CGFloat{
        let height = geometry.size.height * 0.45
        //Stopping when navbar is size 80
        let checkSize = -offset < (height - getSafaArea().top) ? offset: -(height - getSafaArea().top)
        //return offset < 0 ? offset : 0
        return offset < 0 ? checkSize : 0
    }
    
    //
    func getProgress(geometry:GeometryProxy)->CGFloat {
        let topheight = (250 - getSafaArea().top)
        let progress = getOffset(geometry: geometry) / topheight
        print(progress)
        return progress
    }
    //
    func getCornerRadius(geometry:GeometryProxy)->CGFloat {
        let radius = getProgress(geometry: geometry) * 45
        //
        return 45 + radius
    }
}

extension View {
    func getScreenBound()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getSafaArea() -> UIEdgeInsets {
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return null
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return null
        }
        
        return safeArea
    }
}


struct OffsetModifier:ViewModifier {
    @Binding var offset :CGFloat
    @State var startOffset:CGFloat = 0
    //
    func body(content:Content) -> some View {
        
        content.overlay (
            
            GeometryReader{proxy in
                Color.clear
                    .preference(key: OffsetKey.self, value: proxy.frame(in: .global).minY)
            }
        ).onPreferenceChange(OffsetKey.self) { offset in
            if startOffset == 0{
                startOffset = offset
            }
            self.offset = offset
            //print(offset)
        }
    }
}


struct OffsetKey:PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue:()->CGFloat){
        value = nextValue()
    }
}


/*
 
 
 */

