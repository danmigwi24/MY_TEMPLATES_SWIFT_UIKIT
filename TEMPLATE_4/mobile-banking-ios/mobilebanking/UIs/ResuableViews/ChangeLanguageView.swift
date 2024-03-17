//
//  ChangeLanguageView.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 07/02/2024.
//


import SwiftUI
import MBCore
import Combine
import Localize_Swift


struct CurrentLanguageKey: EnvironmentKey {
    static let defaultValue: Binding<String> = .constant("en")
}

extension EnvironmentValues {
    var currentLanguage: Binding<String> {
        get { self[CurrentLanguageKey.self] }
        set { self[CurrentLanguageKey.self] = newValue }
    }
}


struct ChangeLanguageView: View {
    @Binding var languageModelOption: LanguageModel
    //
    var body: some View {
        LanguageView()
    }
    
    @ViewBuilder
    func LanguageView()->some View{
        VStack{
            //Text("LocalizeSwiftUIView.welcome_message".localized())
            HStack{
                Menu(content: {
                    VStack{
                        ForEach(0..<LANGUAGEPICKER.count , id: \.self) { item in
                            Button(action: {
                                languageModelOption = LANGUAGEPICKER[item]
                                setCurrentLanguage(lang: languageModelOption.languageAbbreviation)
                            }, label: {
                                VStack{
                                    Text("\(LANGUAGEPICKER[item].languageFlag) \(LANGUAGEPICKER[item].languageAbbreviationInCaps)")
                                        .foregroundColor(Color.black)
                                        .font(.custom(CustomFontNames.NunitoSans_Regular, size: 24).weight(.bold))
                                        .padding(.horizontal,20)
                                        .frame(minWidth: 130)
                                }
                            }).padding(20)
                            
                        }
                    }
                },label: {
                    HStack{
                        Text("\(languageModelOption.languageFlag) \(languageModelOption.languageAbbreviationInCaps)")
                            .foregroundColor(Color.black)
                            .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16).weight(.bold))
                            .padding(.horizontal,20)
                            
                        //Spacer()
                        Image(systemName: "arrowtriangle.down.fill")
                            .frame(width: 18,height: 15)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }.padding(.horizontal,12)
                })
                .padding(.vertical,10)
                .padding(.leading,10)
                .background(
                    RoundedRectWithBottomLeftCorner(bg: Color.white,cornerRadius:20).edgesIgnoringSafeArea([.trailing])
                )
                
            }.vSpacingWithMaxWidth(.topTrailing)
        }
        /*
        .onReceive(Just(languageModelOption)) { index in
            //viewModel.setCurrentLanguage(LANGUAGEPICKER[index].languageAbbreviation)
            print("SELECTED LANGUAGE IS \(languageModelOption)")
            saveUserData(key: USERDEFAULTS.USER_LANGUAGE, data: languageModelOption.languageAbbreviation)
         }
        */
        .onChange(of: languageModelOption) { newvalue in
            print("SELECTED LANGUAGE IS \(languageModelOption)")
        }
        .onAppear{
            let currentLang = getUserData(key: USERDEFAULTS.USER_LANGUAGE)
            Localize.setCurrentLanguage(currentLang)
            if currentLang == "en"{
                languageModelOption = LANGUAGEPICKER[0]
            }else if currentLang == "fr"{
                languageModelOption = LANGUAGEPICKER[1]
            }else if currentLang == "pt-PT"{
                languageModelOption = LANGUAGEPICKER[2]
            }else{
                languageModelOption = LANGUAGEPICKER[0]
            }
        }
    }
}


struct RoundedRectView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let path = UIBezierPath(roundedRect: uiView.bounds,
                                byRoundingCorners: [.bottomLeft],
                                cornerRadii: CGSize(width: 20, height: 20))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        uiView.layer.mask = shapeLayer
    }
}

struct RoundedRectWithBottomRightCorner: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let cornerRadius: CGFloat = 20
                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
                path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
                
                path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                            radius: cornerRadius,
                            startAngle: .degrees(00),
                            endAngle: .degrees(90),
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: 0, y: height))
                path.closeSubpath()
            }
            .fill(Color.blue) // Change color as needed
        }
    }
}

struct RoundedRectWithBottomLeftCorner: View {
    
    var bg :Color
    var cornerRadius: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                //let cornerRadius: CGFloat = 20
                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
                path.addLine(to: CGPoint(x: width, y: height))
                path.addLine(to: CGPoint(x: cornerRadius, y: height)) // Updated this line
                
                path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius), // Updated this line
                            radius: cornerRadius,
                            startAngle: .degrees(90), // Updated this line
                            endAngle: .degrees(180), // Updated this line
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: 0, y: cornerRadius)) // Updated this line
                path.closeSubpath()
            }
            .fill(bg) // Change color as needed
        }
    }
}









struct Test_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RoundedRectWithBottomLeftCorner(bg: Color.gray,cornerRadius:30)
                .frame(width: 200, height: 100)
            
            RoundedRectWithBottomRightCorner()
                .frame(width: 200, height: 100)
            
            RoundedRectView()
                .frame(width: 200, height: 100)
                .background(Color.blue)
                .padding(20)
            
            
            Rectangle().cornerRadius(.leastNormalMagnitude)
                .frame(width: 200, height: 100)
            
        }
        
        
        
    }
}
