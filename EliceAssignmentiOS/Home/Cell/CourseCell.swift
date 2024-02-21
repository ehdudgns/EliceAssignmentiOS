//
//  MainCell.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/18.
//

import Foundation
import UIKit
import Then
import SnapKit
import Kingfisher

class CourseCell: UICollectionViewCell {
    
    var flag = false
    
    let lectureLogo = UIView().then {
        $0.layer.cornerRadius = 10
    }
    
    let lectureImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.numberOfLines = 2
    }
    
    let lectureDescription = UILabel().then {
        $0.font = .systemFont(ofSize: 10, weight: .medium)
        $0.numberOfLines = 2
    }
    
    let lectureTags = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints2()
//        if flag {
//            self.setupConstraints2()
//        } else {
//            self.setupConstraints()
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints2() {
        let stackView = UIStackView().then {
            $0.axis = .vertical
        }
        
        stackView.addArrangedSubview(self.lectureImageView)
        self.lectureImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        let divideViewA = UIView().then {
            $0.backgroundColor = .white
        }
        stackView.addArrangedSubview(divideViewA)
        divideViewA.snp.makeConstraints {
            $0.top.equalTo(lectureImageView.snp.bottom)
            $0.height.equalTo(8)
        }
        
        stackView.addArrangedSubview(self.title)
        self.title.snp.makeConstraints {
            $0.top.equalTo(divideViewA.snp.bottom)
        }
        
        let dividViewB = UIView().then {
            $0.backgroundColor = .white
        }
        stackView.addArrangedSubview(dividViewB)
        dividViewB.snp.makeConstraints {
            $0.top.equalTo(self.title.snp.bottom)
            $0.height.equalTo(2)
        }
        
        stackView.addArrangedSubview(self.lectureDescription)
        self.lectureDescription.snp.makeConstraints {
            $0.top.equalTo(dividViewB.snp.bottom)
        }
        
        let dividViewC = UIView().then {
            $0.backgroundColor = .white
        }
        stackView.addArrangedSubview(dividViewC)
        dividViewC.snp.makeConstraints {
            $0.top.equalTo(self.lectureDescription.snp.bottom)
            $0.height.equalTo(8)
        }
        
        stackView.addArrangedSubview(self.lectureTags)
        self.lectureTags.snp.makeConstraints {
            $0.top.equalTo(dividViewC.snp.bottom)
        }
        
        let dividViewD = UIView().then {
            $0.backgroundColor = .white
        }
        stackView.addArrangedSubview(dividViewD)
        dividViewD.snp.makeConstraints {
            $0.top.equalTo(self.lectureTags.snp.bottom)
            $0.bottom.equalToSuperview()
        }
        
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupConstraints() {
        
        self.contentView.addSubview(self.lectureLogo)
        
        self.lectureLogo.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        self.contentView.addSubview(self.title)
        
        self.title.snp.makeConstraints {
            $0.top.equalTo(self.lectureLogo.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.contentView.addSubview(self.lectureDescription)
        
        self.lectureDescription.snp.makeConstraints {
            $0.top.equalTo(self.title.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.contentView.addSubview(self.lectureTags)
        
        self.lectureTags.snp.makeConstraints {
            $0.top.equalTo(self.lectureDescription.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    func configureData(model: Course) {
        self.flag = true
        self.title.text = model.title
        var url: URL? = nil
        if model.imageFileUrl == nil {
            url = URL(string: model.logoFileUrl)
        } else {
            url = URL(string: model.imageFileUrl!)
        }
        lectureImageView.kf.setImage(with: url)
        
        self.lectureDescription.text = model.shortDescription
        self.setStackView(tags: model.tagList)
        
        self.setupConstraints2()
    }
    
    func setStackView(tags:[String]) {
        
        removeArranedSubViews(from: self.lectureTags)
        
        tags.forEach {
            let label = UILabel().then {
                $0.font = .systemFont(ofSize: 8, weight: .bold)
            }
            label.text = $0
            let view = UIView()
            view.layer.cornerRadius = 4
            
            view.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
            
            view.addSubview(label)
            
            label.snp.makeConstraints {
                $0.top.equalToSuperview().offset(4)
                $0.bottom.equalToSuperview().offset(-4)
                $0.leading.equalToSuperview().offset(2)
                $0.trailing.equalToSuperview().offset(-2)
            }
            
            self.lectureTags.addArrangedSubview(view)
        }
    }
    
    func setData(title: String) {
        self.title.text = title
        self.setLogoImage(logoImage: nil)
        
        self.lectureDescription.text = "우선 지금 구현중 인데 두 줄 이상으로 해야하는데 해봅시다. 그렇다고 어케 만들지?? "
        
        removeArranedSubViews(from: self.lectureTags)
        
        ["tag","tag","tag","tag"].forEach {
            let label = UILabel().then {
                $0.font = .systemFont(ofSize: 8, weight: .bold)
            }
            label.text = $0
            let view = UIView()
            view.layer.cornerRadius = 4
            
            view.backgroundColor = .eliceLightGray
            
            view.addSubview(label)
            
            label.snp.makeConstraints {
                $0.top.equalToSuperview().offset(4)
                $0.bottom.equalToSuperview().offset(-4)
                $0.leading.equalToSuperview().offset(2)
                $0.trailing.equalToSuperview().offset(-2)
            }
            
            self.lectureTags.addArrangedSubview(view)
        }
        
        self.setupConstraints()
    }
    
    private func setLogoImage(logoImage: UIImage?) {
        
        let imageView = UIImageView()
        
        self.lectureLogo.addSubview(imageView)
        
        if let image = logoImage {
            self.lectureLogo.backgroundColor = .white
            imageView.image = image
            imageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        } else {
            self.lectureLogo.backgroundColor = .init(red: 58/255, green: 58/255, blue: 76/255, alpha: 1)
            
            imageView.image = .init(named: "DefaultLectureLogo")
            imageView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(22)
                $0.leading.equalToSuperview().offset(72)
                $0.trailing.equalToSuperview().offset(-72)
                $0.bottom.equalToSuperview().offset(-22)
                $0.size.equalTo(56)
            }
        }
    }
    
    private func removeArranedSubViews(from stackView: UIStackView) {
        for arrangedSubview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
    }
}
