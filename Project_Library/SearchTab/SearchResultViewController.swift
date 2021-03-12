//
//  SearchResultViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/11.
//

import UIKit

class SearchResultViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let searchTableView: UITableView = UITableView()
    var books: [Book] = []
    let cellIdentifier: String = "searchCell"
    static var isLoadingComplete: Bool = true
    // 이걸 static으로 한 이유는
    // 검색결과가 어떤식으로 리턴되는지 문서가 없어서 제대로 파싱을 할 수 없었고
    // 그로 인해 불러오지 못하는 페이지가 생기는데
    // 이런 상황일 때 SearchRequestModel에서 이 값에 접근하여
    // 해당 페이지의 로딩이 (실패한 상태로)끝났으니 다음 페이지를 로딩하라고
    // 알려주기 위함임
    var isReachedFinalPage: Bool = false
    var page: Int = 0
    var keyword: String = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSearchListNotification(_:)), name: DidReceiveSearchListNotification, object: nil)
        
        setupView()
    }
    
    @objc
    func didReceiveSearchListNotification(_ noti: Notification) {
        guard let response: SearchListResponse = noti.userInfo?["searchList"] as? SearchListResponse else { return }
        
        self.books += response.data.list

        if response.data.totalCount < response.data.offset + response.data.max {
            self.isReachedFinalPage = true
        }
        
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
            SearchResultViewController.isLoadingComplete = true
            print("search list page \(self.page - 1) loaded")
        }

    }

    private func setupView() {
        self.view.backgroundColor = .white000
                
        //MARK: 테이블 뷰
        searchTableView.frame = view.bounds
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.register(SearchListTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        searchTableView.separatorColor = .gray300
        searchTableView.tableFooterView = UIView()

        self.view.addSubview(searchTableView)
        
        self.searchTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputKeyword: String = searchBar.text else {
            return
        }
        
        self.books = []
        self.keyword = inputKeyword
        self.page = 0
        searchTableView.reloadData()
        requestSearchList(keyword: keyword, page: page)
        page += 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book: Book = self.books[indexPath.row]
        
        let cell: SearchListTableViewCell = searchTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! SearchListTableViewCell
        
        cell.thumbnailImage.image = nil
        cell.titleLabel.text = book.titleStatement
        cell.authorLabel.text = book.author
        cell.publicationLabel.text = book.publication
        cell.parentVC = self
        cell.book = book
        
        DispatchQueue.global().async {
            guard let thumbnailUrl: String = book.thumbnailUrl,
                    let imageURL: URL = URL(string: getBookThumbnailURL(url: thumbnailUrl)) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.thumbnailImage.image = UIImage(data: imageData)
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(isReachedFinalPage) {
            // 마지막 페이지에 도달했다면 그냥 종료
            return
        }
        
        if self.searchTableView.contentOffset.y > searchTableView.contentSize.height - searchTableView.bounds.size.height - 100 {
            // 바닥으로부터 100만큼 위인 지점에 도착했고
            
            if (SearchResultViewController.isLoadingComplete) {
                // 이전 단계 로딩이 다 끝났다면
                // 다음 단계 로딩 땡겨오기
                SearchResultViewController.isLoadingComplete = false
                requestSearchList(keyword: keyword, page: page)
                page += 1
            }
            

        }
    }

}
