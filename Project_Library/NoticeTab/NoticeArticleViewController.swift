//
//  NoticeArticleViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/07.
//

import UIKit
import WebKit
import SafariServices

class NoticeArticleViewController: UIViewController, WKNavigationDelegate {

    let contentWebView: WKWebView = WKWebView()
    let titleLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    let scrollView: UIScrollView = UIScrollView()
    
    var notice: Notice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentWebView.navigationDelegate = self
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
        
        //MARK: 전체 스크롤뷰
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        //MARK: 제목 라벨
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = notice?.title
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = .subtitle1
        titleLabel.textColor = .gray800
        self.scrollView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        //MARK: 게시글 정보 라벨
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = notice?.articleInfo
        dateLabel.numberOfLines = 0
        dateLabel.lineBreakMode = .byWordWrapping
        dateLabel.font = .caption
        dateLabel.textColor = .gray600
        self.scrollView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            dateLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: -32)
        ])
        
        //MARK: 디바이더
        let divider: UIView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.bounds.size.width - 40, height: 1))
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .gray300
        self.scrollView.addSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            divider.heightAnchor.constraint(equalToConstant: 0.5),
            divider.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])

        
        //MARK: 본문 웹 뷰
        contentWebView.translatesAutoresizingMaskIntoConstraints = false
        contentWebView.scrollView.isScrollEnabled = false
        self.scrollView.addSubview(contentWebView)
        
        NSLayoutConstraint.activate([
            contentWebView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentWebView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentWebView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 24),
        ])
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            NSLayoutConstraint.activate([
                self.contentWebView.heightAnchor.constraint(equalToConstant: self.contentWebView.scrollView.contentSize.height),
                self.contentWebView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            ])
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
      if navigationAction.navigationType == .linkActivated  {
        if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
      } else {
        decisionHandler(.allow)
      }
    }
    
    
    @objc
    func didReceiveNoticeArticleNotification(_ noti: Notification) {
        
        guard let response: String = noti.userInfo?["noticeArticle"] as? String else { return }
        
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head><style>img{max-width:100%;height:auto !important;width:auto !important;} iframe, table{width:100% !important; height:auto !important;} body{margin:0px 16px 0px 16px; color: #505050; font-family: '-apple-system' !important; font-size: 14px; max-width: 100% !important} a{color:#00B4CF;}</style>"
        
        DispatchQueue.main.async {
            self.contentWebView.loadHTMLString(headerString + response, baseURL: nil)
            print(response)
        }
 
    }
}
