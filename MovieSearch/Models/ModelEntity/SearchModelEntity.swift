//
//  SearchModelEntity.swift
//
//

import Foundation

struct SearchModelEntity: Identifiable {
    var id = UUID()
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
}

struct GirdEntity: Identifiable {
    var id = UUID()
    let data: [SearchModelEntity]
}
