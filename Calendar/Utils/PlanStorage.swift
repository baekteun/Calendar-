//
//  PlanStorage.swift
//  Calendar
//
//  Created by baegteun on 2021/08/06.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift
class PlanStorage {
    static let realm = try! Realm()
    static let disposeBag = DisposeBag()
    static func createData(_ plan: PlanModel){
        Observable.just(plan)
            .subscribe(realm.rx.add())
            .disposed(by: disposeBag)
    }
    static func deleteData(_ plan: PlanModel){
        let del = realm.object(ofType: PlanModel.self, forPrimaryKey: plan.uuid)!
        Observable.just(del)
            .subscribe(realm.rx.delete())
            .disposed(by: disposeBag)
    }
    static func updateData(_ plan: PlanModel){
        guard let dats = realm.object(ofType: PlanModel.self, forPrimaryKey: plan.uuid) else { return }
        
        try! realm.write({
            dats.color = plan.color
            dats.isComplete = plan.isComplete
            dats.end = plan.end
            dats.title = plan.title
            dats.memo = plan.memo
        })
    }
    static func getPlan(_ day: String) -> [PlanModel]{
        let plan: [PlanModel] = realm.objects(PlanModel.self).filter("date == %@ ", day).map({PlanModel(date: $0.date, color:$0.color, title: $0.title, memo: $0.memo, end: $0.end, isComplete: $0.isComplete, uuid: $0.uuid)})
        return plan
    }
    static func getPlan(_ day: String,_ isCompleted: Bool) -> [PlanModel]{
        let plan: [PlanModel] = realm.objects(PlanModel.self).filter("date == %@ AND isComplete == %@", day, isCompleted).map({PlanModel(date: $0.date,color: $0.color, title: $0.title, memo: $0.memo, end: $0.end, isComplete: $0.isComplete, uuid: $0.uuid)})
        return plan
    }
    
    
}
