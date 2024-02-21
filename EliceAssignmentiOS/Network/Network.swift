//
//  Network.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/19.
//

import Foundation
import Combine
import Alamofire

class API {
    var cancelBag = Set<AnyCancellable>()
    
    func getFreeCourseList(offset: Int) async throws -> CouresesAPIModel {
        let parameters = ["offset":"\(offset)", "count":"10", "filter_is_recommended":"false", "filter_is_free":"true"]
        
        let request = AF.request(APIRouter.getCourseList(parameters: parameters))
        
        return try await request.serializingDecodable(CouresesAPIModel.self).value
    }
    
    func getRecommendedCourseList(offset: Int) async throws -> CouresesAPIModel {
        let parameters = ["offset":"\(offset)", "count":"10", "filter_is_recommended":"true", "filter_is_free":"false"]
        let request = AF.request(APIRouter.getCourseList(parameters: parameters))
        
        return try await request.serializingDecodable(CouresesAPIModel.self).value
    }
    
    func getCourseDetail(id: String) async throws -> CourseAPIModel {
        let parameters = ["course_id": id]
        
        let request = AF.request(APIRouter.getCourse(parameters: parameters))
        
        return try await request.serializingDecodable(CourseAPIModel.self).value
    }
    
    func getLectureList(id: String) async throws -> LecturesAPIModel {
        let parameters = ["offset": "0", "count": "40", "course_id": id]
        
        let request = AF.request(APIRouter.getLectureList(parameters: parameters))
        
        return try await request.serializingDecodable(LecturesAPIModel.self).value
    }
}
