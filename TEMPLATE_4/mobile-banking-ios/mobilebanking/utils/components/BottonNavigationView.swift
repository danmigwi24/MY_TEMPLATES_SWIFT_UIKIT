//
//  BottonNavigationView.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 10/10/2023.
//

import Foundation
import SwiftUI
import MBCore

struct BottonNavigationView: View {
    @State var index:Int = 0
    var body: some View{
            VStack{
                //Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                ZStack{
                    TabView(selection: $index){
                        Text("Home")
                            .padding(.top,10)
                            .padding(.bottom,30)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .tag(0)
                        
                        //AllPolociesScreen().padding(.bottom,30).frame(maxWidth: .infinity,maxHeight: .infinity)
                        Text("Explore")
                            .padding(.top,10)
                            .padding(.bottom,30)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .tag(1)
                        
                        Text("Start")
                            .padding(.top,10)
                            .padding(.bottom,30)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .tag(2)
                        //
                        Text("Activity")
                            .padding(.top,10)
                            .padding(.bottom,30)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .tag(3)
                            //
                        Text("Profile")
                            .padding(.top,10)
                            .padding(.bottom,30)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .tag(4)
                        
                    }

                }
                .padding(.bottom, -35)
                CustomTabs(index: self.$index)
            }//.background(Color.gray.opacity(0.2).edgesIgnoringSafeArea(.top))
        
    }
}

struct CustomTabs: View {
    @Binding var index: Int
    //@State var centerAction: () -> ()
    
    var body: some View{
        HStack(spacing:10){
            
            SingleTab(
                title: "Home",
                icon: "tab_home",
                foreGroundColor: self.index == 0 ? Color(hexString: CustomColors.blue) : .gray.opacity(0.5),
                action: {
                    self.index = 0
                }
            ).padding(.leading,10)
            
            Spacer(minLength: 0)
            
            SingleTab(
                title: "Explore",
                icon: "tab_explore",
                foreGroundColor: self.index == 1 ?  Color(hexString: CustomColors.blue) : .gray.opacity(0.5),
                action: {
                    self.index = 1
                }
            )
            Spacer(minLength: 0)
            //MARK: START ACTIVITY
            Button(action: {
                self.index = 2
            }, label: {
                ZStack {
                            Circle()
                                .fill(Color(hexString: CustomColors.blue))
                                //.stroke(Color.blue, lineWidth: 2) // Circle border color and width
                                //.frame(width: 30, height: 30) // Circle dimensions
                            
                            Text("Start")
                                .font(.headline)
                                .foregroundColor(Color.white) // Text color
                        }
            }).offset(y: -25)
            
            Spacer(minLength: 0)
            
            SingleTab(
                title: "Activity",
                icon: "tab_activity",
                foreGroundColor: self.index == 3 ? Color(hexString: CustomColors.blue) : .gray.opacity(0.5),
                action: {
                    self.index = 3
                }
            )
            Spacer(minLength: 0)
            
            SingleTab(
                title: "Profile",
                icon: "tab_profile",
                foreGroundColor: self.index == 4 ?  Color(hexString: CustomColors.blue) : .gray.opacity(0.5),
                action: {
                    self.index = 4
                }
            ).padding(.trailing,10)
        }
        .background(Color.white)
       // .shadow(radius: 5)
        .padding(.vertical,20)
        .clipShape(CShape())
        //.edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    func SingleTab(title:String, icon:String,foreGroundColor:Color, action : @escaping () -> ()) -> some View{
        Button(action:
                action
               , label: {
            VStack(spacing: 5){
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 24,height: 24)
                    .foregroundColor(foreGroundColor)
                
                Text("\(title)")
                    .foregroundColor(foreGroundColor)
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14))
                    .frame(maxWidth: .infinity,alignment: .center)
            }
        }
        ).foregroundColor(foreGroundColor)
    }
}


struct CShape : Shape {
    func path(in rect: CGRect) -> Path {
        return  Path {path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            
            path.addArc(center: CGPoint(x: rect.width/2, y: 0), radius: 35, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
        }
    }
}
