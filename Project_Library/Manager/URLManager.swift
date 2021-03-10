//
//  URLManager.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/05.
//

import Foundation

let rootURL: String = "https://oasis.ssu.ac.kr"

func getRoomURL() -> String {
    // https://oasis.ssu.ac.kr/smufu-api/pc/1/rooms-at-seat
    
    return rootURL + "/smufu-api/pc/1/rooms-at-seat"
}

func getNoticeURL(page: Int) -> String {
    // https://oasis.ssu.ac.kr/pyxis-api/1/bulletin-boards/1/bulletins?offset=(페이지*맥스)&max=(한 페이지에 몇 개)
    
    let max: Int = 20
    let offset: Int = page*max
    
    return rootURL + "/pyxis-api/1/bulletin-boards/1/bulletins?offset=" + String(offset) + "&max=" + String(max)
}

func getNoticeArticleURL(id: Int) -> String {
    // https://oasis.ssu.ac.kr/pyxis-api/1/bulletins/1/10303
    
    return rootURL + "/pyxis-api/1/bulletins/1/" + String(id)
}

func getNoticeAttachmentURL(url: String) -> String {
    // https://oasis.ssu.ac.kr/pyxis-api/attachments/BULLETIN/ca3f8721-56d5-492d-b781-971705c4453b
    
    return rootURL + "/pyxis-api" + url
}

func getSearchURL(keyword: String, page: Int) -> String {
    // https://oasis.ssu.ac.kr/pyxis-api/1/collections/(type)/search?all=k|a|(검색어)&max=(max)&offset=(offset)
    
    let type: Int = 2
    let max: Int = 20
    let offset: Int = page*max

    let url: String = rootURL + "/pyxis-api/1/collections/" + String(type) + "/search?all=k|a|" + keyword + "&max=" + String(max) + "&offset=" + String(offset)
    
    let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    if let unwrappedUrl = encodedUrl {
        return unwrappedUrl
    } else {
        print("url encoding error")
        return "error"
    }
}

func getBookThumbnailURL(url: String) -> String {
    // https://oasis.ssu.ac.kr/pyxis-api/attachments/biblio/thumbnails/69ec9e00-cc4a-2be9-e054-002128e7f09a
    
    return rootURL + "/pyxis-api" + url
}
