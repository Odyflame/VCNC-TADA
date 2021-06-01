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
    
    enum Constant {
        static let expectedInitLabel = "예상 X원"
        static let checkCarLabel = "차량 확인 중"
    }
    
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
        $0.text = Constant.checkCarLabel
        $0.font = .systemFont(ofSize: 13)
    }
    
    lazy var carDescription = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 12)
    }
    
    lazy var costStackView = UIStackView(arrangedSubviews: [expectCostLabel, originalCostLabel]).then {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }
    
    lazy var expectCostLabel = UILabel().then {
        $0.text = Constant.expectedInitLabel
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    lazy var originalCostLabel = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 8)
        $0.attributedText = $0.text?.strikeThrough()
        $0.textColor = Color.couponStrokeColor
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
//            make.top.lessThanOrEqualTo(self).offset(29)
//            make.bottom.lessThanOrEqualTo(self).offset(-29)
            make.width.equalTo(102)
        }
    }
    
    func configure(data: RideEstimation) {
        
        // 여기서 많이 이상한데 originalCost와 cost가 있는데 보통 OriginalCost가 더 크고, cost가 할인된 가격을 의미하는 것으로 이해할 텐데
        // original cost가 더 작고, cost가 더 크게 오고 있다.
        // 또한 사전과제의 예제 동영상을 보면 할인된 가격이 커지고, 원래 가격이 storkeThrough가 되어야 할 텐데 그 반대로 되있는 것이 좀 이상하다.
        // 확인 부탁드립니다.
        
        self.carName.text = data.rideType.name
        self.carDescription.text = data.rideType.description
        
        guard let imageURL = data.rideType.image?.url else {
            return
        }
        
        let url = URL(string: imageURL)
        self.carImage.kf.setImage(with: url)
        
        guard let cost = data.cost else {
            self.expectCostLabel.text = Constant.expectedInitLabel
            self.originalCostLabel.text = ""
            return
        }
        
        guard let originalCost = data.originalCost else {
            self.expectCostLabel.text = convertExpectCostToString(cost)
            self.originalCostLabel.text = ""
            return
        }
    
        self.expectCostLabel.text = convertExpectCostToString(originalCost)
        self.originalCostLabel.attributedText = convertExpectCostToString(cost).strikeThrough()
        costStackView.sizeToFit()
    }
    
    private func convertExpectCostToString(_ cost: Int) -> String {
        return "예상 \(cost)원"
    }
}
