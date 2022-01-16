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
    }

}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath)
        return cell
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
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
}
