//
//  Validators.swift
//  MB
//
//  Created by Damaris Muhia on 19/07/2023.
//

import Foundation
//MARK: Validators
extension String{
    func isValidEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    func validPhoneNumber()->String{
        var phone = self
        if phone.isEmpty{
            return "nil"
        }
        
        if phone.lengthOfBytes(using: .utf8) != 7 {
            return "nil"
        }
        return "\(phone.onlyDigits())"//.dropWhiteSpace()
    }
    func phoneNumberWithCountryCode()->String{
        var phone = self.onlyDigits()//.dropWhiteSpace()
        debugPrint("PhonePhonePhone is \(phone)")
        if(self.count == 10 && self.starts(with: "")){
            phone = String(phone.dropFirst(3))
        }
        if(self.count > 10 ){
            phone = String(phone.suffix(7))
        }
        return "\(phone)"
    }
    

}
//MARK: FORMATTERS
extension String{
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
       // formatter.positiveFormat = "#.##0"
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
       numberFormatter.maximumFractionDigits = 2
        if let longval = Double(self) {
            if let formattedNumber = numberFormatter.string(from: NSNumber(value: longval)) {
                return formattedNumber
            }
            return self
        }
        return self
    }
    func amntWithCommas() -> String {
        let numberFormatter = NumberFormatter()
       // formatter.positiveFormat = "#.##0"
        numberFormatter.numberStyle = .decimal
//        numberFormatter.minimumFractionDigits = 2
//       numberFormatter.maximumFractionDigits = 2
        if let longval = Int64(self) {
            if let formattedNumber = numberFormatter.string(from: NSNumber(value: longval)) {
                return formattedNumber
            }
            return self
        }
        return self
    }
}
