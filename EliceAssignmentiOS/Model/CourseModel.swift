//
//  CourseModel.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Foundation

struct CouresesAPIModel: Codable {
    var result: ResultData
    var courses: [Course]
    
    enum CodingKeys: String, CodingKey {
        case result = "_result"
        case courses
    }
}

struct CourseAPIModel: Codable {
    var result: ResultData
    var course: Course
    
    enum CodingKeys: String, CodingKey {
        case result = "_result"
        case course
    }
}

struct Course: Codable {
    var id: Int
    var title: String
    var shortDescription: String
    var tagList: [String]
    var logoFileUrl: String
    var imageFileUrl: String?
    var description: String?
    
    init() {
        self.id = 0
        self.title = ""
        self.shortDescription = ""
        self.tagList = []
        self.logoFileUrl = ""
        self.imageFileUrl = nil
        self.description = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case shortDescription = "short_description"
        case tagList = "taglist"
        case logoFileUrl = "logo_file_url"
        case imageFileUrl = "image_file_url"
        case description
    }
}

struct ResultData: Codable {
    var status: String
    var reason: String?
}
