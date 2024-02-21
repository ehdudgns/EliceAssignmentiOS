//
//  CourseDetailViewModel.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Foundation

class CourseDetailViewModel {
    private let repository = Repository()
    
    @Published var course: Course = Course()
    @Published var lectures: [Lecture] = []
    
    init(id: String) {
        getLectureList(id: id)
        getCourseDetail(id: id)
    }
    
    func getCourseDetail(id: String) {
        Task {
            do {
                let response = try await repository.getDetailCourse(id: id)
                course = response.course
            }
            catch let error as Err {
                print(error.description)
            }
            catch {
                print("error Task")
            }
        }
    }
    
    func getLectureList(id: String) {
        Task {
            do {
                let response = try await repository.getLectureList(id: id)
                lectures = response.lectures
            }
            catch let error as Err {
                print(error.description)
            }
            catch {
                print("error Task")
            }
        }
    }
    
    func saveMyCourse() {
        KeyChain.shared.save(key: "\(course.id)", data: course)
    }
    
    func isApplyCourse() -> Bool {
        if KeyChain.shared.load(key: "\(course.id)") == nil {return false}
        return true
    }
    
    func deleteMyCourse() {
        KeyChain.shared.delete(key: "\(course.id)")
    }
}
