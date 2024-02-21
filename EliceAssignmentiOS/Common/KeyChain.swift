//
//  KeyChain.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/21.
//

import Foundation

class KeyChain {

    
    static let shared: KeyChain = KeyChain()
    
    func save(key: String, data: Course?) {
        
        guard let data = data else { return }
        
        
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "",
            kSecAttrAccount as String: key,
            kSecValueData as String: "\(data)"
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("👉 Data save Success")
        } else {
            print("👉 Data save Failed")
        }
    }

    func load(key: String) -> Course? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Course {
            return data
        }
        return nil
    }

    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "",
            kSecAttrAccount as String: key
        ]
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess {
            print("👉 Data delete Success")
        } else {
            print("👉 Data delete Failed")
        }
    }
}
