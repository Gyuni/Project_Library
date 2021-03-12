//
//  SearchListObjectModel.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/10.
//

/*
 {
 "success":true,
 "code":"success.retrieved",
 "message":"조회되었습니다.",
 "data":{
     "isFuzzy":false,
     "totalCount":320,
     "offset":0,
     "max":20,
     "abc":null,
     "list":[
         {
         "id":2425059,
         "biblioType":{
             "id":1,
             "name":"단행본(동양서)",
             "materialType":{
                "id":1
             },
             "biblioSchema":{
                 "id":1,
                 "name":"KORMARC",
                 "isMarc":true
            }
         },
         "thumbnailUrl":"/attachments/biblio/thumbnails/68ec9e00-193f-2be9-e054-002128e7f09a",
         "isbn":"9788998139940",
         "issn":null,
         "titleStatement":"(스프링 입문을 위한) 자바 객체 지향의 원리와 이해",
         "author":"김종민",
         "publication":"파주 :위키북스,2015",
         "etcContent":"{\"PAGE\":\"396 p.\",\"HEIGHT\":\"24 cm\",\"PERSONAL_NAME\":\"김종민\"}",
         "branchVolumes":[
             {
                 "id":1,
                 "name":"중앙도서관",
                 "isCr":false,
                 "volume":"005.133J2 김7563자",
                 "cState":"대출가능",
                 "isSubscribed":null,
                 "hasItem":true
             }
         ],
         "erSources":[
         ],
         "resources":null,
         "newResources":null,
         "similars":[
             {
                 "id":4467101,
                 "titleStatement":"(처음 배우는) 스프링 부트",
                 "publication":"서울 :한빛미디어,2018"
             },
             {
                 "id":2886618,
                 "titleStatement":"(처음 프로그래밍을 시작하는 입문자의 눈높이에 맞춘) 생활코딩! 자바 프로그래밍 입문",
                 "publication":"파주 :위키북스,2016"
             },
             {
                 "id":3125140,
                 "titleStatement":"자바만 잡아도 :기초를 탄탄히 세우는 Java 프로그래밍",
                 "publication":"파주 :카오스북,2017"
             }
         ]
         },
         {}
     ],
     "facets":[
         {
         "code":"BRANCH",
         "name":"분관",
         "size":1,
         "items":[
         {
         "label":"중앙도서관",
         "value":"1",
         "count":320
         }
         ]
         },
         {}
     ]
     }
 }
 */

import Foundation

struct SearchListResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: SearchDataResponse
}

struct SearchDataResponse: Codable {
    let isFuzzy: Bool
    let totalCount: Int
    let offset: Int
    let max: Int
    let abc: String?
    let list: [Book]
    let facets: [Facet]
}

struct Book: Codable {
    let id: Int
    let biblioType: BiblioType?
    let thumbnailUrl: String?
    let isbn: String?
    let issn: String?
    let titleStatement: String?
    let author: String?
    let publication: String?
    let etcContent: String?
    let branchVolumes: [BranchVolume]
    let erSources: [String?]
    let resources: String?
    let newResources: String?
    let similars: [Similar]
}

struct BiblioType: Codable {
    let id: Int?
    let name: String?
    let materialType: MaterialType?
    let biblioSchema: BiblioSchema?
}

struct MaterialType: Codable {
    let id: Int?
}

struct BiblioSchema: Codable {
    let id: Int?
    let name: String?
    let isMarc: Bool?
}

struct BranchVolume: Codable {
    let id: Int?
    let name: String?
    let isCr: Bool?
    let volume: String?
    let cState: String?
    let isSubscribed: Bool?
    let hasItem: Bool?
    var state: String {
        
        var state: String = ""
        
        if let cState = cState {
            state.append(cState + " · ")
        } else {
            state.append("- · ")
        }
        
        if let name = name {
            state.append(name + " · ")
        } else {
            state.append("- · ")
        }
        
        if let volume = volume {
            state.append(volume)
        } else {
            state.append("-")
        }
        
        return state
    }
}

struct Similar: Codable {
    let id: Int?
    let titleStatement: String?
    let publication: String?
}

struct Facet: Codable {
    let code: String?
    let name: String?
    let size: Int?
    let items: [Item]
}

struct Item: Codable {
    let label: String?
    let value: String?
    let count: Int?
}
