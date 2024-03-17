//
//  Optional.swift
//  iOSTemplateApp
//
//  Created by  Daniel Kimani on 23/09/2019.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation
import UIKit

extension Optional where Wrapped == String {
    
    var isNullOrWhitespace: Bool {
        return self?.isWhitespace ?? true
    }
    
}
