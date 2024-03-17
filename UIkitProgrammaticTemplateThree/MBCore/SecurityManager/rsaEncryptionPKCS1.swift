import Foundation
import Security

// Function to generate RSA key pair
public func generateRSAKeyPair() throws -> (privateKey: SecKey, publicKey: SecKey) {
    let attributes: [String: Any] = [
        kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
        kSecAttrKeySizeInBits as String: 2048
    ]
    var error: Unmanaged<CFError>?
    guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
        throw error?.takeRetainedValue() ?? NSError(domain: NSOSStatusErrorDomain, code: Int(errSecInternalError), userInfo: nil)
    }
    guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
        throw error?.takeRetainedValue() ?? NSError(domain: NSOSStatusErrorDomain, code: Int(errSecInternalError), userInfo: nil)
    }
    return (privateKey, publicKey)
}

// Function to encrypt data using RSA/ECB/PKCS1Padding
public func rsaEncrypt(data: Data, publicKey: SecKey) throws -> Data {
    var error: Unmanaged<CFError>?
    guard let encryptedData = SecKeyCreateEncryptedData(publicKey, .rsaEncryptionPKCS1, data as CFData, &error) as Data? else {
        throw error?.takeRetainedValue() ?? NSError(domain: NSOSStatusErrorDomain, code: Int(errSecInternalError), userInfo: nil)
    }
    return encryptedData
}

// Function to decrypt data using RSA/ECB/PKCS1Padding
public func rsaDecrypt(data: Data, privateKey: SecKey) throws -> Data {
    var error: Unmanaged<CFError>?
    guard let decryptedData = SecKeyCreateDecryptedData(privateKey, .rsaEncryptionPKCS1, data as CFData, &error) as Data? else {
        throw error?.takeRetainedValue() ?? NSError(domain: NSOSStatusErrorDomain, code: Int(errSecInternalError), userInfo: nil)
    }
    return decryptedData
}

public func rsaDecryptWithPublicKey(data: Data, publicKey: SecKey) throws -> Data {
    var error: Unmanaged<CFError>?
    guard let decryptedData = SecKeyCreateDecryptedData(publicKey, .rsaEncryptionPKCS1, data as CFData, &error) as Data? else {
        throw error?.takeRetainedValue() ?? NSError(domain: NSOSStatusErrorDomain, code: Int(errSecInternalError), userInfo: nil)
    }
    return decryptedData
}


