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
    case empty
    case data
    case pullToRefresh
    case reloadRow(indexPath: [IndexPath])
}

class TrendingViewModel {
    
    let screenTitle: String
    private let service: Service
    let state: Box<VcState>
    private var reposItems: [TrendingRepoItem] = []
    
    init(screenTitle: String, service: Service) {
        self.screenTitle = screenTitle
        self.service = service
        self.state = .init(.loading)
    }
    
    func fetchTrendingRepo() {
        self.state.value = .loading
        let endPoint = Endpoint(path: "/search/repositories", queryItems: [
            .init(name: "q", value: "flutter"),
            .init(name: "per_page", value: "50"),
            .init(name: "page", value: "1"),
            .init(name: "order", value: "desc"),
            .init(name: "since", value: "daily")
        ])
        service.fetch(endpoint: endPoint,
                      type: TrendingRepoModel.self) { result in
            switch result {
            case .success(let resp):
                self.reposItems = resp.items ?? []
                self.state.value = self.reposItems.isEmpty ?
                    .empty : .data
            case .failure(let error):
                self.state.value = .error(message: error.localizedDescription)
            }
        }
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

extension TrendingViewModel: ErrorStateViewDelegate {
    
    func handleErrorCtaClick() {
        self.fetchTrendingRepo()
    }
    
}
