//
//  HandleOutPutInCombineStatusCodes.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 08/10/2023.
//

import Foundation
import Combine

//public let   errorMessage = "We're currently experiencing server issues. Please try again later."

public let     BASE_URL = ""

//MARK: - URLSession
public func handleURLSessionOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
    
    guard  let   responseOutPut = output.response as? HTTPURLResponse else {
        // Handle the case where output.response is not an HTTPURLResponse
        // For example, you can print an error message and return from the function
        print("output.response is not an HTTPURLResponse")
        return  Data()
    }
    
    // Accessing URL
    if  let   url = output.response.url {
        print("HandleOutput URL: \(url)")
    }
    // Accessing the original URLRequest
    // Accessing the response body
     let   responseBody = output.data
     let   responseBodyString = String(data: responseBody, encoding: .utf8)
    if  let   body = responseBodyString {
        print("HandleOutput Response Body: \(responseBodyString ?? "")")
    }
    
    if responseOutPut.statusCode >= 200 && responseOutPut.statusCode < 300 {
        print("STATUS CODE: \(responseOutPut.statusCode)")
        return output.data
    } else if  let   response = output.response as? HTTPURLResponse, response.statusCode == 401 {
        // Handle the 401 Unauthorized error here
        print("---------------------- Unauthorized: 401 error")
        
        // You can perform actions like logging out the user or showing an error message.
        // For example:
        // handleCompletion(false, "Unauthorized: 401 error")
        // Return a custom URLError with a custom localized description
         let   customError = URLError(.badServerResponse, userInfo: [
            NSLocalizedDescriptionKey: "LOGOUT"
        ])
        
        throw customError
    } else {
        if  let   urlError = URLError(.badServerResponse) as? URLError {
            print("HandleOutput ERROR\n\(urlError)")
            // You can also check urlError.localizedFailureReason for more details
        } else {
            print("Try again: \(URLError(.badServerResponse))")
        }
        
        // Return a custom URLError with a custom localized description
        //
         let   statuscode = responseOutPut.statusCode
        print("STATUS CODE : \(statuscode)")
        
        //
        
         let   customError = URLError(.badServerResponse, userInfo: [
            NSLocalizedDescriptionKey: "Error in handleOutput"
        ])
        throw customError
    }
}


func handleOutput1(output: URLSession.DataTaskPublisher.Output) -> Data {
    do {
        if  let   responseOutPut = output.response as? HTTPURLResponse,
           responseOutPut.statusCode >= 200 && responseOutPut.statusCode < 300 {
            print("URL Error Code: /n\(responseOutPut)")
            return output.data
        } else if  let   response = output.response as? HTTPURLResponse, response.statusCode == 401 {
            // Handle the 401 Unauthorized error here
            print("------------------------------- Unauthorized: 401 error")
            
            // You can perform actions like logging out the user or showing an error message.
            // For example:
            // handleCompletion(false, "Unauthorized: 401 error")
            
            throw URLError(.badServerResponse)
        } else {
            throw URLError(.badServerResponse)
        }
    } catch {
        if  let   urlError = error as? URLError {
            print("URL Error Code: \(urlError.code)")
            print("URL Error Description: \(urlError.localizedDescription)")
            // You can also check urlError.localizedFailureReason for more details
        } else {
            print("Try again: \(error)")
        }
        return Data() // Return some default value or handle the error as needed
    }
}


func handleOutput2(output: URLSession.DataTaskPublisher.Output) -> Data {
    do {
        guard
             let   responseOutPut = output.response as? HTTPURLResponse,
            responseOutPut.statusCode >= 200 && responseOutPut.statusCode < 300  else {
            
            // Check for a 401 Unauthorized response
            if  let   response = output.response as? HTTPURLResponse, response.statusCode == 401 {
                // Handle the 401 Unauthorized error here
                print("Unauthorized: 401 error")
            }
            
            throw URLError(.badServerResponse)
        }
        print("URL Error Code: \(responseOutPut)")
        return output.data
    } catch {
        if  let   urlError = error as? URLError {
            print("URL Error Code: \(urlError.code)")
            print("URL Error Description: \(urlError.localizedDescription)")
            // You can also check urlError.localizedFailureReason for more details
        } else {
            print("Try again: \(error)")
        }
        return Data() // Return some default value or handle the error as needed
    }
}

//MARK: - URLSession
func handleOutputSimple(output: URLSession.DataTaskPublisher.Output) throws -> Data {
    guard
         let   response = output.response as? HTTPURLResponse,
        response.statusCode >= 200 && response.statusCode < 300 else {
        throw URLError(.badServerResponse)
    }
    return output.data
}



extension Publisher {
    func handleNetworkErrors(
        handleUnauthorized: (() -> Void)? = nil,
        handleCompletion: @escaping (Bool, String?) -> Void
    ) -> AnyPublisher<Output, Never> {
        return self
            .mapError { error in
                if  let   urlError = error as? URLError, urlError.code == .userAuthenticationRequired {
                    handleUnauthorized?()
                    return MyNetworkError.unauthorized
                } else {
                    return MyNetworkError.otherError(error)
                }
            }
            .flatMap { output -> AnyPublisher<Output, MyNetworkError> in
                if  let   response = (output as? URLSession.DataTaskPublisher.Output)?.response as? HTTPURLResponse, response.statusCode == 401 {
                    handleUnauthorized?()
                    print("Unauthorized: 401 error")
                    handleCompletion(false, "Unauthorized: 401 error")
                    return Fail(error: MyNetworkError.unauthorized).eraseToAnyPublisher()
                } else {
                    return Just(output)
                        .setFailureType(to: MyNetworkError.self)
                        .eraseToAnyPublisher()
                }
            }
            .map { $0 }
            .catch { _ in Empty<Output, Never>() }
            .eraseToAnyPublisher()
    }
}


enum MyNetworkError: Error {
    case unauthorized
    case otherError(Error) // You can wrap an underlying error if needed
}
