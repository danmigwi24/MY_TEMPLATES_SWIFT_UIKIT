//
//  Int.swift
//  iOSTemplateApp
//
//  Created by  Daniel Kimani on 23/09/2019.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation
extension Int {
    public func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
