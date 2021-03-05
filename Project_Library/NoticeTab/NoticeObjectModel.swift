//
//  NoticeObjectModel.swift
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
             "totalCount":1364,
             "offset":0,
             "max":20,
             "list":[
                 {
                 "id":10303,
                 "seqNo":1374,
                 "bulletinCategory":null,
                 "bulletinTextHead":null,
                 "bulletinState":null,
                 "isPrivate":false,
                 "title":"[신청] 3월 중앙도서관 학술DB 이용교육 안내",
                 "writer":"최은진",
                 "dateCreated":"2021-03-02 14:58:56",
                 "hitCnt":227,
                 "replyCnt":0,
                 "commentCnt":0,
                 "attachmentCnt":0,
                 "attachments":[
                     {
                     "id":333551,
                     "logicalName":"숭실대_2020우수사례집.pdf",
                     "fileType":"application/pdf",
                     "fileSize":12536799,
                     "originalImageUrl":"/attachments/BULLETIN/ca3f8721-56d5-492d-b781-971705c4453b"
                     }
                 ],
                 "lastUpdated":"2021-03-03 10:06:43",
                 "isPersonal":false,
                 "likeCount":0,
                 "isMyLike":false
                 },
                 {}
                 ]
         }
 }
 */

import Foundation

struct NoticeAPIResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: NoticeDataResponse
}

struct NoticeDataResponse: Codable {
    let totalCount: Int
    let offset: Int
    let max: Int
    let list: [Notice]
}

struct Notice: Codable {
    let id: Int
    let seqNo: Int
    let bulletinCategory: String?
    let bulletinTextHead: String?
    let bulletinState: String?
    let isPrivate: Bool
    let title: String
    let writer: String
    let dateCreated: String
    let hitCnt: Int
    let replyCnt: Int
    let commentCnt: Int
    let attachmentCnt: Int
    let attachments: [Attachment]
    let lastUpdated: String
    let isPersonal: Bool
    let likeCount: Int
    let isMyLike: Bool
}

struct Attachment: Codable {
    let id: Int
    let logicalName: String
    let fileType: String
    let fileSize: Int
    let originalImageUrl: String
}
