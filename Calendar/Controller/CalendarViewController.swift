//
//  Calendar.swift
//  Calendar
//
//  Created by baegteun on 2021/08/02.
//

import UIKit
import FSCalendar
import SnapKit
import Then
import RxSwift
import RxCocoa
import RealmSwift
private let tableReuse = "table"
private let reuseIdentifier = "calendarCell"

class CalendarViewController: UIViewController {
    // MARK: - Properties
    let realm = try! Realm()
    let calendar = FSCalendar()
    let viewModel = CalendarCellViewModel()
    let tableview = UITableView()
    
    lazy var selectedDay: String = formmatter.string(from: Date())
    let disposeBag = DisposeBag()
    private let sections = ["일정","완료"]
    let formmatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
    }
    let addBtn = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        $0.titleLabel?.tintColor = .black
        $0.backgroundColor = .blue
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindView()
        tableview.delegate = self
        tableview.dataSource = self
        calendar.delegate = self
        calendar.dataSource = self
//        let pl = dbPlan(date: "2021-08-05", score: 2, color: "systemGreen", title: "내 일정", memo: "메모", start: "2021-08-05-13-50", end: "2021-08-06-16-25",isComplete: false, uuid: "\(UUID.init())")
//        viewModel.createData(pl)
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(calendar)
        view.addSubview(tableview)
        calendar.snp.makeConstraints { c in
            c.top.left.right.equalToSuperview()
            c.bottom.equalTo(self.tableview.snp.top).offset(10)
        }
        tableview.snp.makeConstraints {
            $0.bottom.left.right.equalTo(self.view)
            $0.height.equalTo(280)
        }
        tableview.register(PlanCell.self, forCellReuseIdentifier: tableReuse)
        calendar.allowsMultipleSelection = false
        calendar.appearance.titleWeekendColor = .red
        calendar.register(CalendarCell.self, forCellReuseIdentifier: reuseIdentifier)
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleOffset = CGPoint(x: 0, y: 10)
        calendar.locale = Locale(identifier: "Ko_kr")
        calendar.appearance.todayColor = .lightGray
        calendar.scrollDirection = .horizontal
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.select(Date())
        
        
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { b in
            b.width.height.equalTo(70)
            b.bottom.equalTo(self.calendar).offset(30)
            b.right.equalTo(self.view).offset(-30)
        }
        addBtn.layer.cornerRadius = 35
        
    }
    
    func bindView(){
        
        
        
    }
    
    func refresh(){
        calendar.reloadData()
        calendar.configureAppearance()
    }
}

// MARK: - Calendar Extension

extension CalendarViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDay = formmatter.string(from: date)
        if monthPosition == .previous || monthPosition == .next{
            calendar.setCurrentPage(date, animated: true)
        }
        tableview.reloadData()
       
        
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return min(viewModel.getPlan(formmatter.string(from: date)).count,9)
    }

    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: reuseIdentifier, for: date, at: position) as! CalendarCell
        
        return cell
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)

        }
        self.view.layoutIfNeeded()
    }


}

// MARK: - TableView Extension

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return"\( sections[section])"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let plan = [viewModel.getPlan(formmatter.string(from: calendar.selectedDate!),false),
                    viewModel.getPlan(formmatter.string(from: calendar.selectedDate!), true) ]
        return plan[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: tableReuse, for: indexPath) as! PlanCell
        cell.selectedDay = formmatter.string(from: calendar.selectedDate!)
        cell.indexPath = indexPath
        
        
        return cell
    }
    
    
}


extension CalendarViewController: isCompleteDelegate {
    func didTapCompletebtn() {
        tableview.reloadData()
    }
}
