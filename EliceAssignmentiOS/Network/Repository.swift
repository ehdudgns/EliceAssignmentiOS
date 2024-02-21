//
//  Repository.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Foundation
import Combine
import Alamofire

class Repository {
    private var apiService = API()
    
    func getFreeCourseList(offset: Int) async throws -> CouresesAPIModel {
        let response = try await apiService.getFreeCourseList(offset: offset)
        
        if let reason = response.result.reason {
            throw Err.errorReason(msg: reason)
        }
        
        return response
    }
    
    func getRecommendedCourseList(offset: Int) async throws -> CouresesAPIModel {
        let response = try await apiService.getRecommendedCourseList(offset: offset)
        
        if let reason = response.result.reason {
            throw Err.errorReason(msg: reason)
        }
        
        return response
    }
    
    func getDetailCourse(id: String) async throws -> CourseAPIModel {
        let response = try await apiService.getCourseDetail(id: id)
        
        if let reason = response.result.reason {
            throw Err.errorReason(msg: reason)
        }
        
        return response
    }
    
    func getLectureList(id: String) async throws -> LecturesAPIModel {
        let response = try await apiService.getLectureList(id: id)
        
        if let reason = response.result.reason {
            throw Err.errorReason(msg: reason)
        }
        
        return response
    }
}
