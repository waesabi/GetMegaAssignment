//
//  TrendingRepoLoader.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

protocol TrendingRepoLoaderProtocol: AnyObject {
    var service: Service { get }
    func fetchTrendingRepos(
        endpoint: Endpoint,
        completion: @escaping (Result<TrendingRepoModel, APIError>) -> Void)
}

class TrendingRepoLoader: TrendingRepoLoaderProtocol {
    
    let service: Service
    private let trendingRepoCache: Cache<String, TrendingRepoModel>
    
    init(service: Service, cache: Cache<String, TrendingRepoModel>) {
        self.service = service
        self.trendingRepoCache = cache
    }
    
    func fetchTrendingRepos(
        endpoint: Endpoint, completion:
        @escaping (Result<TrendingRepoModel, APIError>) -> Void) {
            guard let url = endpoint.url else {
                completion(.failure(.invalidURL))
                return
            }
            if !NetworkMonitor.shared.isReachable {
                if let value = trendingRepoCache.value(forKey: endpoint.url?.absoluteString ?? "") {
                    completion(.success(value))
                    return
                } else {
                    completion(.failure(.custom(message: "Please check your network connection")))
                    return
                }
            }
            service.fetch(endpoint: endpoint, type: TrendingRepoModel.self) { [weak self] result in
                switch result {
                case .success(let resp):
                    self?.trendingRepoCache[url.absoluteString] = resp
                    completion(.success(resp))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
