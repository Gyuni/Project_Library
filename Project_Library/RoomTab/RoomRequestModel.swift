//
//  RoomRequestModel.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import Foundation

let DidReceiveRoomsNotification: Notification.Name = Notification.Name("DidReceiveRooms")

func requestRoomAPI() {
    
    guard let url: URL = URL(string: getRoomURL()) else {
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
            let apiResponse: RoomAPIResponse = try JSONDecoder().decode(RoomAPIResponse.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveRoomsNotification, object: nil, userInfo: ["rooms":apiResponse])
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    
    dataTask.resume()
}
