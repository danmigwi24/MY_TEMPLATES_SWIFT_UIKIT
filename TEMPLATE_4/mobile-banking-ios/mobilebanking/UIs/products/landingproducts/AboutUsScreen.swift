//
//  AboutUsScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore



struct AboutUsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsScreen()
    }
}


struct AboutUsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var activeTag: AboutUsItemModel = ABOUT_US_ITEMS[0]
    
    @State var titleFromScelection = "Who we are."
    
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    //
    var body: some View {
        MainContent()
    }
    
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension AboutUsScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry:geometry)
                    .frame(width: geometry.size.width,height: geometry.size.height)
                       
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
        .navigationBarTitle("About Us",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundColor(Color.blue)
                    }
                })
            }
        }
        .toolbar {
            /*
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                        self.navigateToContinue.toggle()
                    
                }, label: {
                    Text("Next")
                        .foregroundColor(Color.blue)
                })
            }
             */
        }
        
    }
    
    
    
    //MARK: SET UP UI
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            NavigationLink("", destination: Text(""), isActive: $navigateTo)
            VStack(spacing: 0){
                //
                ContentView(geometry: geometry)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
                
               
               // Spacer()
                //*/
                
            }
        }
    }
    
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollViewReader {_ in 
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing:0){ //
                    TopPartView().vSpacingWithMaxWidth(.leading)
                    //
                    FilterSection()
                        .padding(.horizontal,4)
                        .padding(.vertical,4)
                    
                    ActiveTagView()
                    
                }
            }.edgesIgnoringSafeArea([.horizontal])
        }
    }
    
    
    
    @ViewBuilder
    func TopPartView() -> some View {
        VStack{
            ZStack(alignment: Alignment.top){
                Image("about_us")
                    .resizable()
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    .frame(height: 150)
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.horizontal])
                
                VStack{
                    CustomSpacer(height: 60)
                    CustomTextBold(
                        text: titleFromScelection,//"We’ve received many awards, certifications & partnerships.",
                        textColor: .white,
                        fontSize: 28,
                        textAlignment: TextAlignment.leading
                    ) .vSpacingWithMaxWidth(.bottomLeading)
                }.padding(.horizontal,10)
                
            }
            
        }
        //.background(Color.red)
        .vSpacingWithMaxWidth(.leading)
    }
    
    
    
    //MARK: FILTER
    @ViewBuilder
    func FilterSection() -> some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(ABOUT_US_ITEMS, id: \.id) { item in
                        AboutUsItem(item: item)
                    }
                    //
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
        .frame(maxWidth: .infinity)
        //.background(Color.blue)
    }
    
    @ViewBuilder
    func AboutUsItem(item:AboutUsItemModel)-> some View {
        VStack{
            Button(action: {
                
            }) {
                VStack {
                    Text(item.title)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14))
                        .foregroundColor(activeTag.id == item.id ? Color(hexString:CustomColors.white) : Color.gray)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                                activeTag.id = item.id
                                activeTag = item
                            }
                        }
                        .padding(10)
                        .background(
                            VStack{
                                if activeTag.id == item.id {
                                    // RoundedRectangle(cornerRadius: 20)
                                    Capsule()
                                        .fill(Color(hexString: CustomColors.darkBlue))
                                        .foregroundColor(Color(hexString: CustomColors.darkBlue))
                                    
                                }else{
                                    // RoundedRectangle(cornerRadius: 20)
                                    Capsule()
                                        .stroke(Color.black, lineWidth: 1)
                                    
                                }
                            }
                        )
                    
                }.padding(.horizontal, 10)
            }
        }
    }
    
    @ViewBuilder
    func FilteredDataView() -> some View {
        VStack{
            ForEach(listOfTypeOfAccountModel) { item in
                Text(item.title)
            }
        }
    }
    
    @ViewBuilder
    func ActiveTagView() -> some View {
       // ScrollView(.vertical,showsIndicators: false){
            VStack{
                if activeTag.id == 1 {
                    AboutUsWhoWeAreView()
                }else if activeTag.id == 2{
                    AwardsCertificationsScreen()
                }else if activeTag.id == 3{
                    OurCultureScreen()
                }else{
                    AboutUsWhoWeAreView()
                }
            //}
        }.padding(10)
            .frame(maxWidth: .infinity)
    }
}



struct AboutUsWhoWeAreView: View {
    
    @State var whoWeAreText = """
    We are a technology savvy company transforming Africa through the innovative, state of the art tailor-made software solutions for banking, financial, agricultural, transport & public sector.
    
    We operate on a sustainable commercial footing and are convinced that economic IMPACT is best achieved through developing a vibrant and resilient SME sector. Eclectics has been a market leader in the provision of affordable innovative solutions within the continent by being the center bolt upon which multiple transactions are anchored through our solutions.
    """
    
    
    
    var body: some View {
        ZStack {
            VStack{
                CustomTextRegular(text: whoWeAreText, textColor: Color.black, fontSize: 14, textAlignment: .leading)
                
                VStack{
                    //Mission
                    VStack{
                        CustomTextBold(text: "Mission", textColor: .black, fontSize: 16, textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                        CustomTextRegular(text: "Simplifying lives digitally.", textColor: .black, fontSize: 16, textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                    }
                    .padding(5)
                    .vSpacingWithMaxWidth(.leading)
                    .background(Color(hexString: CustomColors.lightGray))
                    .cornerRadius(10)
                    //Vision
                    VStack{
                        CustomTextBold(text: "Vission", textColor: .black, fontSize: 16, textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                        CustomTextRegular(text: "To be a trusted provider of quality and affordable digital solutions.", textColor: .black, fontSize: 16, textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                    }
                    .padding(5)
                    .vSpacingWithMaxWidth(.leading)
                    .background(Color(hexString: CustomColors.lightGray))
                    .cornerRadius(10)
                    //Focus
                    VStack{
                        CustomTextBold(text: "Focus", textColor: .black, fontSize: 16, textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                        CustomTextRegular(text: "Provision of affordable state of the art IT solutions for African financial market.", textColor: .black, fontSize: 16, textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                    }
                    .padding(5)
                    .vSpacingWithMaxWidth(.leading)
                    .background(Color(hexString: CustomColors.lightGray))
                    .cornerRadius(10)
                    
                }.padding(.vertical,10)
            }
            
        }
    }
}





