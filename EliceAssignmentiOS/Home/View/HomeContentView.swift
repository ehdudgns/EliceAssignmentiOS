//
//  HomeContentView.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/19.
//

import Foundation
import UIKit
import Then
import SnapKit

class HomeContentView: UIView {
    
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 16
        $0.scrollDirection = .horizontal
    }
    
    
    lazy var collectionView = UICollectionView(frame: .zero,collectionViewLayout: collectionViewFlowLayout).then {
        $0.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        $0.backgroundColor = .white
        $0.register(CourseCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    init(titleMessage: String) {
        super.init(frame: .zero)
        self.titleLabel.text = titleMessage
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        self.backgroundColor = .white
        
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}

