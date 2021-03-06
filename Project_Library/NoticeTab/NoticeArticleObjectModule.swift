//
//  NoticeArticleObjectModule.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/07.
//

/*
 {
 "success":true,
 "code":"success.retrieved",
 "message":"조회되었습니다.",
 "data":{
     "id":10303,
     "seqNo":1374,
     "bulletinCategory":null,
     "bulletinTextHead":null,
     "bulletinState":null,
     "isPrivate":false,
     "myParent":null,
     "title":"[신청] 3월 중앙도서관 학술DB 이용교육 안내",
     "content":"(대충 내용)",
     "isMine":false,
     "worker":{
     "name":"최은진"
     },
     "patron":null,
     "hitCnt":276,
     "dateCreated":"2021-03-02 14:58:56",
     "lastUpdated":"2021-03-03 10:06:43",
     "comments":[
     ],
     "attachments":[
     ],
     "isUseLike":false,
     "likeCount":0,
     "isMyLike":false,
     "replies":[
     ]
     }
 }
 */

import Foundation

// 어차피 data -> content만 필요해서 애는 codable로 파싱 안하기로 했다
