//
//  SearchTabViewController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import UIKit

class SearchTabViewController: UIViewController {

    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
                
        self.navigationController?.navigationBar.topItem?.title = "도서검색"
        self.navigationController?.navigationBar.tintColor = .secondary_blue
        self.view.backgroundColor = .white000
        
        let searchResultViewController = SearchResultViewController()
        
        let searchController = UISearchController(searchResultsController: searchResultViewController)
        searchController.searchBar.delegate = searchResultViewController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "도서 제목을 입력해주세요."
        
        self.navigationItem.searchController = searchController
    }
    
}
