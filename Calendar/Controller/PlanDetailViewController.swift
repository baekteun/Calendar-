//
//  PlanViewController.swift
//  Calendar
//
//  Created by baegteun on 2021/08/08.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import BEMCheckBox
import RxRealm
import RealmSwift


class PlanDetailViewController: UIViewController {
    // MARK: - Properties
    let viewModel = PlanDetailViewModel()
    let disposeBag = DisposeBag()
    let realm = try! Realm()
    var plan: PlanModel!{
        didSet{ configureUI()}
    }
    let formmater = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd HH-mm"
    }
    var colorWell = UIColorWell(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var planTitle = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 32)
        $0.backgroundColor = .clear
    }
    var hr = UILabel().then {
        $0.backgroundColor = .lightGray
    }
    var completeBtn = completeCheckbox()
    
    var memoField = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 22)
        $0.backgroundColor = .clear
    }
    
    
    var endSelector = UIDatePicker().then {
        $0.locale = Locale(identifier: "ko_kr")
    }
    
    var cancelBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
    }
    
    var trashBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(#imageLiteral(resourceName: "trash"), for: .normal)
    }
    
    var checkBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(#imageLiteral(resourceName: "check (1)"), for: .normal)
    }
    
    lazy var barView = UIView().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.2)
        let stack = UIStackView(arrangedSubviews: [cancelBtn,trashBtn,checkBtn])
        stack.axis = .horizontal
        stack.spacing = view.frame.width/3
        $0.addSubview(stack)
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        cancelBtn.rx.tap
            .subscribe(onNext:{
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        trashBtn.rx.tap
            .subscribe(onNext: {
                self.viewModel.planDelete(self.plan)
            })
            .disposed(by: disposeBag)
        
        checkBtn.rx.tap
            .subscribe(onNext: {
                self.reWritePlan()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        
    }
    
    // MARK: - Actions
    
    func reWritePlan(){
        let plan = PlanModel(date: plan.date, color: colorWell.selectedColor!.hexString(), title: planTitle.text, memo: memoField.text, end: endSelector.date.toString, isComplete: completeBtn.on, uuid: plan.uuid)
        viewModel.reWritePlan(plan)
    }
    
    // MARK: - Helpers
    func bindView(){
        planTitle.rx.text
            .asDriver()
            .drive(onNext: { _ in
                Extensions.autoSizingTextView(self.planTitle)
            })
            .disposed(by: disposeBag)
        
        memoField.rx.text
            .asDriver()
            .drive(onNext: { _ in
                Extensions.autoSizingTextView(self.memoField)
            })
            .disposed(by: disposeBag)
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
        addview()
        
        barView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(view.frame.height/12)
        }
       
        colorWell.snp.makeConstraints {
            $0.top.left.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height/30)
            
        }
        colorWell.selectedColor = UIColor(plan.color)
        
        planTitle.snp.makeConstraints {
            $0.top.equalTo(colorWell.snp.top)
            $0.left.equalTo(colorWell.snp.right).offset(view.frame.width/80)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(view.frame.width * 0.12)
            $0.height.equalTo(view.frame.height/20)
        }
        planTitle.text = plan.title
        
        hr.snp.makeConstraints {
            $0.top.equalTo(planTitle.snp.bottom).offset(2)
            $0.height.equalTo(1.5)
            $0.left.equalTo(planTitle.snp.left)
            $0.right.equalTo(planTitle.snp.right)
        }
        
        completeBtn.snp.makeConstraints {
            $0.top.equalTo(colorWell.snp.top)
            $0.left.equalTo(planTitle.snp.right).offset(5)
            $0.height.width.equalTo(view.frame.width/15)
        }
        
        memoField.snp.makeConstraints {
            $0.top.equalTo(planTitle.snp.bottom).offset(view.frame.height/80)
            $0.left.equalTo(colorWell.snp.left)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(view.frame.width/40)
            $0.height.equalTo(view.frame.height/20)
        }
        memoField.text = plan.memo
        
        endSelector.snp.makeConstraints {
            $0.top.equalTo(memoField.snp.bottom).offset(view.frame.height/40)
            $0.left.equalTo(memoField.snp.left)
        }
        endSelector.date = formmater.date(from: plan.end)!

    }
    
    func addview(){
        view.addSubview(barView)
        view.addSubview(colorWell)
        view.addSubview(planTitle)
        view.addSubview(hr)
        view.addSubview(completeBtn)
        view.addSubview(memoField)
        view.addSubview(endSelector)
    }
}
