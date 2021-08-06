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
import RxCocoa

class addPlanViewModel {
    
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
    
}
