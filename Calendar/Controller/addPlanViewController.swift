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
    let viewModel = addPlanViewModel()
    let disposeBag = DisposeBag()
    var selectedDay = String()
    let colorSelect = UIColorWell(frame: CGRect(x: 0, y: 0, width: 15, height: 15)).then {
        $0.selectedColor = .systemGreen
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
    
    let endLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.text = "종료"
    }
    
    
    let endDate = UIDatePicker().then {
        $0.locale = Locale(identifier: "Ko_kr")
        
    }
    
    let completeButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "check (1) (1)"), for: .normal)
        $0.layer.borderWidth = 1.2
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        $0.layer.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        $0.clipsToBounds = true
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindView()
        
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    func bindView(){
        
        memoField.rx.didBeginEditing
            .asDriver()
            .drive(onNext: { [self] in
                viewModel.TextViewDidBegin(memoField)
            })
            .disposed(by: disposeBag)
        
        memoField.rx.didEndEditing
            .asDriver()
            .drive(onNext: { [self] in
                viewModel.TextViewDidEnd(memoField)
            })
            .disposed(by: disposeBag)
        
        memoField.rx.text
            .asDriver()
            .drive(onNext: { memo in
                Extensions.autoSizingTextView(self.memoField)
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .subscribe(onNext: { [self] in
                self.viewModel.completeAddPlan(self)
            })
            .disposed(by: disposeBag)
        
        
    }
    func addSubview(){
        view.addSubview(colorSelect)
        view.addSubview(todoLabel)
        view.addSubview(todoField)
        view.addSubview(memoField)
        view.addSubview(endDate)
        view.addSubview(endLabel)
        view.addSubview(completeButton)
    }
    
    func configureUI(){
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        addSubview()
        
        colorSelect.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(view.frame.height/15)
            $0.left.equalTo(view.snp.left).offset(view.frame.width/100)
        }
        
        todoLabel.snp.makeConstraints {
            $0.left.equalTo(view.snp.left).offset(view.frame.width/15)
            $0.top.equalTo(view.snp.top).offset(view.frame.height/24)
        }
        
        todoField.snp.makeConstraints {
            $0.left.equalTo(colorSelect.snp.right).offset(view.frame.width/60)
            $0.top.equalTo(colorSelect.snp.top)
        }
        
        memoField.snp.makeConstraints {
            $0.top.equalTo(todoField.snp.top).offset(view.frame.height/25)
            $0.left.equalTo(view.snp.left).offset(view.frame.width/20)
            $0.right.equalTo(view.snp.right).inset(view.frame.width/20)
            $0.height.equalTo(view.frame.height/16)
        }
        
        endDate.snp.makeConstraints {
            $0.top.equalTo(memoField.snp.bottom).offset(view.frame.height/80)
            $0.left.equalTo(memoField.snp.left)
        }
        
        endLabel.snp.makeConstraints {
            $0.top.equalTo(endDate.snp.top).offset(view.frame.height/160)
            $0.right.equalTo(view.snp.right).inset(view.frame.width/30)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(endDate.snp.bottom).offset(view.frame.height/40)
            $0.left.equalTo(view.snp.left).offset(view.frame.width/14)
            $0.right.equalTo(view.snp.right).inset(view.frame.width/14)
            $0.height.equalTo(view.frame.height/24)
        }
        
    }
}
