//
//  LectureLine.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/21.
//
import Then
import SnapKit
import Foundation
import UIKit

class LectureLine: UIView {
    
    private let isFirst: Bool
    
    private let isLast: Bool
    
    init(isFirst: Bool, isLast: Bool) {
        self.isFirst = isFirst
        self.isLast = isLast
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let dotView = UIView().then {
            $0.setBoder(radius: 8, width: 2, color: .elicePrimary)
            $0.backgroundColor = .white
        }
        
        let firstLineView = UIView().then {
            $0.backgroundColor = self.isFirst ? .white : .elicePrimary
        }
        
        let lastLineView = UIView().then {
            $0.backgroundColor = self.isLast ? .white : .elicePrimary
        }
        
        self.addSubview(firstLineView)
        firstLineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(2)
            $0.height.equalTo(14)
        }
        
        self.addSubview(dotView)
        dotView.snp.makeConstraints {
            $0.top.equalTo(firstLineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        
        self.addSubview(lastLineView)
        lastLineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dotView.snp.bottom)
            $0.width.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
}
