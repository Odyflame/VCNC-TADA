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
    var toastViewModel = RideStatusViewModel()
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
        
        toastViewModel.output.rideToast
            .subscribe(onNext: { [weak self] result in
                
                self?.showToast(message: result)
                
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
        
        updateOptionView(to: liteCarView, from: plusCarView)
    }
    
    @objc
    func selectPlusOption(_ sender: UITapGestureRecognizer) {
        
        updateOptionView(to: plusCarView, from: liteCarView)
    }
    
    func updateOptionView(to selectedView: CarOptionView, from deSelected: CarOptionView) {
        
        selectedView.backgroundColor = Color.skyblue
        deSelected.backgroundColor = Color.white
        selectedOptionName = selectedView.carName.text ?? ""

        UIView.animate(withDuration: 1,
                       animations: {
                        selectedView.carImage.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                        deSelected.carImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                       },
                       completion: nil)
        
        guard let callButtonText = selectedView.carName.text else {
            callButton.setTitle("호출하기", for: .normal)
            return
        }
        callButton.setTitle("\(callButtonText) 호출", for: .normal)
    }
    
    func showToast(message: String ) {
        let toastLabel = ToastMessageView()
        toastLabel.configure(message: message)
        
        self.view.addSubview(toastLabel)
        UIView.animate(
            withDuration: 4.0,
            delay: 0.3,
            options: .curveEaseOut) {
            toastLabel.alpha = 0
        } completion: { _ in
            toastLabel.removeFromSuperview()
        }

    }
    
}
