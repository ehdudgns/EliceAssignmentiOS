//
//  CourseDetailViewController.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/19.
//

import Foundation
import UIKit
import Then
import SnapKit
import Down
import Combine
import WebKit

class CourseDetailViewController: UIViewController {
    
    enum Text {
        static let courseApply = "수강 신청"
        static let cancelApply = "수강 취소"
    }
    
    private var cancelBag = Set<AnyCancellable>()
    var viewModel: CourseDetailViewModel? = nil
    
    let scrollView = UIScrollView()
    
    let scrollContentView = UIStackView().then {
        $0.axis = .vertical
    }
    
    let titleView = CourseDetailHeaderView()
    
    let descriptionView = CourseContentView(type: .courseDescription)
    
    let lectureView = CourseContentView(type: .lecture)
    
    let button = UIButton().then {
        $0.backgroundColor = .elicePrimary
        $0.setTitle(Text.courseApply, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(applyCancel), for: .touchUpInside)
    }
    
    
    
    private func bindCombine() {
        viewModel?.$course.dropFirst().receive(on: DispatchQueue.main).sink(receiveValue: {[weak self] _ in
            guard let sself = self else { return }
            sself.fetchCourseData()
        }).store(in: &cancelBag)

        viewModel?.$lectures.dropFirst().receive(on: DispatchQueue.main).sink(receiveValue: {[weak self] _ in
            guard let sself = self else { return }
            sself.fetchLectureData()
        }).store(in: &cancelBag)
        
        
    }
    
    func fetchLectureData() {
        if let lectures = viewModel?.lectures {
            self.lectureView.configLectureData(lectures: lectures)
            self.lectureView.isHidden = false
        } else {
            lectureView.isHidden = true
        }
    }
    
    func fetchCourseData() {
        let course = viewModel?.course
        
        self.titleView.fetchData(title: course?.title, url: course?.imageFileUrl, shortDescription: course?.shortDescription)
        
        if let description = course?.description {
            self.descriptionView.configDescriptionData(description: description)
            self.descriptionView.isHidden = false
        } else {
            self.descriptionView.isHidden = true
        }
    }
    
    private func setupConstraints() {
        self.view.addSubview(titleView)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        
        scrollContentView.addSubview(descriptionView)
        descriptionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(0)
        }
        
        
        scrollContentView.addSubview(lectureView)
        lectureView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        self.scrollView.addSubview(scrollContentView)
        
        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
       
        
         
         self.view.addSubview(self.button)
         self.button.snp.makeConstraints {
             $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
             $0.leading.equalToSuperview().offset(16)
             $0.trailing.equalToSuperview().offset(-16)
             $0.height.equalTo(48)
         }
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.button.snp.top)
        }
    }
    
    private func setupNav() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = false
        let backButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backPage)).then {
            $0.tintColor = .black
        }
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNav()
        
        self.bindCombine()
        
        self.setupConstraints()
       
    }
    
    
    @objc func backPage() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func applyCancel() {
        if let viewModel = viewModel {
            if viewModel.isApplyCourse() {
                button.backgroundColor = .elicePrimary
                button.setTitle(Text.courseApply, for: .normal)
                viewModel.deleteMyCourse()

            } else {
                button.backgroundColor = .eliceRed
                button.setTitle(Text.cancelApply, for: .normal)
                viewModel.saveMyCourse()
            }
        }
    }
}

