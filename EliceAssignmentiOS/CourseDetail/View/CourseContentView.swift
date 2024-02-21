//
//  CourseContentView.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/21.
//

import Foundation
import UIKit
import Then
import SnapKit
import WebKit
import MapKit
import Down

class CourseContentView: UIView {
    
    enum CourseType {
        case courseDescription
        case lecture
    }
    
    private let type: CourseType
    
    let descriptionContentView = WKWebView()
    
    let lectureContentView = UIStackView().then {
        $0.axis = .vertical
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .detailViewSmallTitleColor
    }
    
    let dividView = UIView().then {
        $0.setBoder(radius: 1, width: 1, color: .dividViewBackgroundColor)
    }
    
    init(type: CourseType) {
        self.type = type
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let totalView = UIView()
        
        totalView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        totalView.addSubview(self.dividView)
        self.dividView.snp.makeConstraints{
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        switch self.type {
        case .courseDescription:
            self.titleLabel.text = "과목 소개"
            totalView.addSubview(self.descriptionContentView)
            self.descriptionContentView.snp.makeConstraints {
                $0.top.equalTo(self.dividView.snp.bottom).offset(10)
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.greaterThanOrEqualTo(56)
            }
        case .lecture:
            self.titleLabel.text = "커리큘럼"
            totalView.addSubview(self.lectureContentView)
            self.lectureContentView.snp.makeConstraints {
                $0.top.equalTo(self.dividView.snp.bottom).offset(10)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
        
        self.addSubview(totalView)
        totalView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configLectureData(lectures: [Lecture]) {
        for i in 0...lectures.count-1 {
            if i == 0 {
                addSubStackView(lecture: lectures[i], isFirst: true, isLast: false)
            } else if i == lectures.count - 1 {
                addSubStackView(lecture: lectures[i], isFirst: false, isLast: true)
            } else {
                addSubStackView(lecture: lectures[i], isFirst: false, isLast: false)
            }
        }
    }
    
    func configDescriptionData(description: String) {
        
        let down = Down(markdownString: description)
        let htmlString = try? down.toHTML()
        
        self.descriptionContentView.loadHTMLString(htmlString ?? "", baseURL: nil)
    }
    
    private func addSubStackView(lecture: Lecture, isFirst: Bool, isLast: Bool) {
        let view = UIView()

        let lineView = LectureLine(isFirst: isFirst, isLast: isLast)

        view.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        let contentView = UIView()

        let lectureTitle = UILabel().then {
            $0.text = lecture.title
            $0.font = .systemFont(ofSize: 18, weight: .bold)
        }

        let lectureDescription = UILabel().then {
            $0.text = lecture.description
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.numberOfLines = 0
        }

        contentView.addSubview(lectureTitle)
        lectureTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        contentView.addSubview(lectureDescription)
        lectureDescription.snp.makeConstraints {
            $0.top.equalTo(lectureTitle.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }

        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.leading.equalTo(lineView.snp.trailing).offset(8)
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        self.lectureContentView.addArrangedSubview(view)

    }
}
