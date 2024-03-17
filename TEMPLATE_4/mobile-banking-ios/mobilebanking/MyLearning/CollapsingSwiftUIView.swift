//
//  CollapsingSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 21/02/2024.
//

import SwiftUI
import MBCore

struct CollapsingSwiftUIView: View {
    @State var offset:CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top){
            
            ///*
            ZStack{
                Color.red
                    .frame(width: getScreenBound().width,height: 350)
                    .clipShape(
                        CustomCorner(corners: [.bottomLeft], radius: getCornerRadius())
                    )
                    .opacity( 1 + getProgress())
                
                //
                CustomCorner(corners: [.bottomLeft], radius: getCornerRadius()).fill(.ultraThinMaterial)
                //Rectangle().fill(.pink).cornerRadius(getCornerRadius())
                
                //
                let progress = -getProgress() < 0.4 ? getProgress() : -0.4
                
                VStack{
                    Circle().fill(.black)
                        .aspectRatio(.infinity, contentMode: .fill)
                        .frame(width: 100,height: 100)
                        .clipShape(Circle())
                        .scaleEffect(1 + progress * 1.3 ,anchor: .bottomLeading)
                    
                    //
                    Text("Daniel")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .scaleEffect(1 + progress * 1.3 ,anchor: .topTrailing)
                        .offset(x:progress * -40, y:progress * 100)
                    
                    
                }
                .padding(16)
                .padding(.bottom,32)
                .offset(y: progress * -200)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomLeading)
                
            }
            .frame(height: 350)
            //Moving up...
            .offset(y:getOffset())
            .zIndex(1)
            //*/
            
            ScrollView{
                
                VStack{
                    ForEach(0..<40){_ in
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity)
                    }
                    //Spacer()
                }
                .padding()
                .background(Color.blue)
                .frame(maxWidth: .infinity)
                .padding(.top,350)
                //.offset(y:350)
                .padding(.top,-getSafaArea().top)
                .modifier(OffsetModifier(offset: $offset))
            }
            
            
        }.ignoresSafeArea(.container, edges: .top)
    }
    
    func getOffset()-> CGFloat{
        
        //Stopping when navbar is size 80
        let checkSize = -offset < (280 - getSafaArea().top) ? offset: -(280 - getSafaArea().top)
        //return offset < 0 ? offset : 0
        return offset < 0 ? checkSize : 0
    }
    
    //
    func getProgress()->CGFloat {
        let topheight = (280 - getSafaArea().top)
        let progress = getOffset() / topheight
        
        return progress
    }
    //
    func getCornerRadius()->CGFloat {
        let radius = getProgress() * 45
        //
        return 45 + radius
    }
}

struct CustomCorner:Shape{
    var corners: UIRectCorner
    var radius:CGFloat
    
    func path(in rect: CGRect) -> Path {
        //let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let path = Path(roundedRect: rect, cornerSize: CGSize(width: 0, height: 0))
        
        return Path(path.cgPath)
    }
}
