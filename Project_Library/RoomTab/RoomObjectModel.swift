//
//  RoomObjectModel.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

/*
 {
     "success":true,
     "code":"success.retrieved",
     "message":"조회되었습니다.",
     "data":{
         "totalCount":5,
         "list":[
             {
             "id":12,
             "name":"제1열람실",
             "branchGroup":{
                 "id":1,
                 "name":"숭실대학교"
             },
             "isActive":true,
             "isReservable":false,
             "note":"-",
             "roomTypeId":2,
             "total":408,
             "activeTotal":0,
             "occupied":0,
             "available":0,
             "disablePeriod":null
             },
             {},
             {},
             {},
             {}
         ]
     }
 }
 */

import Foundation

struct RoomAPIResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: RoomDataResponse
}

struct RoomDataResponse: Codable {
    let totalCount: Int
    let list: [Room]
}

struct Room: Codable {
    let id: Int
    let name: String
    let branchGroup: BranchGroup
    let isActive: Bool
    let isReservable: Bool
    let note: String
    let roomTypeId: Int
    let total: Int
    let activeTotal: Int
    let occupied: Int
    let available: Int
    let disablePeriod: String?
}

struct BranchGroup: Codable {
    let id: Int
    let name: String
}


