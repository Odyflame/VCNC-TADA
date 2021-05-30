//
//  CarOptionView.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/28.
//

import UIKit
import SnapKit
import Then
import Network
import Kingfisher

//protocol CarOptionViewDelegate {
//    func didTap(send title: String)
//}

class CarOptionView: UIView {
    
    lazy var carImage = UIImageView().then {
        // 다른 기본 이미지가 있다면 기본 이미지로 교체할 것
        // 피그마에는 기본이미지가 없어 어쩔 수 없이 베타이미지로 설정
        $0.image = UIImage(named: "ic_thumbnail_lite_beta")
    }
    
    lazy var carDescriptionStackView = UIStackView(arrangedSubviews: [carName, carDescription]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 3
    }
    
    lazy var carName = UILabel().then {
        $0.text = "차량 확인 중"
        $0.font = .systemFont(ofSize: 13)
    }
    
    lazy var carDescription = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 12)
    }
    
    lazy var costStackView = UIStackView(arrangedSubviews: [expectCostLabel, originalCostLabel]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 3
    }
    
    lazy var expectCostLabel = UILabel().then {
        $0.text = "예상 0원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    lazy var originalCostLabel = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 8)
        $0.attributedText = $0.text?.strikeThrough()
    }
    
    //var delegate: CarOptionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(carImage)
        addSubview(carDescriptionStackView)
        addSubview(costStackView)
        
        carImage.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(10)
            make.top.equalTo(self).offset(11)
            make.bottom.equalTo(self).offset(-11)
            make.width.equalTo(carImage.snp.height).multipliedBy(1.5)
        }
        
        carDescriptionStackView.snp.makeConstraints { make in
            make.leading.equalTo(carImage.snp.trailing).offset(8)
            make.centerY.equalTo(carImage)
        }
        
        costStackView.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-22)
            make.centerY.equalTo(self)
            make.top.lessThanOrEqualTo(self).offset(29)
            make.bottom.lessThanOrEqualTo(self).offset(-29)
            make.width.equalTo(102)
        }
    }
    
    func configure(data: RideEstimation) {
        
        print(data.cost)
        self.expectCostLabel.text = "예상 \(data.cost ?? 0)원"
        self.carName.text = data.rideType.name
        self.carDescription.text = data.rideType.description
        
        guard let imageURL = data.rideType.image?.url else {
            return
        }
        
        
        let url = URL(string: imageURL)
        self.carImage.kf.setImage(with: url)
        
        guard let originalData = data.originalCost else {
            return
        }
        
        setNeedsLayout()
        self.originalCostLabel.attributedText = "예상 \(originalData)원".strikeThrough()
    }
    
}
