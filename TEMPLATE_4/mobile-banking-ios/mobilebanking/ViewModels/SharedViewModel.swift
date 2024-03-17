//
//  AuthManager.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 06/09/2023.
//

import SwiftUI
import MBCore
import Combine
import UserNotifications
import AppTrackingTransparency


class SharedViewModel : ObservableObject {
    @Published var viewID = UUID()
    //STATES
    @Published var isLoading:Bool = false
    @Published var logoutNavigation:Bool = false
    
    //FOR ALERTS
    @Published var showCustomDialog: Bool = false
    //
    @Published var showAlert: Bool = false
    @Published var showActionSheet: Bool = false
    //
    @State var errorText = "*Required"
    //
    @Published var alertTitle: String = "Info"
    @Published var alertMessage: String = ""
    @Published var loadingMessage: String = "Please Wait .."
    @Published var actionSheetMessage: String = ""
    //
    private var cancellables = Set<AnyCancellable>()
    @Published var response : CommonResponse?

  

    
    // MARK: -Sample API REQUEST
    func postApiRequest(requestBody: CommonRequest, handleCompletion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(BASE_URL)")
                
        else {
            handleCompletion(false, "Invalid URL")
            return
        }
        
        Logger("URL IS \(url)")
        
        guard let jsonData = try? JSONEncoder().encode(requestBody),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            handleCompletion(false, "Failed to encode user data")
            return
        }
        
        Logger("REQUEST IS \(jsonString)",showLog: false)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //MARK: ADD TO HEADERS
        // Set the Authorization header with the bearer token
        guard let bearerToken = UserDefaults.standard.string(forKey: USERDEFAULTS.ACCESS_TOKEN) else {return}
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        /**
         // Create a base64-encoded string for the "Authorization" header
         let credentials = "\("system"):\("system-password")"
         if let credentialsData = credentials.data(using: .utf8) {
         let base64Credentials = credentialsData.base64EncodedString()
         let authValue = "Basic \(base64Credentials)"
         request.setValue(authValue, forHTTPHeaderField: "Authorization")
         }
         */
        
        // Log the headers
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            Logger("Header - \(key): \(value)")
        }
        
        // Create a custom URLSessionConfiguration with an increased timeout interval
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60 // Increase the timeout to 30 seconds (adjust as needed)
        
        // Create a custom URLSession using the configuration
        let customSession = URLSession(configuration: config)
        
        //URLSession.shared.dataTaskPublisher(for: request)
        // Use the custom URLSession for the data task
        customSession.dataTaskPublisher(for: request)
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
           .tryMap(handleURLSessionOutput)
            .decode(type: CommonResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    handleCompletion(true, nil)
                case .failure(let error):
                    Logger("\(error)")
                    handleCompletion(false, "\(error)")
                }
            }, receiveValue: { [weak self] responseData in
                
                //if responseData.status == "00" {
                DispatchQueue.main.async {
                    self?.response = responseData
                }
                //}
                Logger("RESPONSE : \(responseData)")
            })
            .store(in: &cancellables)
    }

    func showActionSheet(title:String = "Info", message:String){
        DispatchQueue.main.async {
            self.alertTitle = title
            self.actionSheetMessage = message
            self.showActionSheet = true
        }
    }
    
    func showAlert(title:String = "Info",message:String){
        DispatchQueue.main.async {
            self.alertTitle = title
            self.alertMessage = message
            self.showAlert = true
        }
    }
    

    
  
}
