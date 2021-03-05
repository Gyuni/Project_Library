//
//  NoticeRequestModel.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import Foundation

let DidReceiveNoticesNotification: Notification.Name = Notification.Name("DidReceiveNotices")

func requestNoticeAPI(page: Int) {
    
    print(page)
    
    guard let url: URL = URL(string: getNoticeURL(page: page)) else {
        return
    }
    
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
            let apiResponse: NoticeAPIResponse = try JSONDecoder().decode(NoticeAPIResponse.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveNoticesNotification, object: nil, userInfo: ["notices":apiResponse])
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    
    dataTask.resume()
}
