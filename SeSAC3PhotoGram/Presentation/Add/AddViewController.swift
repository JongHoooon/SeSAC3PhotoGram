//
//  AddViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

import SeSACFramework

// Protocol 값 전달 1.
protocol PassDateDelegate {
    func receiveDate(date: Date)
}

protocol PassImageNameDelegate {
    func receiveNmae(name: String)
}

final class AddViewController: BaseViewController {

    private let mainView = AddView()
    
    // MARK: - Lifecycle
    override func loadView() { // viewDidLoad보다 먼저 호출된다. 🚨 super 메서드 호출 하면안됨!!
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClassOpenExample.pulbicExample()
        ClassPublicExample.pulbicExample()
        
//        ClassPublicExample.internalExample()
//        ClassInternalExample
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver),
            name: .selectIamge,
            object: nil
        )
    }
    
    // 중복 노티 방지 체크
    // remove observer
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
//        sesacShowActivityViewController(
//            image: UIImage(systemName: "star")!,
//            url: "hi",
//            text: "good"
//        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: .selectIamge,
            object: nil
        )
        print(#function)
    }
    
    override func configureView() {
        super.configureView()
        print(#fileID, #function)
        
        mainView.searchButton.addTarget(
            self,
            action: #selector(searchButtonClicked),
            for: .touchUpInside
        )
        mainView.searchProtocolButton.addTarget(
            self,
            action: #selector(searchProtocolButtonClicked),
            for: .touchUpInside
        )
        mainView.dateButton.addTarget(
            self,
            action: #selector(dateButtonClicked),
            for: .touchUpInside
        )
        mainView.titleButton.addTarget(
            self,
            action: #selector(titleButtonClicked),
            for: .touchUpInside
        )
        mainView.closureButton.addTarget(
            self,
            action: #selector(closureButtonClicked),
            for: .touchUpInside
        )
        mainView.contentButton.addTarget(
            self,
            action: #selector(contentButtonClicked),
            for: .touchUpInside
        )
    }
}

extension AddViewController: UIImagePickerControllerDelegate,
                             UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainView.photoImageView.image = image
            dismiss(animated: true)
        }
    }
}

#warning("extension에서 override 불가능한 이유??")

// MARK: - Private
private extension AddViewController {
    
    @objc
    func selectImageNotificationObserver(notification: NSNotification) {
        print("select Image Notification Observer")
        print(#function)
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc
    func searchButtonClicked() {
        
//        let word = ["Apple", "Banna", "Cookie", "Cake", "Sky"]
//
//        NotificationCenter.default.post(
//            name: NSNotification.Name("RecommandKeyword"),
//            object: nil,
//            userInfo: [
//                "word": word.randomElement()!
//            ]
//        )
//        navigationController?.pushViewController(SearchViewController(), animated: true)
            
        let alertController = UIAlertController(
            title: "",
            message: "이미지를 어디서 가져올까요??",
            preferredStyle: .actionSheet
        )
        
        let gallery = UIAlertAction(
            title: "갤러리에서 가져오기",
            style: .default,
            handler: { [weak self] _ in
                let picker = UIImagePickerController()
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        )
        let webSearch = UIAlertAction(
            title: "웹에서 검색하기",
            style: .default,
            handler:  { [weak self] _ in
                self?.present(SearchViewController(), animated: true)
            }
        )
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [
            gallery,
            webSearch,
            cancel
        ].forEach { alertController.addAction($0) }
        
        present(alertController, animated: true)
    }
    
    @objc
    func searchProtocolButtonClicked() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc
    func dateButtonClicked() {
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func titleButtonClicked() {
        let vc = TitleViewController()
        // Closure - 3
        vc.completionHandler = { [weak self] title, age, push in
            self?.mainView.titleButton.setTitle(title, for: .normal)
            print("Completion Handler", age, push)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func closureButtonClicked() {
        let vc = DateViewController()
        vc.completionHandler = { [weak self] date in
            let dateString = DateFormatter.convertDate(date: date)
            self?.mainView.closureButton.setTitle(dateString, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func contentButtonClicked() {
        let vc = ContentViewController()
        vc.completionHandler = { [weak self] text in
            self?.mainView.contentButton.setTitle(text, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// protocol 값전달 4.
extension AddViewController: PassDateDelegate {
    func receiveDate(date: Date) {
        let date = DateFormatter.convertDate(date: date)
        mainView.dateButton.setTitle("\(date)", for: .normal)
    }
}

extension AddViewController: PassImageNameDelegate {
    func receiveNmae(name: String) {
        mainView.photoImageView.image = UIImage(systemName: name)
    }
}

#warning("closure, delegate 순환참조 확인")
