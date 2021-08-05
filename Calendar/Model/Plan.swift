//
//  Contribution.swift
//  Calendar
//
//  Created by baegteun on 2021/08/02.
//

import Foundation

// MARK: - PlanModel
class Plan {
    var date: String
    var score: Int
    var color: String
    var title: String
    var memo: String
    var start: String
    var end: String
    var uuid: String
    
    init(date: String, score:Int=1, color:String="systemPurple", title: String = "내 일정", memo:String="", start:String,end:String,uuid: String){
        self.date = date
        self.score = score
        self.color = color
        self.title = title
        self.memo = memo
        self.start = start
        self.end = end
        self.uuid = uuid
    }
}
