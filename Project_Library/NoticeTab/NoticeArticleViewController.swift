//
//  NoticeArticleViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/07.
//

import UIKit
import WebKit

class NoticeArticleViewController: UIViewController {

    let contentWebView: WKWebView = WKWebView()
    
    var notice: Notice?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNoticeArticleNotification(_:)), name: DidReceiveNoticeArticleNotification, object: nil)
        
        guard let notice: Notice = notice else {
            return
        }
        requestNoticeArticle(id: notice.id)
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white000
        let margins = view.layoutMarginsGuide
        navigationItem.largeTitleDisplayMode = .never
        
        //MARK: 본문 웹 뷰
        contentWebView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentWebView)
        
        NSLayoutConstraint.activate([
            contentWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentWebView.topAnchor.constraint(equalTo: margins.topAnchor),
            contentWebView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    @objc
    func didReceiveNoticeArticleNotification(_ noti: Notification) {
        
        guard let response: String = noti.userInfo?["noticeArticle"] as? String else { return }
        
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head><style>img{max-width:100%;height:auto !important;width:auto !important;} iframe{width:100%;height:auto !important;}</style>"
        
        DispatchQueue.main.async {
            self.contentWebView.loadHTMLString(headerString + response, baseURL: nil)
            print(response)
        }
 
    }
}
