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
    
    func selectColor(_ controller: UIViewController){
    }
    func completeAddPlan(_ plan: PlanModel){
        
        
    }
    
}
