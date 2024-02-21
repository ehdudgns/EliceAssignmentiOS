//
//  Error.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Foundation

enum Err: Error {
    case errorReason(msg: String)
    case networkError
    
    public var description: String {
        switch self {
        case .errorReason(let message):
            return message
        case .networkError:
            return "서버와 연결이 좋지 않습니다."
        }
    }
}
