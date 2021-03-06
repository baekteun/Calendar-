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
        let addPlanController = addPlanViewController()
        addPlanController.viewModel.delegate = controller
        addPlanController.selectedDay = controller.selectedDay
        let bottomSheet = MDCBottomSheetController(contentViewController: addPlanController)
        
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = controller.view.frame.height/1.5
        bottomSheet.scrimColor = UIColor.black.withAlphaComponent(0.4)
        
        controller.present(bottomSheet, animated: true)
    }
    
    
    func showDetailViewController(_ cell: PlanCell,_ controller1: CalendarViewController ){
        let controller2 = PlanDetailViewController()
        controller2.plan = cell.plan
        controller2.viewModel.delegate = controller1
        controller1.navigationController?.pushViewController(controller2, animated: true)
        
    }
    
    
}
