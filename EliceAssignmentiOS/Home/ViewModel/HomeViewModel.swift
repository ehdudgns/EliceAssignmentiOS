//
//  ViewModel.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Combine
import Foundation

class HomeViewModel {
    
    private let repository = Repository()
    
    @Published var freeCourseList: [Course] = []
    @Published var recommendedCourseList: [Course] = []
    
    init() {
        getFreeCourseList(offset: 0)
        getRecommendedCourseList(offset: 0)
    }
    
    func getFreeCourseList(offset: Int) {
        Task {
            do {
                let response = try await repository.getFreeCourseList(offset: offset)
                freeCourseList = response.courses
            }
            catch let error as Err {
                print(error.description)
            }
            catch {
                print("error Task")
            }
        }
    }
    
    func getRecommendedCourseList(offset: Int) {
        Task {
            do {
                let response = try await repository.getRecommendedCourseList(offset: offset)
                recommendedCourseList = response.courses
            }
            catch let error as Err {
                print(error.description)
            }
            catch {
                print("error Task")
            }
        }
    }
}
