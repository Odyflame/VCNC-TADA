//
//  RegisterCouponViewController.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/27.
//

import UIKit
import SnapKit
import Then

class RegisterCouponViewController: UIViewController {

    enum Constant {
        static let CouponResisterText = "쿠폰 등록"
        static let CouponPlaceHolder = "쿠폰 이름"
        static let RegisterText = "등록하기"
    }
    
    lazy var couponRegisterDescriptionLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.text = Constant.CouponResisterText
    }
    
    lazy var couponTextField = UITextField().then {
        $0.placeholder = Constant.CouponPlaceHolder
    }
    
    lazy var strokeView = UIView().then {
        $0.bounds = couponTextField.bounds.insetBy(dx: -0.5, dy: -0.5)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.couponStrokeColor?.cgColor
    }
    
    lazy var registerButton = UIButton().then {
        $0.setTitle(Constant.RegisterText, for: .normal)
        $0.layer.cornerRadius = 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.buttonBorderColor?.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        view.addSubview(couponRegisterDescriptionLabel)
        view.addSubview(couponTextField)
        view.addSubview(strokeView)
        view.addSubview(registerButton)
        
        
    }
    
}
