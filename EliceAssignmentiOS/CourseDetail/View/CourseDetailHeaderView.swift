//
//  CourseDetailHeaderView.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/20.
//

import Foundation
import UIKit
import Then
import SnapKit
import Kingfisher

class CourseDetailHeaderView: UIView {
    
    let imageView = UIImageView()
    
    let titleLabel = UILabel()
    
    let shortDescriptionLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData(title: String?, url: String?, shortDescription: String?) {
        self.setupUI(title: title, shortDescription: shortDescription, url: url)
    }
    
    private func setupUI(title: String?, shortDescription: String?, url: String?) {
        if let title = title {
            self.titleLabel.text = title
        }
        if let shortDescription = shortDescription {
            self.shortDescriptionLabel.text = shortDescription
        }
        if let url = url {
            self.imageView.kf.setImage(with: URL(string: url))
            titleViewWithImage()
        } else {
            titleViewWithoutImage()
        }
    }
    
    private func titleViewWithImage() {
        let logoView = UIView().then {
            $0.backgroundColor = .defaultLogoBackgroundColor
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        
        let logoImage = UIImageView().then {
            $0.image = .init(named: "DefaultLectureLogo")
        }
        logoView.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let titleView = UIView()
        
        self.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        titleView.addSubview(logoView)
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(36)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-8)
        }
        
        titleView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(52)
        }
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(snp.width).dividedBy(2)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func titleViewWithoutImage() {
        let logoView = UIView().then {
            $0.backgroundColor = .defaultLogoBackgroundColor
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        let logoImage = UIImageView().then{
            $0.image = .init(named: "DefaultLectureLogo")
        }
        logoView.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        self.titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        self.shortDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        self.addSubview(logoView)
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(56)
        }
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.greaterThanOrEqualTo(36)
        }
        self.addSubview(shortDescriptionLabel)
        shortDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.greaterThanOrEqualTo(20)
        }
    }
}
