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

class addPlanViewModel {
    let formmatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd-HH-mm"
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
        let plan = PlanModel(date: controller.selectedDay, color: controller.colorSelect.selectedColor!.toHexString(), title: controller.todoField.text ?? "제목 없음", memo: controller.memoField.text, start: formmatter.string(from: controller.startDate.date), end: formmatter.string(from: controller.endDate.date), isComplete: false, uuid: uuid)
//        PlanStorage.createData(plan)
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}
