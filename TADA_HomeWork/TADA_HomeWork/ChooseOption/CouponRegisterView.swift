//
//  CouponRegisterView.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/28.
//

import UIKit
import SnapKit
import Then
import Network

final class CouponRegisterView: UIView {

    enum Constant {
        static let couponEmptyLabel = "보유한 쿠폰 없음"
        static let couponRegisterdLabel = "쿠폰 적용됨"
    }

    lazy var couponImage = UIImageView().then {
        $0.image = UIImage(named: "btn_coupon_edit")
    }
    
    lazy var couponDescriptionStackView = UIStackView(arrangedSubviews: [couponStatus, couponDescription]).then {
        $0.axis = .vertical
        $0.alignment = .fill
    }
    
    lazy var couponStatus = UILabel().then {
        $0.text = Constant.couponEmptyLabel
        $0.textColor = Color.couponPlaceHolder
        $0.font = .systemFont(ofSize: 12)
    }
    
    lazy var couponDescription = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = Color.couponRegisterColor
    }
    
    var isRegisterCoupon: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(couponImage)
        addSubview(couponDescriptionStackView)
        
        couponImage.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        couponDescriptionStackView.snp.makeConstraints { make in
            make.leading.equalTo(couponImage.snp.trailing).offset(5)
            make.top.trailing.bottom.equalTo(self)
        }
    }
    
    func configure(couponName: String) {
        couponDescription.text = couponName
        couponStatus.textColor = Color.couponRegisterColor
        couponStatus.text = Constant.couponRegisterdLabel
        isRegisterCoupon = true
    }
    
    func configureInit() {
        couponDescription.text = ""
        couponStatus.textColor = Color.couponPlaceHolder
        couponStatus.text = Constant.couponEmptyLabel
        isRegisterCoupon = false
    }
}
