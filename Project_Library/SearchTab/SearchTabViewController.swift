//
//  SearchTabViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit
import SnapKit

class SearchTabViewController: UIViewController {

    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSearchListNotification(_:)), name: DidReceiveSearchListNotification, object: nil)
        
        requestSearchList(keyword: "영어", page: 0)
        
        setupView()
    }

    private func setupView() {
        self.navigationController?.navigationBar.topItem?.title = "도서검색"
        self.view.backgroundColor = .white000
    }
    
    @objc
    func didReceiveSearchListNotification(_ noti: Notification) {
        
        guard let response: SearchListResponse = noti.userInfo?["searchList"] as? SearchListResponse else { return }
    
        print(response)

    }
    
}
