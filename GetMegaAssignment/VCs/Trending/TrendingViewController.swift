//
//  TrendingViewController.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import UIKit

class TrendingViewController: UIViewController {
    
    private let viewModel: TrendingViewModel
    
    @IBOutlet private(set) weak var tableView: UITableView!
    private var loadingStateView: LoadingStateView?
    private var errorStateView: ErrorStateView?
    
    init(viewModel: TrendingViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: String(describing: TrendingViewController.self),
            bundle: .main)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.fetchRepos()
    }
    
    private func fetchRepos() {
        self.viewModel.state.bind { [weak self] state in
            self?.handleStateChange(state: state)
        }
        self.viewModel.fetchTrendingRepo()
    }

}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repo = self.viewModel.repo(at: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrandingRepoCell.self), for: indexPath) as? TrandingRepoCell else {
            return tableView.dequeueReusableCell(
                withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        }
        cell.configureRepoData(repo: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.handleRepoSelection(at: indexPath)
    }
    
}

extension TrendingViewController {
    
    private func handleStateChange(state: VcState) {
        self.errorStateView?.removeFromSuperview()
        self.loadingStateView?.removeFromSuperview()
        self.tableView.isHidden = true
        
        switch state {
        case .loading:
            let loading = LoadingStateView()
            loading.backgroundColor = .clear
            self.view.addSubview(loading)
            loading.fillSuperview()
            self.loadingStateView = loading
        case .empty:
            break
        case .pullToRefresh:
            break
        case .data:
            self.tableView.isHidden = false
            self.tableView.reloadData()
        case .error(let message):
            let error = ErrorStateView()
            error.updateUIElement(message: message)
            error.backgroundColor = .clear
            self.view.addSubview(error)
            error.fillSuperview()
            self.errorStateView = error
        case .reloadRow(let indexPaths):
            self.tableView.isHidden = false
            self.tableView.reloadRows(at: indexPaths, with: .fade)
        }
    }
}

extension TrendingViewController {
    
    private func setupViews() {
        self.setupTableView()
        self.title = self.viewModel.screenTitle
    }
    
    private func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            TrandingRepoCell.xib,
            forCellReuseIdentifier: TrandingRepoCell.resusableIdentifier)
        self.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
}
