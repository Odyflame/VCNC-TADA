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

class CouponRegisterView: UIView {

    lazy var couponStackView = UIStackView(arrangedSubviews: [couponImage, couponDescriptionStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    lazy var couponImage = UIImageView().then {
        $0.image = UIImage(named: "btn_coupon_edit")
    }
    
    lazy var couponDescriptionStackView = UIStackView(arrangedSubviews: [couponStatus, couponDescription]).then {
        $0.axis = .vertical
        $0.alignment = .fill
    }
    
    lazy var couponStatus = UILabel().then {
        $0.text = "보유한 쿠폰 없음"
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(couponStackView)
        
        couponStackView.snp.makeConstraints { make in
            
        }
    }
    
    func configure(couponName: String) {
        couponDescription.text = couponName
        couponStatus.textColor = Color.couponRegisterColor
        
        isRegisterCoupon = true
    }
    
    func configureInit() {
        couponDescription.text = ""
        couponStatus.textColor = Color.couponPlaceHolder
    }
}
