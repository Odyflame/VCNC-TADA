//
//  TossMessageView.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/30.
//

import UIKit
import SnapKit
import Then

class ToastMessageView: UIView {
    lazy var toastLabel = UILabel().then {
        $0.textColor = Color.black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
        $0.textAlignment = .center
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.white
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.leading.equalTo(self.snp.leading).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-12)
        }
    }
    
    func configure(message: String) {
        toastLabel.text = message
    }
}
