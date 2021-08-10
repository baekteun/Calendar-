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
import SwiftEntryKit
import RxCocoa
import UIColor_Hex_Swift

protocol createDelegate: class {
    func createDidFinish()
}

class addPlanViewModel {
    weak var delegate: createDelegate?
    let formmatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd HH-mm"
    }
    
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
    
    func completeAddPlan(_ controller: addPlanViewController){
        let uuid = "\(UUID.init())"
        var title = String()
        if controller.todoField.text == "" || controller.todoField.text == nil{
            title = "제목 없음"
        }else{
            title = controller.todoField.text!
        }
        let plan = PlanModel(date: controller.selectedDay, color: controller.colorSelect.selectedColor!.hexString(), title: title, memo: controller.memoField.text, start: formmatter.string(from: controller.startDate.date), end: controller.endDate.date.toString, isComplete: false, uuid: uuid)
        PlanStorage.createData(plan)
        controller.dismiss(animated: true) {
            self.delegate?.createDidFinish()
        }
    }
    
}
