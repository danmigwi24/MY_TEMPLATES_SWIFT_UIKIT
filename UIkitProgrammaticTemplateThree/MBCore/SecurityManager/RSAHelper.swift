//
//  RSAHelper.swift
//  mbcore
//
//  Created by Daniel Kimani on 26/02/2024.
//

import Foundation
import Security

public class RSAHelper {
    public init(){}
    
       
    public func getPublicKeyFromPEMStringConvertToSecKey(publicKey:String) -> SecKey? {
        // Remove unnecessary characters and whitespace
        let cleanedPEMString = RSAHelper().cleanedPEMString(publicKey: publicKey)
    
        // Convert base64 encoded string to Data
        guard let data = Data(base64Encoded: cleanedPEMString) else {
            print("Error decoding base64 string")
            return nil
        }
        
        // Create a SecCertificate from the data
        guard let certificate = SecCertificateCreateWithData(nil, data as CFData) else {
            print("Error creating certificate from data")
            return nil
        }
        
        // Extract the public key from the certificate
        var optionalPublicKey: SecKey?
        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        let status = SecTrustCreateWithCertificates(certificate, policy, &trust)
        if let trust = trust, status == errSecSuccess {
            optionalPublicKey = SecTrustCopyPublicKey(trust)
        } else {
            print("Error creating trust")
        }
        
        return optionalPublicKey
    }
    

    
    public func cleanedPEMString(publicKey:String) -> String {
        let cleanedPEMString = publicKey
            .replacingOccurrences(of: "-----BEGIN CERTIFICATE-----", with: "")
            .replacingOccurrences(of: "-----END CERTIFICATE-----", with: "")
        //
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
        //
            .replacingOccurrences(of: "-----BEGIN RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END RSA PRIVATE KEY-----", with: "")
        //
        
            .replacingOccurrences(of: "-----END ENCRYPTED PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----BEGIN ENCRYPTED PRIVATE KEY-----", with: "")
        //
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        //
        return cleanedPEMString
    }
    
    public func readPEMFile() -> String {
        if let filePath = Bundle.main.path(forResource: "cert", ofType: "pem") {
            do {
                let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
                return fileContent
            } catch {
                return "Error reading file: \(error.localizedDescription)"
            }
        } else {
            return "File not found"
        }
    }
    
}

