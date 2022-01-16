//
//  TrendingViewModelProtocol.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

protocol TrendingViewModelProtocol {
    var screenTitle: String { get }
    var state: Box<VcState> { get }
    var numberOfRows: Int { get }
    func fetchRepos()
    func refreshRepos()
    func repo(at index: IndexPath) -> TrendingRepoItem?
    func handleRepoSelection(at indexPath: IndexPath)
}
