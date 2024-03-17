//
//  ViewExtensions.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 02/09/2023.
//

import Foundation
import SwiftUI
import MBCore

extension View {
    //MARK: Instand of using spacers in some places , I ve implemented this custom modifier to move views inside the stack
    @ViewBuilder
    public func hSpacing(_ allignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity , alignment: allignment)
    }
    
    @ViewBuilder
    public func vSpacingMaxHeight(_ allignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity , alignment: allignment)
    }
    
    @ViewBuilder
    public func vSpacingWithMaxWidth(_ allignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity , alignment: allignment)
    }
    
    //MARK: DISABLE WITH OPACITY
    @ViewBuilder
    public func disableWithOpacity(_ condition:Bool) -> some View {
        // if condition = true ->
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
    
    @ViewBuilder
    public  func disableAView(_ condition:Bool) -> some View {
        // if condition = true ->
        self
            .disabled(condition)
    }
    
}


extension Color {
    public static var randomDefaultColor: Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
    
    // let colors: [Color] = [.red, .blue, .green, .orange, .purple]
    
    public static var randomCustomColors: [Color] = [
        Color(red: 0.2, green: 0.4, blue: 0.6),  // Custom color 1
        Color(red: 0.8, green: 0.2, blue: 0.4),  // Custom color 2
        Color(red: 0.4, green: 0.7, blue: 0.2),  // Custom color 3
        Color(red: 0.4, green: 0.7, blue: 0.2),  // Custom color 3
        Color(red: 0.73, green: 0.05, blue: 0.18),
        Color(red: 0, green: 0.57, blue: 0.62),
        Color(red: 1, green: 0.51, blue: 0.21),
        Color(red: 0.94, green: 0.36, blue: 0.66)
        
    ]
    
    public static var randomColor: Color {
        return randomCustomColors.randomElement() ?? Color(hexString: CustomColors.blue)
    }
}





extension UIImage
{
    public var highestQualityJPEGNSData: NSData { return self.jpegData(compressionQuality: 1.0)! as NSData }
    public var highQualityJPEGNSData: NSData    { return self.jpegData(compressionQuality: 0.75)! as NSData}
    public var mediumQualityJPEGNSData: NSData  { return self.jpegData(compressionQuality: 0.5)! as NSData as NSData }
    public var lowQualityJPEGNSData: NSData     { return self.jpegData(compressionQuality: 0.25)! as NSData}
    public var lowestQualityJPEGNSData: NSData  { return self.jpegData(compressionQuality: 0.0)! as NSData }
}

extension UIImage {
    public func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    public func compress(to kb: Int, allowedMargin: CGFloat = 0.2) -> Data {
        let bytes = kb * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        var holderImage = self
        var complete = false
        while(!complete) {
            if let data = holderImage.jpegData(compressionQuality: 1.0) {
                let ratio = data.count / bytes
                if data.count < Int(CGFloat(bytes) * (1 + allowedMargin)) {
                    complete = true
                    return data
                } else {
                    let multiplier:CGFloat = CGFloat((ratio / 5) + 1)
                    compression -= (step * multiplier)
                }
            }
            
            guard let newImage = holderImage.resized(withPercentage: compression) else { break }
            holderImage = newImage
        }
        return Data()
    }
}


extension UIImage {
    
    public func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        let megaByte = 1000.0
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > megaByte { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.5),
                  let imageData = resizedImage.pngData() else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        }
        
        return resizingImage
    }
}








extension Color {
    public init(hexString: String) {
         var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
         var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
         let red = Double((rgb & 0xFF0000) >> 16) / 255.0
          let green = Double((rgb & 0x00FF00) >> 8) / 255.0
          let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

/*
 extension Color {
 init(hexInt: UInt) {
 let red = Double((hexInt & 0xFF0000) >> 16) / 255.0
 let green = Double((hexInt & 0x00FF00) >> 8) / 255.0
 let blue = Double(hexInt & 0x0000FF) / 255.0
 self.init(red: red, green: green, blue: blue)
 }
 }
 */



//MARK: ReleaseVersionNumberAndBuildNumber
extension Bundle {
    public var releaseVersionNumber: String? {
        //1.0
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    public var buildVersionNumber: String? {
        //1
        return infoDictionary?["CFBundleVersion"] as? String
    }
    public var releaseVersionNumberAndBuildNumber: String {
        //1.0.1
        return "\(releaseVersionNumber ?? "").\(buildVersionNumber ?? "")"
    }
    public var releaseVersionNumberPretty: String {
        //Version 1.0(1)
        return "Version \(releaseVersionNumber ?? "")(\(buildVersionNumber ?? ""))"
    }
}


//MARK: DECODE ANY FILE eg JSON,plist

extension  Bundle {
    
    public func decodeFiled<T:Decodable>(file:String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) from bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not find \(file) from bundle")
        }
        
        let jsonDecoder = JSONDecoder()
        guard let loadedData = try? jsonDecoder.decode(T.self, from: data) else {
            fatalError("Could not find \(file) from bundle")
        }
        
        return loadedData
    }
}



extension String {
    public func localizedMyString() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
    
    
    
    public func localizedStringKey(bundle _: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(NSLocalizedString(self, tableName: "DefaultEnglish", bundle: .main, value: self, comment: ""))", comment: "")
    }
    
 
}
