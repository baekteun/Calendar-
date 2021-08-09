//
//  completeCheckbox.swift
//  Calendar
//
//  Created by baegteun on 2021/08/09.
//

import BEMCheckBox

class completeCheckbox: BEMCheckBox{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.boxType = .square
        self.tintColor = .lightGray
        self.onAnimationType = .stroke
        self.offAnimationType = .stroke
        self.onTintColor = .systemBlue
        self.onFillColor = .white
        self.onCheckColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
