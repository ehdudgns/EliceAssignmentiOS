//
//  LectureModel.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Foundation

struct LecturesAPIModel: Codable {
    var result: ResultData
    var lectures: [Lecture]
    
    enum CodingKeys: String, CodingKey {
        case result = "_result"
        case lectures
    }
}

struct Lecture: Codable {
    var title: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
    }
}
