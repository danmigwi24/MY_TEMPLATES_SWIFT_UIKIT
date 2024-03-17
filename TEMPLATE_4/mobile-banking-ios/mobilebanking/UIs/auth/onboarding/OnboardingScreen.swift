//
//  ContentView.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 06/02/2024.
//

import SwiftUI
import MBCore

struct OnboardingScreen: View {
    var screenWidth = UIScreen.main.bounds.width
    @State var xOffset:CGFloat = 0
    @State private var currentStep = 0
    var lastPage = onboardingList.count - 1
    var firstPage = 0
    @Namespace var namespace
    
    //
    @State var showGrantPermision:Bool = false
    //MARK: ViewModels
    @StateObject var sharedViewModel = SharedViewModel()
    
    var body: some View {
        MainContent()
    }
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension OnboardingScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        ZStack{
            Color(hexString: CustomColors.white).edgesIgnoringSafeArea(.all)
            VStack{
                GeometryReader { geometry in
                    //
                    LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                        SetUpUI()
                    //
                    }
                    
                }
                
            }
        }
        .onAppear {
           
        }
        .alert(isPresented: $sharedViewModel.showAlert){
            CustomAlert(
                isPresented: $sharedViewModel.showAlert,
                title: "Info",
                decription: sharedViewModel.alertMessage
            )
        }
        .actionSheet(isPresented: self.$sharedViewModel.showActionSheet) {
            CustomActionSheet(
                isPresented: $sharedViewModel.showActionSheet,
                title: "Info",
                decription: sharedViewModel.actionSheetMessage
            )
        }
        .navigationBarItems(
            leading: Button(action: {
                //backAction()
            }, label: {
                VStack{
                    //ADD your Header
                }
            })
        )
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI() -> some View {
        ZStack{
            //
            ViewContent()
            //ViewWithPageViewContent()
            //
            if showGrantPermision {
                GrantPermissionView(show: $showGrantPermision)
            }
            //
            
        }
    }
 
  
    
    @ViewBuilder
    func ViewContent()->some View{
        ZStack{
            GeometryReader{reader in
                HStack(spacing: 0) {
                    ForEach(onboardingList){item in
                        OnaboardingView(
                            item: item,
                            currentStep: $currentStep,
                            //languageModelOption: $languageModelOption,
                            onboardingList: onboardingList
                        )
                    }
                }
                .offset(x:xOffset)
                //.content.offset(x:xOffset)
                .gesture(DragGesture()
                    .onChanged({value in
                        onChange(value: value)
                    })
                    .onEnded({value in
                            onEnd(value: value)
                        })
                         
                )
                .onAppear {
                    //startAutoScroll()
                    saveUserDataBool(key: USERDEFAULTS.IS_FIRST_TIME_INSTALL, data: true)
                }
            }
            //MARK: BUTTON
            VStack(spacing: 20) {
                Spacer()
                /*
                 If You wish indictors to be at the bottom of views
                 */
                //
                ZStack{
                    VStack{
                        if currentStep != lastPage{
                            CustomButtonFilled(
                                action: {
                                    // currentStep = lastPage
                                    currentStep += 1
                                    withAnimation{
                                        xOffset = -screenWidth * CGFloat(currentStep)
                                    }
                                },
                                title: "Get Started",
                                bgColor: Color(hexString: CustomColors.blue),
                                textColor:Color(hexString: CustomColors.white)
                            )
                        }else{
                            //NavigationLink(destination: HUDProgressAlertTextFieldPopupsView(), label: {
                                CustomButtonFilled(
                                    action: {
                                        //
                                        withAnimation{
                                            showGrantPermision.toggle()
                                            saveUserDataBool(key:USERDEFAULTS.HAS_SEEN_ONBOARDING, data: true)
                                        }
                                    },
                                    title: "Get Started",
                                    bgColor: Color(hexString: CustomColors.blue),
                                    textColor:Color(hexString: CustomColors.white)
                                )
                               
                           // })
                           
                        }
                    } .padding(.bottom,16)
                    .padding(.horizontal)
                    //
                }
                //
            }
        }
    }
    
    
    
    func onChange(value:DragGesture.Value)  {
        xOffset = value.translation.width - (screenWidth * CGFloat(currentStep))
    }
    
    func onEnd(value:DragGesture.Value)  {
        if -value.translation.width > screenWidth/2 && currentStep < lastPage{
            currentStep += 1
        }else{
            if value.translation.width > screenWidth/2 && currentStep > firstPage {
                currentStep -= 1
            }
        }
        withAnimation{
            xOffset = -screenWidth * CGFloat(currentStep)
        }
    }
    
    func startAutoScroll() {
        // Start automatic scrolling using Timer
        Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { timer in
                // Adjust xOffset to scroll to the next item
                xOffset -= UIScreen.main.bounds.width

            if abs(xOffset) >= UIScreen.main.bounds.width * CGFloat(onboardingList.count) {
                // Reset xOffset to start when reaching the end
                xOffset = 0
            }
        }
    }
}

struct OnaboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}


struct OnaboardingView: View {
    
    let item:OnboardingItem
    @Binding var currentStep:Int
   // @Binding var languageModelOption: LanguageModel
    var onboardingList:[OnboardingItem]
    
    @Namespace var namespace
    
    @State var languageModelOption: LanguageModel = LANGUAGEPICKER[0]
    
    var body: some View {
        ZStack{
            //
            Image(item.backGroundImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.all,.horizontal])
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
    
            VStack(spacing:0){
               //Language Change
                ChangeLanguageView(languageModelOption: $languageModelOption)
                //Logo
                Image("mb_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:120,height: 120)
                    //.padding(30)
                
                
                //Content
                ContentView()
            }
        }
    }
    
    
    

    
    
    @ViewBuilder
    func ContentView()->some View{
        VStack{
            Spacer()
            IndicatorView()
            
            Text(item.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CustomFontNames.NunitoSans_Bold, size: 24))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(hexString: CustomColors.white))
                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
            
            Text(item.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CustomFontNames.NunitoSans_SemiBold, size: 18))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(hexString: CustomColors.white))
                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
            //.padding(.vertical, 8)
                .padding(.horizontal, 8)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func IndicatorView()->some View{
        ZStack {
            HStack(spacing: 10){
                ForEach(0..<onboardingList.count){i in
                    if i == currentStep{
                        Circle()
                            .matchedGeometryEffect(id: "page", in: namespace)
                            .frame(width: 6,height: 6)
                            .animation(.default)
                            .foregroundColor(.white)
                    }else{
                        Circle()
                            .frame(width: 6,height: 6)
                            .foregroundColor(.gray)
                    }
                }
            }
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.4))
                )
        }
    }
    
}






struct OnboardingItem:Identifiable{
    let id = UUID().uuidString
    let backGroundImage:String
    let title:String
    let description:String
}

let onboardingList = [
    OnboardingItem(
        backGroundImage: "onboarding_1",
        title: "Mobile banking made simple, Reliable and easy for all",
        description: "We simplify your banking life digitally To enhance your transactions to be Seamless and convenient"
    ),
    OnboardingItem(
        backGroundImage: "onboarding_2",
        title: "No more queuing at the bank, Create your own account",
        description: "You can now do a self registration via the App with out need of going to the nearest Bank branch"
    ),
    OnboardingItem(
        backGroundImage: "onboarding_3",
        title: "Bank with us and safe guard Your future",
        description: "Make investments, join champs and access More financial inclusion for you, your family & friends"
    ),
    
]





