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

class CalendarCellViewModel {
    
    let realm = try! Realm()
    let disposeBag = DisposeBag()
    
    func createData(_ plan: dbPlan){
        Observable.just(plan)
            .subscribe(realm.rx.add())
            .disposed(by: disposeBag)
    }
    func deleteData(_ plan: dbPlan){
        let del = realm.object(ofType: dbPlan.self, forPrimaryKey: plan.uuid)!
        Observable.just(del)
            .subscribe(realm.rx.delete())
            .disposed(by: disposeBag)
    }
    func updateData(_ plan: dbPlan){
        guard let dats = realm.object(ofType: dbPlan.self, forPrimaryKey: plan.uuid) else { return }
        
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
    func getPlan(_ day: String,_ isCompleted: Bool) -> [dbPlan]{
        let plan: [dbPlan] = realm.objects(dbPlan.self).filter("date == %@ AND isComplete == %@", day, isCompleted).map({dbPlan(date: $0.date, score: $0.score, color: $0.color, title: $0.title, memo: $0.memo, start: $0.start, end: $0.end,isComplete: $0.isComplete, uuid: $0.uuid)})
        return plan
    }
    func getPlan(_ day: String) -> [dbPlan]{
        let plan: [dbPlan] = realm.objects(dbPlan.self).filter("date == %@ ", day).map({dbPlan(date: $0.date, score: $0.score, color: $0.color, title: $0.title, memo: $0.memo, start: $0.start, end: $0.end,isComplete: $0.isComplete, uuid: $0.uuid)})
        return plan
    }
    
    
}
