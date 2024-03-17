//
//  CustomToggle.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 25/09/2023.
//

import SwiftUI
import MBCore

struct CustomToggle2: View {
    @Binding  var isToggled:Bool

    var body: some View {
        Button(action: {
            isToggled.toggle()
        }) {
            HStack {
                if isToggled {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 24))
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                        .font(.system(size: 24))
                }

//                Text(isToggled ? "On" : "Off")
//                    .font(.headline)
//                    .foregroundColor(.primary)
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 3)
        }
    }
}



struct CustomToggle: View {
    @Binding var isToggled: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 56, height: 28)
                .foregroundColor(isToggled ? Color(hexString: CustomColors.green).opacity(0.5) : Color(hexString: CustomColors.gray).opacity(0.5))

            RoundedRectangle(cornerRadius: 20)
                .frame(width: 28, height: 28)
                //.foregroundColor(.white)
                .foregroundColor(isToggled ? Color(hexString: CustomColors.green) : Color(hexString: CustomColors.gray))
                .offset(x: isToggled ? 17 : -17)
                .animation(.easeInOut)
        }
        //.onTapGesture {
            //isToggled.toggle()
            //Logger(isToggled)
        //}
    }
}


struct CustomToggleView: View {
   var isToggled: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 56, height: 28)
                .foregroundColor(isToggled ? Color(hexString: CustomColors.green).opacity(0.5) : Color(hexString: CustomColors.gray).opacity(0.5))

            RoundedRectangle(cornerRadius: 20)
                .frame(width: 28, height: 28)
                //.foregroundColor(.white)
                .foregroundColor(isToggled ? Color(hexString: CustomColors.green) : Color(hexString: CustomColors.gray))
                .offset(x: isToggled ? 17 : -17)
                .animation(.easeInOut)
        }
        //.onTapGesture {
            //isToggled.toggle()
            //Logger(isToggled)
        //}
    }
}





struct ToggleView: UIViewRepresentable {
    @Binding var isOn: Bool
    var onToggle: ((Bool) -> Void)?

    func makeUIView(context: Context) -> UISwitch {
        let toggle = UISwitch()
        toggle.isOn = isOn
        toggle.addTarget(context.coordinator, action: #selector(Coordinator.switchValueChanged(_:)), for: .valueChanged)
        return toggle
    }

    func updateUIView(_ uiView: UISwitch, context: Context) {
        uiView.isOn = isOn
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: ToggleView

        init(_ parent: ToggleView) {
            self.parent = parent
        }

        @objc func switchValueChanged(_ sender: UISwitch) {
            parent.isOn = sender.isOn
            parent.onToggle?(sender.isOn)
        }
    }
}


