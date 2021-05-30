//
//  ChooseOptionViewController.swift
//  TADA_HomeWork
//
//  Created by apple on 2021/05/26.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Network

class ChooseOptionViewController: UIViewController {
    
    enum Constant {
        static let height: CGFloat = 74
    }
    
    lazy var contentView = UILabel().then {
        $0.backgroundColor = Color.white
        $0.isUserInteractionEnabled = true
    }
    
    lazy var liteCarView = CarOptionView().then {
        $0.backgroundColor = Color.white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectLiteOption))
        $0.addGestureRecognizer(gesture)
        $0.isUserInteractionEnabled = true
    }
    
    lazy var plusCarView = CarOptionView().then {
        $0.backgroundColor = Color.white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectPlusOption))
        $0.addGestureRecognizer(gesture)
        $0.isUserInteractionEnabled = true
    }
    
    lazy var couponView = CouponRegisterView().then {
        $0.backgroundColor = Color.white
    }
    
    lazy var callButton = UIButton().then {
        $0.setTitle("호출하기", for: .normal)
        $0.backgroundColor = Color.midNight
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = .boldSystemFont(ofSize: 13)
    }
    
    var viewModel = RideEstimationsViewModel()
    let disposeBag = DisposeBag()
    var selectedOptionName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.gray
        
        configureLayout()
        bindViewModel()
        viewModel.input.getRideEstimations()
    }
    
    func bindViewModel() {
        viewModel.output.liteEstimation
            .subscribe(onNext: { [weak self] result in
                guard let self = self,
                      let result = result else {
                    return
                }
                
                self.liteCarView.configure(data: result)
                
            }).disposed(by: disposeBag)
        
        viewModel.output.plusEstimation
            .subscribe(onNext: { [weak self] result in
                guard let self = self,
                      let result = result else {
                    return
                }
                
                self.plusCarView.configure(data: result)
                
            }).disposed(by: disposeBag)
        
        callButton.rx.tap
            .subscribe(onNext: {
                
                if self.couponView.isRegisterCoupon {
                    self.presentAlert(title: self.selectedOptionName, message: self.couponView.couponStatus.text)
                } else {
                    self.presentAlert()
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    func presentAlert(title: String = "차가 없네요!", message: String? = "먼저 차량을 선택해주세요!") {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func configureLayout() {
        view.addSubview(contentView)
        contentView.addSubview(liteCarView)
        contentView.addSubview(plusCarView)
        contentView.addSubview(couponView)
        contentView.addSubview(callButton)
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(282)
        }
        
        liteCarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(Constant.height)
        }
        
        plusCarView.snp.makeConstraints { make in
            make.top.equalTo(liteCarView.snp.bottom)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(Constant.height)
        }
        
        couponView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.lessThanOrEqualTo(plusCarView.snp.bottom).offset(28)
            make.bottom.lessThanOrEqualTo(callButton.snp.top).offset(-28)
        }
        
        callButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-10)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.height.equalTo(54)
        }
    }
    
    @objc
    func selectLiteOption(_ sender: UITapGestureRecognizer) {
        
        liteCarView.backgroundColor = Color.skyblue
        plusCarView.backgroundColor = Color.white
        selectedOptionName = liteCarView.carName.text ?? ""
        callButton.setTitle("\(liteCarView.carName) 호출", for: .normal)
    }
    
    @objc
    func selectPlusOption(_ sender: UITapGestureRecognizer) {
        
        liteCarView.backgroundColor = Color.white
        plusCarView.backgroundColor = Color.skyblue
        selectedOptionName = plusCarView.carName.text ?? ""
        callButton.setTitle("\(plusCarView.carName) 호출", for: .normal)
    }
    
    func animateView(_ view: CarOptionView) {
        
    }
}
