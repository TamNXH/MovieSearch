//
//  ConvertAPIEntityToModelEntity.swift
//
//

import Foundation

struct ConvertEntity {
    func map(apiEntity: SearchAPIEntity) -> [SearchModelEntity] {
        return apiEntity.search?.compactMap { value in
            SearchModelEntity(
                title: value.title ?? "",
                year: value.year ?? "",
                imdbID: value.imdbID ?? "",
                type: value.type ?? "",
                poster: value.poster ?? ""
            )
        } ?? []
    }
}
