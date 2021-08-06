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
    
    func createData(_ plan: PlanModel){
        Observable.just(plan)
            .subscribe(realm.rx.add())
            .disposed(by: disposeBag)
    }
    func deleteData(_ plan: PlanModel){
        let del = realm.object(ofType: PlanModel.self, forPrimaryKey: plan.uuid)!
        Observable.just(del)
            .subscribe(realm.rx.delete())
            .disposed(by: disposeBag)
    }
    func updateData(_ plan: PlanModel){
        guard let dats = realm.object(ofType: PlanModel.self, forPrimaryKey: plan.uuid) else { return }
        
        try! realm.write({
            dats.score = plan.score
            dats.color = plan.color
            dats.isComplete = plan.isComplete
            dats.start = plan.start
            dats.end = plan.end
            dats.title = plan.title
            dats.memo = plan.memo
        })
    }
    
    func getPlan(_ day: String,_ isCompleted: Bool) -> [PlanModel]{
        let plan: [PlanModel] = realm.objects(PlanModel.self).filter("date == %@ AND isComplete == %@", day, isCompleted).map({PlanModel(date: $0.date, score: $0.score, color: $0.color, title: $0.title, memo: $0.memo, start: $0.start, end: $0.end,isComplete: $0.isComplete, uuid: $0.uuid)})
        return plan
    }
    
    func getPlan(_ day: String) -> [PlanModel]{
        let plan: [PlanModel] = realm.objects(PlanModel.self).filter("date == %@ ", day).map({PlanModel(date: $0.date, score: $0.score, color: $0.color, title: $0.title, memo: $0.memo, start: $0.start, end: $0.end,isComplete: $0.isComplete, uuid: $0.uuid)})
        return plan
    }
    
    func showMakePlan(_ controller: UIViewController){
        let bottomSheet = MDCBottomSheetController(contentViewController: addPlanViewController())
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 600
        bottomSheet.scrimColor = UIColor.black.withAlphaComponent(0.4)
        
        controller.present(bottomSheet, animated: true)
    }
    
    
}
