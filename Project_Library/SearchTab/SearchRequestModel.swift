//
//  SearchRequestModel.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/10.
//

import Foundation

enum SearchRequestType {
    // list : 키워드로 검색하는 도서 리스트
    // book : 도서id로 검색하는 도서 개별 정보 (언젠가 추가 예정)
    case list
    case book
}

let DidReceiveSearchListNotification: Notification.Name = Notification.Name("DidReceiveSearchList")

func requestSearchList(keyword: String, page: Int) {
    
    guard let url: URL = URL(string: getSearchURL(keyword: keyword, page: page)) else {
        print("requestSearchList")
        return
    }
    
    request(type: .list, url: url)
}

private func request(type: SearchRequestType, url: URL) {
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) {
        (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            switch type {
            case .list:
                let apiResponse: SearchListResponse = try JSONDecoder().decode(SearchListResponse.self, from: data)
                
                NotificationCenter.default.post(name: DidReceiveSearchListNotification, object: nil, userInfo: ["searchList":apiResponse])
 
            case .book:
                // 언젠가...
                return
            }
            
        } catch(let err) {
            print(err.localizedDescription)
            SearchResultViewController.isLoadingComplete = true
        }
    }
    
    dataTask.resume()
    
}

