//
//  addPlanViewController.swift
//  Calendar
//
//  Created by baegteun on 2021/08/06.
//

import UIKit
import RxSwift
import RxCocoa

class addPlanViewController: UIViewController{
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let colorSelect = UIButton().then {
        $0.backgroundColor = .systemGreen
    }
    let todoLabel = UILabel().then {
        $0.text = "할일 추가"
        $0.backgroundColor = .clear
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let todoField = UITextField().then {
        $0.placeholder = "새 일정"
        $0.font = UIFont.systemFont(ofSize: 22)
    }
    
    let memoField = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .lightGray
        $0.text = "메모"
    }
    
    lazy var startDate = UIDatePicker().then {
        $0.locale = Locale(identifier: "Ko_kr")
        
    }
    
    lazy var endDate = UIDatePicker().then {
        $0.locale = Locale(identifier: "Ko_kr")
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindView()
    }
    
    // MARK: - Actions
    @objc func minimumUpdate(){
        endDate.minimumDate = startDate.date
    }
    
    // MARK: - Helpers
    func bindView(){
        memoField.rx.didBeginEditing
            .asDriver()
            .drive(onNext: { [self] in
                if memoField.text == "메모"{
                    memoField.text = nil
                    memoField.textColor = .black
                }
            })
            .disposed(by: disposeBag)
        memoField.rx.didEndEditing
            .asDriver()
            .drive(onNext: { [self] in
                if memoField.text == nil || memoField.text == ""{
                    memoField.text = "메모"
                    memoField.textColor = .lightGray
                }
            })
            .disposed(by: disposeBag)
        memoField.rx.text
            .asDriver()
            .drive(onNext: { memo in
                Extensions.autoSizingTextView(self.memoField)
            })
            .disposed(by: disposeBag)
        startDate.rx.value
            .subscribe(onNext:{ value in
                self.endDate.minimumDate = value
            })
            .disposed(by: disposeBag)
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        addSubview()
        
        colorSelect.snp.makeConstraints {
            $0.top.equalTo(view).offset(65)
            $0.left.equalTo(view).offset(20)
            $0.width.height.equalTo(15)
        }
        colorSelect.layer.cornerRadius = 7.5
        
        todoLabel.snp.makeConstraints {
            $0.left.equalTo(view).offset(35)
            $0.top.equalTo(view).offset(35)
        }
        
        todoField.snp.makeConstraints {
            $0.left.equalTo(colorSelect.snp.right).offset(10)
            $0.top.equalTo(view).offset(60)
        }
        
        memoField.snp.makeConstraints {
            $0.top.equalTo(view).offset(90)
            $0.left.equalTo(view).offset(20)
            $0.right.equalTo(view).offset(-20)
            $0.height.equalTo(50)
        }
        
        startDate.snp.makeConstraints {
            $0.top.equalTo(memoField.snp.bottom).offset(10)
            $0.left.equalTo(view).offset(20)
        }
        
        endDate.snp.makeConstraints {
            $0.top.equalTo(startDate.snp.bottom).offset(10)
            $0.left.equalTo(view).offset(20)
        }
        
        
        
    }
    
    func addSubview(){
        view.addSubview(colorSelect)
        view.addSubview(todoLabel)
        view.addSubview(todoField)
        view.addSubview(memoField)
        view.addSubview(startDate)
        view.addSubview(endDate)
    }
    
    
    
}
