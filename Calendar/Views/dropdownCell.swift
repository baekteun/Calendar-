//
//  dropdownCell.swift
//  Calendar
//
//  Created by baegteun on 2021/08/07.
//

import UIKit

class dropdownCell: UITableViewCell {
    var color: UIColor?
    let label = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        label.snp.makeConstraints {
            $0.top.bottom.left.height.equalTo(self)
            $0.height.width.equalTo(30)
        }
        label.layer.cornerRadius = 15
        label.backgroundColor = color
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
