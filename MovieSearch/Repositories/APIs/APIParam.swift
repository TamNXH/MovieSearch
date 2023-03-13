//
//  APIParam.swift
//
//

import Foundation

struct SearchParam: Codable {
    let apikey: String?
    let s: String
    let type: String?
    let page: Int

    init(s: String, page: Int) {
        self.apikey = "b9bd48a6"
        self.s = s
        self.type = "movie"
        self.page = page
    }
}

struct EmptyParam: Codable {

}
