//
//  HomeView.swift
//
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private(set) var viewModel = HomeViewModel()
    
    init() {
        viewModel.doSearchMovie()
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchInput)
            if viewModel.moviesEntity.isEmpty {
                emptyView()
            } else {
                listMovie()
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func emptyView() -> some View {
        Spacer()
        Text("Empty!")
        Spacer()
    }
    private func listMovie() -> some View {
        let movieItem = viewModel.moviesEntity
        return ZStack {
            GeometryReader { geo in
                List(viewModel.girdData) { item in
                    LazyHStack(spacing: 10) {
                        ForEach(item.data) { movie in
                            MovieItem(
                                width: (geo.size.width / 2 - 10),
                                imageURL: movie.poster,
                                title: movie.title,
                                year: movie.year
                            ) {
                                if movie.id == movieItem.last?.id {
                                    viewModel.loadMore()
                                }
                            }
                        }
                    }
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding([.horizontal, .bottom], 10)
                }
                .listStyle(.plain)
                .refreshable {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.viewModel.pullToRefresh()
                    }
                }
            }
            if viewModel.isShowLoading {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}

struct HomePreviews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
