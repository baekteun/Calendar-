//
//  dbContribution.swift
//  Calendar
//
//  Created by baegteun on 2021/08/02.
//

import Foundation
import RealmSwift

// MARK: - DBModel

class PlanModel: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var score: Int = 1
    @objc dynamic var color: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var memo: String = ""
    @objc dynamic var start: String = ""
    @objc dynamic var end: String = ""
    @objc dynamic var isComplete: Bool = false
    @objc dynamic var uuid: String = ""
    
    convenience init(date: String, score:Int=1, color:String="systemPurple", title: String = "내 일정", memo:String="", start:String,end:String,isComplete: Bool,uuid: String){
        self.init()
        self.date = date
        self.score = score
        self.color = color
        self.title = title
        self.memo = memo
        self.start = start
        self.end = end
        self.isComplete = isComplete
        self.uuid = uuid
    }
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
    
}
