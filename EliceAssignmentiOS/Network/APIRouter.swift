//
//  APIRouter.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case getCourseList(parameters: [String: String])
    case getCourse(parameters: [String: String])
    case getLectureList(parameters: [String: String])
    
    var baseURL: URL {
        return URL(string: "https://api-rest.elice.io/org/academy")!
    }
    
    var path: String {
        switch self {
            case .getCourseList: return "course/list/"
            case .getCourse: return "course/get/"
            case .getLectureList: return "lecture/list/"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = .get
        
        switch self {
            case let .getLectureList(parameters):
                request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
            case let .getCourse(parameters):
                request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
            case let .getCourseList(parameters):
                request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }
        return request
    }
}
