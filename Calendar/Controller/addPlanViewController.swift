//
//  addPlanViewController.swift
//  Calendar
//
//  Created by baegteun on 2021/08/06.
//

import UIKit


class addPlanViewController: UIViewController{
    // MARK: - Properties
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
        $0.text = "testtest"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.5
    }
    
    let startDate = UIDatePicker()
    
    let endDate = UIDatePicker()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Helpers
    
    
    
}
