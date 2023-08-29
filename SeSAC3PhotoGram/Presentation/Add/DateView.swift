//
//  DateView.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class DateView: BaseView {
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    override func configureView() {
        addSubview(datePicker)
    }
    
    override func setConstraints() {
        datePicker.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
