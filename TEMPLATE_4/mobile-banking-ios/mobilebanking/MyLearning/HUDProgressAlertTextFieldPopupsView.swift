//
//  HUDProgressAlertTextFieldPopupsView.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 25/01/2024.
//

import SwiftUI
import MBCore

struct HUDProgressAlertTextFieldPopupsView: View {
    
    @State var nativeAlert = false
    @State var customAlert = false
    @State var HUD = false
    @State var userInput = ""
    
    var body: some View {
        ZStack{
            VStack(spacing:25){
                //
                Button(action: {
                    alertView()
                }, label: {
                    VStack{
                        Text("Native Alert With TextField")
                        
                    }
                })
                
                Text("User Imput is \(userInput)")
                //
                Button(action: {
                    HUD.toggle()
                }, label: {
                    VStack{
                        Text("HUD")
                        
                    }
                })
                //
                Button(action: {
                    customAlert.toggle()
                }, label: {
                    VStack{
                        Text("Custom Alert")
                        
                    }
                })
                //
            }
            
            if HUD {
                HUDProgressView(placeHolder: "Loading ...", show: $HUD).edgesIgnoringSafeArea(.all)
            }
            
            if customAlert {
                CustomSwiftUIDialog(showDialog: $customAlert) {
                    VStack(spacing: 25){
                        
                        Image("onboarding_1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50,height: 50)
                           
                        
                        Text("title")
                            .font(.title)
                            .foregroundColor(.black)
                            .vSpacingWithMaxWidth(.center)
                        Text("subtitble")
                            .font(.body)
                            .foregroundColor(.black)
                            .vSpacingWithMaxWidth(.center)
                        
                        Button(action: {
                            customAlert.toggle()
                        }, label: {
                            Text("buttonText")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical,10)
                                .padding(.horizontal,25)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .vSpacingWithMaxWidth(.center)
                            
                        })
                        
                    }.padding(.vertical,20).padding(.horizontal,20)
                }
                //CustomAlertView(show: $customAlert, title: "Title", subtitble: "Wow! you have done an amazing job kimani", buttonText: "Close")//.edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    func alertView() {
        let alert = UIAlertController(title: "Login",message:"Enter your activity name", preferredStyle: .alert)
        alert.addTextField{(pass) in
            pass.isSecureTextEntry = true
            pass.placeholder = "Password"
        }
        
        //
        let login = UIAlertAction(title: "Login", style: .default){_ in
            //
            
            userInput = alert.textFields?[0].text ?? ""
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive){_ in
            //
        }
        
        alert.addAction(cancel)
        alert.addAction(login)
        
        //
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true,completion: {
            //
        })
    }
}

struct HUDProgressAlertTextFieldPopupsView_Previews: PreviewProvider {
    static var previews: some View {
        HUDProgressAlertTextFieldPopupsView()
    }
}

struct HUDProgressView:View{
    var placeHolder:String
    @Binding var show:Bool
    @State var animate = false
    
    var body: some View{
        VStack(spacing:28){
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.primary,Color.primary.opacity(0)]), center: .center))
                .frame(width: 80,height: 80)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
            Text(placeHolder)
                .fontWeight(.bold)
        }
        .padding(.vertical,25)
        .padding(.horizontal,35)
        .background(BlurView())
        .cornerRadius(15)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
                .onTapGesture {
                    withAnimation{
                        show.toggle()
                    }
                }
        )
        .onAppear{
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        }
    }
}

struct BlurView:UIViewRepresentable{
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}


//
