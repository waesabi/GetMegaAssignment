//
//  TrandingViewModel.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

enum VcState {
    case loading
    case error(message: String)
    case empty(message: String)
    case data
    case pullToRefresh
    case reloadRow(indexPath: [IndexPath])
}

class TrendingViewModel: TrendingViewModelProtocol {
    
    let screenTitle: String
    private let repoLoader: TrendingRepoLoaderProtocol
    let state: Box<VcState>
    private var reposItems: [TrendingRepoItem] = []
    
    init(screenTitle: String, repoLoader: TrendingRepoLoaderProtocol) {
        self.screenTitle = screenTitle
        self.repoLoader = repoLoader
        self.state = .init(.loading)
    }
    
    func fetchRepos() {
        self.state.value = .loading
        self.fetchTrendingRepos()
    }
    
    func refreshRepos() {        
        self.fetchTrendingRepos()
    }
    
    func handleRepoSelection(at indexPath: IndexPath) {
        guard var repo = self.reposItems[safe: indexPath.row] else {
            return
        }
        if let isExpanded = repo.isExpanded {
            repo.isExpanded = !isExpanded
        } else{
            repo.isExpanded = true
        }
        self.reposItems[indexPath.row] = repo
        self.state.value = .reloadRow(indexPath: [indexPath])
    }
    
}

extension TrendingViewModel {
    
    var numberOfRows: Int {
        self.reposItems.count
    }
    
    func repo(at index: IndexPath) -> TrendingRepoItem? {
        self.reposItems[safe: index.row]
    }
}

extension TrendingViewModel {
    
    private func fetchTrendingRepos() {
        let query = "react"
        let endPoint = Endpoint(path: "/search/repositories", queryItems: [
            .init(name: "q", value: query),
            .init(name: "per_page", value: "50"),
            .init(name: "page", value: "1"),
            .init(name: "order", value: "desc"),
            .init(name: "since", value: "daily")
        ])
        repoLoader.fetchTrendingRepos(endpoint: endPoint) { result in
            switch result {
            case .success(let resp):
                self.reposItems = resp.items ?? []
                if self.reposItems.isEmpty {
                    let emptyMessage = "Couldn't find any repo related to \(query)"
                    self.state.value = .error(message: emptyMessage)
                } else {
                    self.state.value = .data
                }
                
            case .failure(let error):
                self.state.value = .error(message: error.localizedDescription)
            }
        }
    }
    
}
