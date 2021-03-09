//
//  NoticeRequestModel.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import Foundation

enum RequestType: String {
    case list = "list"
    case article = "article"
}

let DidReceiveNoticeListNotification: Notification.Name = Notification.Name("DidReceiveNoticeList")
let DidReceiveNoticeArticleNotification: Notification.Name = Notification.Name("DidReceiveNoticeArticle")

func requestNoticeList(page: Int) {
    
    guard let url: URL = URL(string: getNoticeURL(page: page)) else {
        return
    }
    
    request(type: .list, url: url)
}

func requestNoticeArticle(id: Int) {
    
    guard let url: URL = URL(string: getNoticeArticleURL(id: id)) else {
        return
    }
    
    request(type: .article, url: url)
}

private func request(type: RequestType, url: URL) {
    
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
                let apiResponse: NoticeListResponse = try JSONDecoder().decode(NoticeListResponse.self, from: data)
                
                NotificationCenter.default.post(name: DidReceiveNoticeListNotification, object: nil, userInfo: ["noticeList":apiResponse])
 
                
            case .article:
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let data = json["data"] as? [String: Any], let content = data["content"] {
                        NotificationCenter.default.post(name: DidReceiveNoticeArticleNotification, object: nil, userInfo: ["noticeArticle":content])
                    }
                }
                
            }
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    
    dataTask.resume()
}
