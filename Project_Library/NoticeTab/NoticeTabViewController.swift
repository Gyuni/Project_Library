//
//  NoticeTabViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit
import SnapKit

class NoticeTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let noticeTableView: UITableView = UITableView()
    var notices: [Notice] = []
    let cellIdentifier: String = "noticeCell"
    var isLoadingComplete: Bool = true
    var isReachedFinalPage: Bool = false
    var page: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = "Notice Tab Title"
        self.view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNoticesNotification(_:)), name: DidReceiveNoticesNotification, object: nil)
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    @objc
    func didReceiveNoticesNotification(_ noti: Notification) {
        
        guard let response: NoticeAPIResponse = noti.userInfo?["notices"] as? NoticeAPIResponse else { return }
    
        self.notices += response.data.list
        
        if response.data.totalCount < response.data.offset + response.data.max {
            // 전체 갯수보다 지금까지 로딩된 갯수가 더 많다면
            self.isReachedFinalPage = true
        }
        
        DispatchQueue.main.async {
            self.noticeTableView.reloadData()
            self.isLoadingComplete = true
        }
    }
    
    private func setupView() {
        
        //MARK: 테이블 뷰
        let margins = view.layoutMarginsGuide
        
        noticeTableView.translatesAutoresizingMaskIntoConstraints = false
        noticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        noticeTableView.dataSource = self
        noticeTableView.delegate = self
        self.view.addSubview(noticeTableView)
        
        NSLayoutConstraint.activate([
            noticeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noticeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noticeTableView.topAnchor.constraint(equalTo: margins.topAnchor),
            noticeTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
        
        self.noticeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notice: Notice = self.notices[indexPath.row]
        
        let cell: UITableViewCell = noticeTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = notice.title
        cell.detailTextLabel?.text = notice.dateCreated
        cell.imageView?.image = nil
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(isReachedFinalPage) {
            // 마지막 페이지에 도달했다면 그냥 종료
            return
        }
        
        if self.noticeTableView.contentOffset.y > noticeTableView.contentSize.height - noticeTableView.bounds.size.height {
            // 바닥에 도착했고
            
            if (isLoadingComplete) {
                // 이전 단계 로딩이 다 끝났다면
                // 다음 단계 로딩 땡겨오기
                isLoadingComplete = false
                requestNoticeAPI(page: self.page)
                page += 1
            }
            
            noticeTableView.reloadData()
        }
    }
    
}
