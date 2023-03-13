//
//  HomeViewModel.swift
//
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published var viewEntity: HomeViewModel.HomeViewModelViewEntity?
    @Published var moviesEntity: [SearchModelEntity] = []
    @Published var girdData: [GirdEntity] = []
    @Published var isShowLoading: Bool = true
    var searchInput: String = "Marvel" {
        didSet {
            if searchInput != oldValue {
                girdData = []
                moviesEntity = []
                page = 1
                doSearchMovie()
            }
        }
    }

    private let perpage: Int = 10
    private var toalResult: Int = 0
    private var isLoadMore: Bool = false
    private var page: Int = 1
    private var searchMovieServices = SearchMovieServices()
    private var disposables = Set<AnyCancellable>()

}

// MARK: - View Entity
extension HomeViewModel {
    struct HomeViewModelViewEntity {
    }
}

// MARK: - Services
extension HomeViewModel {
    func doSearchMovie() {
        disposables.forEach {
            $0.cancel()
        }
        isShowLoading = true
        if isLoadMore {
            page += 1
        }
        let searchParam = SearchParam(s: searchInput, page: page)
        searchMovieServices.doLogin(param: searchParam)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] error in
                self?.isShowLoading = false
                switch error {
                case .finished:
                    break
                case .failure:
                    break
                }
            }, receiveValue: { [weak self] responeAPI in
                guard let self = self else {
                    return
                }
                self.moviesEntity = self.moviesEntity + ConvertEntity().map(apiEntity: responeAPI)
                self.convertToGirdData()
                self.toalResult = Int(responeAPI.totalResults ?? "") ?? 0
                print("ThaoLQ \(self.moviesEntity.count) \(self.toalResult)")
            })
            .store(in: &disposables)
    }

    func pullToRefresh() {
        page = 1
        isLoadMore = false
        girdData = []
        moviesEntity = []
        doSearchMovie()
    }

    func loadMore() {
        if page*perpage < (toalResult) {
            isLoadMore = true
            doSearchMovie()
        } else {
            isLoadMore = false
        }
    }

    func convertToGirdData() {
        var index: Int = 0
        var tempGirdData: [GirdEntity] = []
        while (index < moviesEntity.count) {
            if index == moviesEntity.count - 1 {
                let tempData = GirdEntity(data: [moviesEntity[index]])
                tempGirdData.append(tempData)
                break
            } else {
                let tempData = GirdEntity(data: [moviesEntity[index], moviesEntity[index + 1]])
                tempGirdData.append(tempData)
                index = index + 2
            }
        }
        girdData = tempGirdData
    }
}
