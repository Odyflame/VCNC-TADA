//
//  AlertCarAvailableView.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/28.
//

import UIKit
import SnapKit
import Then

final class AlertCarAvailableView: UIView {
    
    lazy var alertView = UILabel().then {
        $0.frame = CGRect(x: 0, y: 0, width: 173, height: 36)
        $0.backgroundColor = .white
    }

    lazy var shadows = UIView().then {
        $0.frame = alertView.frame
        $0.clipsToBounds = false
    }
    
    lazy var shadowPath0 = UIBezierPath(roundedRect: self.shadows.bounds, cornerRadius: 4)
    
    lazy var layer0 = CALayer().then {
        $0.shadowPath = shadowPath0.cgPath
        $0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        $0.shadowOpacity = 1
        $0.shadowRadius = 4
        $0.shadowOffset = CGSize(width: 0, height: 2)
        $0.bounds = shadows.bounds
        $0.position = shadows.center
    }
    
    lazy var shapes = UIView().then {
        $0.frame = alertView.frame
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    lazy var layer1 = CALayer().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.bounds = shapes.bounds
        $0.position = shapes.center
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.frame = CGRect(x: 0, y: 0, width: 301, height: 16)
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
        $0.textAlignment = .center
        $0.text = "근처에 플러스 차량이 많지 않아 더 넓은 범위로 요청합니다."
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(alertView)
        alertView.addSubview(shadows)
        shadows.layer.addSublayer(layer0)
        alertView.addSubview(shapes)
        shapes.layer.addSublayer(layer1)
        alertView.addSubview(descriptionLabel)
    }
    
    func configure(message: String) {
        self.descriptionLabel.text = message
    }
}
