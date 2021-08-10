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
import BEMCheckBox
import RealmSwift

private let tableReuse = "table"
private let reuseIdentifier = "calendarCell"


class CalendarViewController: UIViewController{
    
    // MARK: - Properties
    
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
            $0.height.equalTo(view.frame.height/3)
        }
        tableview.register(PlanCell.self, forCellReuseIdentifier: tableReuse)
        tableview.rowHeight = 70
        calendar.allowsMultipleSelection = false
        calendar.appearance.titleWeekendColor = .red
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        addBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .bind{
                
                self.viewModel.showMakePlan(self)
            }
            .disposed(by: disposeBag)
        
    }
    
    
    
    func calReload(){
        DispatchQueue.main.async {
            self.calendar.reloadData()
            self.calendar.configureAppearance()
        }
        
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
        return min(PlanStorage.getPlan(formmatter.string(from: date)).count,6)
    }

    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: reuseIdentifier, for: date, at: position)
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
        let plan = [PlanStorage.getPlan(selectedDay,false),
                    PlanStorage.getPlan(selectedDay, true)]
        return plan[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableview.cellForRow(at: indexPath) as? PlanCell
        DispatchQueue.main.async {
            self.viewModel.showDetailViewController(cell!, self)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let plans = [PlanStorage.getPlan(formmatter.string(from: calendar.selectedDate!),false),
                    PlanStorage.getPlan(formmatter.string(from: calendar.selectedDate!), true) ]
        
        let cell = tableview.dequeueReusableCell(withIdentifier: tableReuse, for: indexPath) as! PlanCell
        cell.plan = plans[indexPath.section][indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
}


// MARK: - Complete
extension CalendarViewController: CompleteDelegate{
    func didComplete() {
        tableview.reloadData()
    }
}

extension CalendarViewController: createDelegate{
    func createDidFinish() {
        calReload()
        tableview.reloadData()
    }
}


extension CalendarViewController: detailViewDelegate {
    func updateDidFinish() {
        calReload()
        navigationController?.popViewController(animated: true)
        tableview.reloadData()
    }
}
