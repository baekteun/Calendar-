//
//  PlanCell.swift
//  Calendar
//
//  Created by baegteun on 2021/08/05.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import BEMCheckBox
import UIColor_Hex_Swift

protocol CompleteDelegate:class {
    func didComplete()
}

class PlanCell: UITableViewCell{
    // MARK: - Properties
    weak var delegate: CompleteDelegate?
    let storage = PlanStorage()
    let viewModel = CalendarCellViewModel()
    var plan: PlanModel!{
        didSet { configureUI()}
    }
    var indexPath: IndexPath?
    lazy var colorLabel = UILabel().then {
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    lazy var completeBtn = BEMCheckBox().then {
        $0.boxType = .square
        $0.tintColor = .lightGray
        $0.onAnimationType = .stroke
        $0.offAnimationType = .stroke
        $0.onTintColor = .systemBlue
        $0.onFillColor = .white
        $0.onCheckColor = .systemBlue
    }
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        completeBtn.setOn(plan.isComplete, animated: true)
        print(plan.isComplete, plan.title)
        self.textLabel?.attributedText = nil
        let attributedString = NSMutableAttributedString(string: "      "+plan.title)
        attributedString.addAttribute(.baselineOffset, value: 0, range: (attributedString.string as NSString).range(of: attributedString.string))
        if plan.isComplete == true{
            attributedString.addAttribute(.strikethroughStyle, value: 1, range: (attributedString.string as NSString).range(of: attributedString.string))
        }
        self.textLabel?.attributedText = attributedString
        
        
        self.addSubview(colorLabel)
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.bottom.equalTo(self).offset(-10)
            $0.left.equalTo(self)
            $0.width.equalTo(5)
        }
        colorLabel.backgroundColor = UIColor(plan.color)
        addSubview(completeBtn)
        completeBtn.delegate = self
        completeBtn.snp.makeConstraints {
            $0.left.equalTo(colorLabel.snp.right).offset(10)
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(self)
        }
        
        
        
        
    }
}


extension PlanCell: BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        plan.isComplete = checkBox.on
        PlanStorage.updateData(plan)
        self.delegate?.didComplete()
    }
}
