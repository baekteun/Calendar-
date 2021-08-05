//
//  PlanCell.swift
//  Calendar
//
//  Created by baegteun on 2021/08/05.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import BEMCheckBox
protocol isCompleteDelegate:class {
    func didTapCompletebtn()
}
class PlanCell: UITableViewCell{
    // MARK: - Properties
    weak var delegate: isCompleteDelegate?
    let viewModel = CalendarCellViewModel()
    var selectedDay: String!
    var indexPath: IndexPath!{
        didSet{ configureUI()}
    }
    lazy var planss = [viewModel.getPlan(selectedDay,false),
                 viewModel.getPlan(selectedDay, true) ]
    
    lazy var plan = planss[indexPath.section][indexPath.row]
    
    lazy var colorLabel = UILabel().then {
        $0.backgroundColor = Extensions.getColor(plan.color)
        $0.layer.cornerRadius = 6
    }
    lazy var completeBtn = BEMCheckBox().then {
        $0.boxType = .square
        $0.tintColor = .lightGray
        $0.onAnimationType = .stroke
        $0.offAnimationType = .stroke
        $0.onTintColor = .systemBlue
        $0.onFillColor = .white
        $0.onCheckColor = .systemBlue
        $0.setOn(plan.isComplete, animated: true)
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
        self.textLabel?.text = "      "+plan.title
        if indexPath.section == 1{
            let attributedString = NSMutableAttributedString(string: self.textLabel!.text!)
            attributedString.addAttribute(.baselineOffset, value: 0, range: (attributedString.string as NSString).range(of: attributedString.string))

            attributedString.addAttribute(.strikethroughStyle, value: 1, range: (attributedString.string as NSString).range(of: attributedString.string))
            self.textLabel?.attributedText = attributedString
        }else{
            let attributedString = NSMutableAttributedString(string: self.textLabel!.text!)
            attributedString.addAttribute(.baselineOffset, value: 0, range: (attributedString.string as NSString).range(of: attributedString.string))
            self.textLabel?.attributedText = attributedString
        }
        
        
        self.addSubview(colorLabel)
        colorLabel.snp.makeConstraints {
//            $0.top.equalTo(self).offset(10)
//            $0.bottom.equalTo(self).offset(-10)
            $0.left.equalTo(self)
            $0.height.equalTo(50)
            $0.width.equalTo(5)
        }
        addSubview(completeBtn)
        completeBtn.snp.makeConstraints {
            $0.left.equalTo(colorLabel.snp.right).offset(10)
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(self)
        }
        completeBtn.delegate = self
        
        
        
    }
}

extension PlanCell: BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.on{
            plan.isComplete = true
        }else{
            plan.isComplete = false
        }
        viewModel.updateData(plan)
        print("debug")
        self.delegate?.didTapCompletebtn()
    }
}
