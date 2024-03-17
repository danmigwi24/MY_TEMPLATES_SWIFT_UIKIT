//
//  String.swift
//  iOSTemplateApp
//
//  Created by  Daniel Kimani on 23/09/2019.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//cic

import Foundation

typealias string = String

extension String {
public func getInitial() -> String {
        let words = self.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
        if words.count == 1 {
            return String(self.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1))
        } else if let firstWord = words.first, let lastWord = words.last {
            let firstInitial = String(firstWord.prefix(1))
            let lastInitial = String(lastWord.prefix(1))
            return firstInitial + lastInitial
        } else {
            return "*"
        }
    }
    public func trimSpaces() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
 
//     public func getInitial() -> String {
//        let separated = self.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
//        if separated.count > 1 {
//            let char1 = separated[0].first
//            let char2 = separated[1].first
//            return ("\(char1 ?? "*")\(char2 ?? "*")")
//        }
//        // first returns The first element of the collection.
//        if separated.first!.count > 2 {
//            return String(separated.first!.prefix(1))
//        }
//        return "*"
//    }

    
    
    public enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    public func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    public func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    public func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
//    public func onlyDigits() -> String {
//        let digitChars = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
//        return digitChars
//    }

    
    public var isWhitespace: Bool {
        guard !isEmpty else { return true }
        
        let whitespaceChars = NSCharacterSet.whitespacesAndNewlines
        
        return self.unicodeScalars
            // The compiler (in Swift 4.0) required explicit types here. Future versions may let you get away with $0 implicit syntax
            .filter { (unicodeScalar: UnicodeScalar) -> Bool in !whitespaceChars.contains(unicodeScalar) }
            .count == 0
    }
    
    public func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int.init($0) ?? 0 }
    }
    
    //MARK: - Splits a string into groups of `every` n characters, grouping from left-to-right by default. If `backwards` is true, right-to-left.
    
        public func split(every: Int, backwards: Bool = false) -> [String] {
            var result = [String]()

            for i in stride(from: 0, to: self.count, by: every) {
                switch backwards {
                case true:
                    let endIndex = self.index(self.endIndex, offsetBy: -i)
                    let startIndex = self.index(endIndex, offsetBy: -every, limitedBy: self.startIndex) ?? self.startIndex
                    result.insert(String(self[startIndex..<endIndex]), at: 0)
                case false:
                    let startIndex = self.index(self.startIndex, offsetBy: i)
                    let endIndex = self.index(startIndex, offsetBy: every, limitedBy: self.endIndex) ?? self.endIndex
                    result.append(String(self[startIndex..<endIndex]))
                }
            }

            return result
        }
    
    //MARK: - Formats phone for view in app
    public func formatPhone() -> String {
        var temp = ""
        if self.isEmpty{
            return temp
        }
        
        temp = self.preparePhone()
        
        let groups = temp.split(every: 3)
        temp = ""
        
        for group in groups{
            temp.append("\(group) ")
        }
        
        temp = "+\(temp)"
        
        return temp
    }
    
    //MARK: - Prepare phone extension
    public func preparePhone() -> String {
        var temp = ""
        
        if self.isEmpty
            || self.count < 8
            || (self.starts(with: "7") && self.count != 9)
            || (self.starts(with: "0") && self.count != 10)
            || (self.starts(with: "+") && self.count != 13)
            || (self.starts(with: "2") && self.count != 12) {
            return self
        }
        
        let re = try! NSRegularExpression(pattern: "[^0-9]")
        let range = NSRange(location: 0, length: self.count)
        
        temp = re.stringByReplacingMatches(in: self, range: range, withTemplate: "")
        
//        let startIndex = temp.index(temp.startIndex, offsetBy: 1)
//        let endIndex = temp.index(temp.startIndex, offsetBy: temp.count)
        
        if temp.starts(with: "0") {
            temp = "254\(temp.dropFirst())"
        }else if temp.starts(with: "7") {
            temp = "254\(temp)"
        }
        
        
        return temp
    }
    
    //MARK: - Check if PIN is weak
    public func weakPin() -> Bool{
        if self.isEmpty, self.count != 4 {
            return true
        }
        
        //check if all characters are the same
        var s1 = Set<CChar>()
        let scalars = self.cString(using: .ascii)!
        //insert characters into the set
        for char in 0 ... scalars.count - 1{
            s1.insert(scalars[char])
        }
        
        if s1.count == 1 {
            return true
        }// pass cannot contain contain 4 consecutive same characters
        
        if (s1.count - 1) == 1 {
            return true
        }// pass cannot contain contain 3 consecutive same characters
        
        //check for three consecutive digits in pin
//        var prev: CChar? = nil
//        var asc: Bool? = nil
//        var streak = 0
        
//        for c in scalars{
//            if prev != nil{
//                while c - prev{
//                    -1
//                }
//            }
//            
//            prev = c
//        }
        
        
        return false // pin is strong
    }
    
    //MARK: - Masking
    public func maskAccount() -> String{
        /**\u{n} syntax is used to represent a Unicode code point, where n is the code point value in hexadecimal. Unicode code points are numbers that represent a specific character in the Unicode character set. eg. 002A symbol for asterix  o1 42 16 00 30 102*/
        let maskedCharacter = "\u{002A}\u{002A}\u{002A}\u{002A}\u{002A}\u{002A}"
        let s = "\(self.prefix(4))\(maskedCharacter)\(self.suffix(3))"
        return s.trimmingCharacters(in: .whitespaces)
    }
    
    
    /*
     /**
      * Extension function to check if PIN is weak
      * Return true if PIN is weak
      */
     fun String.weakPin(): Boolean{
        
         for (c in this.toCharArray()) {
             if (prev != null) {
                 when (c - prev) {
                     -1 -> if (java.lang.Boolean.FALSE == asc) streak++ else {
                         asc = false
                         streak = 2
                     }
                     1 -> if (java.lang.Boolean.TRUE == asc) streak++ else {
                         asc = true
                         streak = 2
                     }
                     else -> {
                         asc = null
                         streak = 0
                     }
                 }
                 if (streak == 3) return true // 3 consecutive characters, pass is weak
             }
     
     
             prev = c
         }
         return false // the pass is strong
     }
     */
}

extension StringProtocol {
    public var firstCharUppercased: String { prefix(1).uppercased() + dropFirst() }
    public var firstCharCapitalized: String { prefix(1).capitalized + dropFirst() }
}
