//
//  TrendingViewController.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import UIKit

class TrendingViewController: UIViewController {
    
    private let viewModel: TrendingViewModel
    
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
        self.view.backgroundColor = .white
        self.title = "Trending"
    }
}
