//
//  SheetNavigationViewModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 06/03/2024.
//

import Foundation
import SwiftUI

final class SheetNavigationViewModel: ObservableObject {
    //WELCOME SCREEN
    @Published public var showAccountOpeningSheet = false
    @Published public var showAccountLoginSheet = false
    
    //LOGIN
    @Published  public var navigateToCreatePin:Bool = false
    @Published  public var navigateToPanicPin:Bool = false
    @Published  public var navigateToSecurityQuestions:Bool = false
    @Published  public var navigateToMinimumDeposit:Bool = false
    
}
