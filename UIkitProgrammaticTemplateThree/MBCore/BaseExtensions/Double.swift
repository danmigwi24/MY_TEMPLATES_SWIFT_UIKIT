//
//  Double.swift
//  iOSTemplateApp
//
//  Created by  Daniel Kimani on 23/09/2019.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    public func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    public func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
