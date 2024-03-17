//
//  MultipartRequest.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 13/11/2023.
//

import Foundation
import UIKit
import MBCore

struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }

    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: application/json; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }

    func addDataField(named name: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }

    private func dataFormField(named name: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()

        Logger(" NAME \(name)",showLog: false)
        Logger(" DATA \(data)",showLog: false)
        Logger(" DATA \(mimeType)",showLog: false)
        
        fieldData.append("--\(boundary)\r\n".data(using: .utf8)!)
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"".data(using: .utf8)!)
        fieldData.append("; filename=\"image\(getEpochFromCurrentDate())img.jpg\"\r\n".data(using: .utf8)!)
        fieldData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        fieldData.append(data)
        fieldData.append("\r\n".data(using: .utf8)!)

        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)

        request.setValue("Bearer \(getUserData(key: USERDEFAULTS.ACCESS_TOKEN))", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"

        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            Logger("Header - \(key): \(value)",showLog: false)
        }
        
        return request
    }

}

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}


extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: String.Encoding.utf8) {
            append(data)
        }
    }
}





