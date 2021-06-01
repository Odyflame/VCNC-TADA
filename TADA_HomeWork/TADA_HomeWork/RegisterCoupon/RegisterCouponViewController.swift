//
//  RegisterCouponViewController.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/27.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

protocol RegisterCouponDelegate {
    func registerCoupon(coupon: String)
}

class RegisterCouponViewController: UIViewController {

    enum Constant {
        static let title = "쿠폰"
        static let CouponResisterText = "쿠폰 등록"
        static let CouponPlaceHolder = "쿠폰 이름"
        static let RegisterText = "등록하기"
        static let RegisterError = "쿠폰 등록 오류"
        static let ResigerRightText = "쿠폰 이름을 정확히 입력해주세요"
    }
    
    lazy var couponRegisterDescriptionLabel = UILabel().then {
        $0.textColor = Color.black
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
        $0.layer.cornerRadius = 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.buttonBorderColor?.cgColor
        
        $0.setTitle(Constant.RegisterText, for: .normal)
        $0.setTitleColor(Color.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    let disposeBag = DisposeBag()
    var delegate: RegisterCouponDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        configureLayout()
        bindRx()
    }
    
    func setUpView() {
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = Constant.title
        self.view.backgroundColor = Color.white
    }
    
    func configureLayout() {
        
        view.addSubview(couponRegisterDescriptionLabel)
        view.addSubview(couponTextField)
        view.addSubview(strokeView)
        view.addSubview(registerButton)
        
        couponRegisterDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(25)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-25)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(73)
        }
        
        couponTextField.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(35)
            make.top.equalTo(couponRegisterDescriptionLabel.snp.bottom).offset(27)
        }
        
        strokeView.snp.makeConstraints { make in
            make.top.equalTo(couponTextField.snp.bottom).offset(7)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(25)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-109)
            make.height.equalTo(1)
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-33)
            make.leading.equalTo(couponTextField.snp.trailing).offset(43)
            make.width.equalTo(66)
            make.height.equalTo(32)
            make.centerY.equalTo(couponTextField.snp.centerY)
        }
    }
    
    func bindRx() {
        registerButton.rx.tap
            .subscribe { [weak self] response in
                
                guard let text = self?.couponTextField.text,
                      text != "" else {
                    self?.showCouponAlertView()
                    return
                }
                
                self?.delegate?.registerCoupon(coupon: text)
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
    
    private func showCouponAlertView() {
        let alertView = UIAlertController(title: Constant.RegisterError, message: Constant.ResigerRightText, preferredStyle: .alert)
        
        self.present(alertView, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alertView.dismiss(animated: true, completion: nil)
        }
    }
}
