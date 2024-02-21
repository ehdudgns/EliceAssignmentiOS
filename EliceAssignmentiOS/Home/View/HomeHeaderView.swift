//
//  File.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/19.
//

import Foundation
import UIKit
import SnapKit
import Then

class HomeHeaderView: UIView {
    
    private let logoView = UIImageView().then {
        $0.image = .init(named: "Logo")
    }
    
    let searchButton = UIButton().then {
        $0.setImage(.init(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .black
    }
    
    private let searchIcon = UIImageView().then {
        $0.image = .init(systemName: "magnifyingglass")
        $0.tintColor = .black
    }
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        self.addSubview(self.logoView)

        self.logoView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        self.addSubview(self.searchButton)
        
        self.searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(32)
        }
    }
    
}
