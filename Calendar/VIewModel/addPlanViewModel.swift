//
//  addPlanViewModel.swift
//  Calendar
//
//  Created by baegteun on 2021/08/06.
//

import Foundation
import UIKit
import RxRealm
import RealmSwift
import RxSwift
import DropDown
//import SwiftEntryKit
import RxCocoa

class addPlanViewModel {
    let storage = PlanStorage()
    
    func TextViewDidBegin(_ textview: UITextView){
        if textview.text == "메모"{
            textview.text = nil
            textview.textColor = .black
        }
    }
    func TextViewDidEnd(_ textview: UITextView){
        if textview.text == nil || textview.text == ""{
            textview.text = "메모"
            textview.textColor = .lightGray
        }
    }
    func showSelectView(){
        let colorArray = [ [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue], [UIColor.systemRed, UIColor.systemOrange, UIColor.systemYellow, UIColor.systemGray, UIColor.systemBlue]]
        let dropdown = DropDown()
        
    }
//    func showSelectView(){
//        var attributes = EKAttributes.centerFloat
//        attributes.entryBackground = .color(color: .white)
//        attributes.entranceAnimation = .translation
//        attributes.border = .value(color: .lightGray, width: 0.7)
//        attributes.exitAnimation = .translation
//        let selectView = UIView().then {
//            $0.layer.cornerRadius = 8
//            $0.snp.makeConstraints {
//                $0.width.equalTo(240)
//                $0.height.equalTo(100)
//            }
//        }
//        SwiftEntryKit.display(entry: selectView, using: attributes)
//    }
    func completeAddPlan(_ plan: PlanModel){
        
    }
    
}
