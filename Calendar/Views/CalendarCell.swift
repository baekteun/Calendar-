//
//  CalendarCell.swift
//  Calendar
//
//  Created by baegteun on 2021/08/04.
//

import Foundation
import FSCalendar
import RxSwift
import RxCocoa
class CalendarCell: FSCalendarCell {
    
    let viewModel = CalendarCellViewModel()
    let tableview = UITableView()
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
