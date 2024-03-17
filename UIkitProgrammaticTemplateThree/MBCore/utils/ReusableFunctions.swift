//
//  ReusableFunctions.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 27/09/2023.
//

import Foundation
import SwiftUI
import MBCore
import UIKit
import CoreLocation
import MapKit
import Combine
import Localize_Swift
import SwiftMessages

public func Logger(_ message:String, showLog:Bool = false){
    //if showLog {
    //#if DEBUG
    //print("\(message)")
    //#endif
    // }
    //print("\(arc4random_uniform(100))----------------------------------------------------------------------")
    
#if DEBUG
    print("Environment is DEBUG")
    print("\(message)")
#elseif debug
    print("Environment is debug")
#elseif Debug
    print("Environment is Debug")
#elseif RELEASE
    print("Release")
#elseif PRODUCTION
    print("Environment is production")
#elseif PROD
    print("Environment is PROD")
#else
    print("Environment is can't find")
#endif
    
}

//MARK: USED TO FECTH FONT NAMES IN THE SYSTEM  THAT ARE AVAILABLE
public func getFontFamilyNames (){
    for familyName in UIFont.familyNames {
        Logger(familyName)
        
        for fontName in UIFont.fontNames(forFamilyName: familyName) {
            Logger("-- \(fontName)")
        }
    }
}




public func formatPhoneNumber(_ phoneNumber: String) -> String? {
    guard phoneNumber.count >= 6 else {
        // Handle the case where the phone number is too short to format
        return nil
    }
    
    let prefix = phoneNumber.prefix(3) // Get the first 3 characters
    let suffix = phoneNumber.suffix(3) // Get the last 3 characters
    let asterisks = String(repeating: "*", count: phoneNumber.count - 6) // Create a string of asterisks
    
    //return "\(prefix)*****\(suffix)"
    return "\(prefix)\(asterisks)\(suffix)"
}


//
public func formatToSpaceSeparated(_ input: String) -> String {
    let cleanedInput = input.replacingOccurrences(of: "[^\\d]", with: "", options: .regularExpression)
    var formattedString = ""
    for (index, char) in cleanedInput.enumerated() {
        if index > 0 && index % 4 == 0 {
            formattedString += " "
        }
        formattedString.append(char)
    }
    return formattedString
}
//
public func formatToMasked(_ input: String) -> String {
    
    let cleanedInput = input.replacingOccurrences(of: "[^\\d]", with: "", options: .regularExpression)
    print("cleanedInput  IS : \(cleanedInput)")
    var maskedString = ""
    for (index, char) in cleanedInput.enumerated() {
        if index >= 4 && index <= 11 {
            maskedString += "*"
        } else {
            maskedString.append(char)
        }
    }
    
    // Format the input as "1234 **** **** 1234"
    var formattedCardNumber = ""
    for (index, char) in maskedString.enumerated() {
        if index > 0 && index % 4 == 0 {
            formattedCardNumber += " " // Add a space every 4 digits
        }
        formattedCardNumber.append(char)
    }
    
    print("cleanedInput IS : \(formattedCardNumber)")
    return formattedCardNumber
}

public func formatCreditCardNumber(_ number: String) -> String {
        // Remove any non-numeric characters
        let numericString = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Check if the string length is less than 16
        guard numericString.count <= 16 else {
            return String(numericString.prefix(16))
        }
        
        // Apply masking
        var formattedString = ""
        var index = numericString.startIndex
        for i in 0..<numericString.count {
            if i > 0 && i % 4 == 0 {
                formattedString.append(" ")
            }
            if i < 4 || i >= numericString.count - 4 {
                formattedString.append(numericString[index])
            } else {
                formattedString.append("*")
            }
            index = numericString.index(after: index)
        }
        
        return formattedString
    }


//
public func removeLeadingZeros(from number: String) -> String {
    // Use regular expressions to remove leading zeros
    let pattern = "^0+(?!$)"
    if let range = number.range(of: pattern, options: .regularExpression) {
        return String(number[range.upperBound...])
    }
    Logger("FORMATED PHONE IS : \(number)")
    return number
}



public func isValidEmail2(email: String) -> Bool {
    // let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    
    return emailPredicate.evaluate(with: email)
}

public func isValidEmail(email: String) -> Bool {
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    
    Logger("EMAIL:\(email) is VALID \(emailPredicate.evaluate(with: email))")
    return emailPredicate.evaluate(with: email)
}



public func isInputValid(input: String) -> Bool {
    return input.count >= 2
}

public  func isPhoneNumberInputValid(_ input: String) -> Bool {
    return input.count >= 8 && input.count <= 10
}

public  func openURLInBroswer(_ urlString: String) {
    if let url = URL(string: urlString) {
        UIApplication.shared.open(url)
    }
}
public func openCall(_ callNumber: String) {
    if let phoneURL = URL(string: "tel://\(callNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
        UIApplication.shared.open(phoneURL)
    }else{
        /*
         CustomAlertDailog(
         title: "Contact",
         message: callNumber,
         primaryText: "Okay",
         primaryAction: {
         Logger(callNumber)
         })
         */
    }
}


//
//
//func dismissSheet(sheetShown:Bool,sheetDismissal:Bool){
//   sheetShown.toggle()
//   DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
//       sheetDismissal.toggle()
//   })
//}



public func dropFirstThreeDigits(_ input: String) -> String {
    if input.count >= 3 {
        let startIndex = input.index(input.startIndex, offsetBy: 3)
        return String(input[startIndex...])
    } else {
        return input
    }
}



public func metersToKilometers(meters: Double) -> Double {
    let kilometers = meters / 1000.0
    return  kilometers ?? 0.0 //Double(String(format: "%.2f", kilometers)) ?? 0.0
}


public func calculatePercentage(numerator: Int, denominator: Int) -> CFloat? {
    guard denominator > 0 else {
        return nil // Avoid division by zero
    }
    
    let percentage = (Float(numerator) / Float(denominator)) * 100.0
    return CFloat(percentage)
}


// Function to calculate the height of the white capsule based on the percent value.
public func getHeight(percent:Double) -> CGFloat {
    let maxPercent = 100.0
    let clampedPercent = min(max(0.0, percent), maxPercent)
    return CGFloat(clampedPercent / maxPercent * 300.0)
}

public func getPercentage(percent:Double) -> CGFloat {
    let maxPercent = 100.0
    let clampedPercent = min(max(0.0, percent), maxPercent)
    return CGFloat(clampedPercent)
}


public func openExternalMapApp(latitude:String, longitude:String) {
    // Define the location you want to open in the map app
    // let latitude = "37.7749"
    //let longitude = "-122.4194"
    
    // Create a URL with the location information
    if let url = URL(string: "https://maps.apple.com/?ll=\(latitude),\(longitude)") {
        // Open the URL in the default map app (Apple Maps)
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


public func openMapForPlace(latitude:Double, longitude:Double, plabeName:String?) {
    
    //let latitude: CLLocationDegrees = 37.2
    //let longitude: CLLocationDegrees = 22.9
    
    let regionDistance:CLLocationDistance = 10000
    let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
    let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
    let options = [
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = plabeName ?? "Place Name"
    mapItem.openInMaps(launchOptions: options)
}


public func openGoogleMapsNavigation(latitude:String,longitude:String,placeName:String?) {
    let urlString = "comgooglemaps://?daddr=\(latitude),\(longitude)&q=\(placeName ?? "")&directionsmode=driving"
    
    if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
        UIApplication.shared.open(url)
    } else {
        // Handle the case where the URL is invalid
        Logger("Unable to open Google Maps")
    }
}



public func checkPasswordComplexity(_ password: String) -> Bool {
    // Define your password complexity rules here
    let hasMinimumLength = password.count >= 8
    let hasUppercaseLetter = password.rangeOfCharacter(from: .uppercaseLetters) != nil
    let hasLowercaseLetter = password.rangeOfCharacter(from: .lowercaseLetters) != nil
    let hasDigit = password.rangeOfCharacter(from: .decimalDigits) != nil
    
    return hasMinimumLength && hasUppercaseLetter && hasLowercaseLetter && hasDigit
}


public func isPasswordStrong(password: String) -> Bool {
    let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*?&]).{8,}"#
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
}

public func openSettings() {
    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(settingsURL)
    }
}



public func decimalFormatterToOneDecimal(_ digits:Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    //formatter.locale = Locale.current
    
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 1
    
    let result = formatter.string(from: NSNumber(value: digits)) ?? ""
    //return formatter
    return result
}


public func decimalFormatterToTwoDecimal(_ digits:Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    //formatter.locale = Locale.current
    
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    
    let result = formatter.string(from: NSNumber(value: digits)) ?? ""
    //return formatter
    return result
}

public func removeDecimalPlaceToWholeNumber(_ digits:Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    
    let result = formatter.string(from: NSNumber(value: digits)) ?? ""
    //return formatter
    return result
}


public func getAppID() -> String {
    if let bundleIdentifier = Bundle.main.bundleIdentifier {
        return bundleIdentifier
    } else {
        return "Unable to retrieve App ID"
    }
}

public func getImageFromURL(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
    if let imageUrl = URL(string: urlString) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(uiImage)
                }
            } else {
                // Handle the case when the image data couldn't be retrieved or converted to a UIImage
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    } else {
        // Handle the case when the URL is invalid
        completion(nil)
    }
}




public func generateBoundaryString() -> String {
    return "Boundary-\(UUID().uuidString)"
}

public func createBody(with parameters: [String: Any], boundary: String) throws -> Data {
    var body = Data()
    
    for (key, value) in parameters {
        if let image = value as? UIImage, let imageData = image.jpegData(compressionQuality: 0.5) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).jpeg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
    }
    
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    
    return body
}



public func getCurrentLanguage() {
    Localize.currentLanguage()
    let currentLang = getUserData(key: USERDEFAULTS.USER_LANGUAGE)
    Localize.setCurrentLanguage(currentLang)
    Logger("---------------------- GET CURRENT APP LANGUAGE IS ------------------- \(currentLang)")
}

public func setCurrentLanguage(lang:String) {
    saveUserData(key: USERDEFAULTS.USER_LANGUAGE, data: lang)
    Localize.setCurrentLanguage(lang)
    Logger("---------------------- SET CURRENT APP LANGUAGE IS ------------------- \(lang)")
}
