//
//  DateViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class DateViewController: BaseViewController {
    
    private let mainView = DateView()
    var completionHandler: ((Date) -> Void)?
    
    // Protocol 값 전달 2.
    var delegate: PassDateDelegate?
    
    override func loadView() {
        view = mainView
    }
    
    deinit {
        print("deinit", self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Protocol 값 전달 3.
        delegate?.receiveDate(date: mainView.datePicker.date)
        completionHandler?(mainView.datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
