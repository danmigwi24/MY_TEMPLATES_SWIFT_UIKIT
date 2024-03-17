import SwiftUI
import MBCore

public struct CustomDialog: View {
    @Binding var isActive: Bool

    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = 1000

    public var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .onTapGesture {
                    close()
                }

            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()

                Text(message)
                    .font(.body)

                Button {
                    action()
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(hexString: CustomColors.blue))

                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .overlay(alignment: .topTrailing) {
//                Button {
//                    close()
//                } label: {
//                    Image(systemName: "xmark")
//                        .font(.title2)
//                        .fontWeight(.medium)
//                }
//                .tint(.black)
//                .padding()
//            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive.toggle()
        }
    }
}



struct CustomDialogSampleView: View {
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            VStack {
                Text("Hi Daniel")
                Spacer()
                Button {
                    isActive.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(hexString: CustomColors.blue))

                        Text("SHOW DIALOG")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .fixedSize(horizontal: true, vertical: true)
                    //.frame(width: 200, height: 55)
                    .padding()
                }
                
            }
            .padding()

            if isActive {
                CustomDialog(isActive: $isActive, title: "Access photos?", message: "This lets you choose which photos you want to add to this project.", buttonTitle: "Give Access") {
                    Logger("Pass to viewModel")
                }
            }
        }
    }
}

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        //CustomDialog(isActive: .constant(true), title: "Access photos?", message: "This lets you choose which photos you want to add to this project.", buttonTitle: "Give Access", action: {})
        
        CustomDialogSampleView()
    }
}
