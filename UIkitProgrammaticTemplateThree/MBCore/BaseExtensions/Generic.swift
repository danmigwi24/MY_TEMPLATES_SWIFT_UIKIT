//
//  Generic.swift
//  AppCore
//
//  Created by  Daniel Kimani on 6/2/21.
//  Copyright © 2021 Eclectics Int. All rights reserved.
//

import Foundation
protocol PropertyNames {
    func propertyNames() -> [String]
}

extension PropertyNames
{
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    func propertyValues() -> [Any] {
        return Mirror(reflecting: self).children.compactMap { $0.value }
    }
}
