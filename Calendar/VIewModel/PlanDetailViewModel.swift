//
//  PlanDetailViewModel.swift
//  Calendar
//
//  Created by baegteun on 2021/08/08.
//

import UIKit
import RxSwift
import RxRealm
import RxCocoa
import RealmSwift

protocol detailViewDelegate:class {
    func updateDidFinish()
}
class PlanDetailViewModel {
    // MARK: - Properties
    weak var delegate: detailViewDelegate?
    let realm = try! Realm()
    let disposeBag = DisposeBag()
    
    func planDelete(_ controller: PlanDetailViewController){
        let plan = realm.object(ofType: PlanModel.self, forPrimaryKey: controller.plan.uuid)
        Observable.just(plan!)
            .subscribe(realm.rx.delete())
            .disposed(by: disposeBag)
        self.delegate?.updateDidFinish()
    }
    
    func reWritePlan(_ plan: PlanModel){
        PlanStorage.updateData(plan)
        self.delegate?.updateDidFinish()
    }
    
    
}
