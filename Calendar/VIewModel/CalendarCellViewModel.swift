//
//  CalendarCellViewModel.swift
//  Calendar
//
//  Created by baegteun on 2021/08/04.
//

import UIKit
import RxRealm
import RxSwift
import RealmSwift
import MaterialComponents.MaterialBottomSheet
class CalendarCellViewModel {
    
    let realm = try! Realm()
    let disposeBag = DisposeBag()
    
    func showMakePlan(_ controller: CalendarViewController){
        let controlle = addPlanViewController()
        controlle.selectedDay = controller.selectedDay
        let bottomSheet = MDCBottomSheetController(contentViewController: controlle)
        
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 600
        bottomSheet.scrimColor = UIColor.black.withAlphaComponent(0.4)
        
        controller.present(bottomSheet, animated: true)
    }
    
    
}
