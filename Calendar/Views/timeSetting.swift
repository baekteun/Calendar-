//
//  timeLabel.swift
//  Calendar
//
//  Created by baegteun on 2021/08/09.
//

import UIKit
import Then
import RxSwift
import RxCocoa


class timeSetting: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray.withAlphaComponent(0.4)
        self.font = UIFont.systemFont(ofSize: 14)
        self.clipsToBounds = true
        self.layer.cornerRadius = 6
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
