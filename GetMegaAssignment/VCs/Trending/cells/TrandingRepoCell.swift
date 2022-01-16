//
//  TrandingRepoCell.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import UIKit
import SDWebImage

class TrandingRepoCell: UITableViewCell {
    
    static let resusableIdentifier = String(
        describing: TrandingRepoCell.self)
    static let xib = UINib(
        nibName: String(describing: TrandingRepoCell.self),
        bundle: .main)
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomInfoStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var starLabel: UILabel!
    
    @IBOutlet weak var forkStackView: UIStackView!
    @IBOutlet weak var forkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.logoImageView.layer.cornerRadius = 22        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureRepoData(repo: TrendingRepoItem) {
        self.loginNameLabel.text = repo.owner?.login
        self.nameLabel.text = repo.fullName
        self.descriptionLabel.text = repo.description
        
        self.logoImageView.sd_setImage(with: .init(string: repo.owner?.avatarURL ?? ""), completed: nil)
        
        self.languageLabel.text = repo.language
        self.languageStackView.isHiddenInStackView = repo.language == nil
        
        let starCount = repo.watchers ?? 0
        self.starLabel.text = "\(starCount)"
        self.starStackView.isHiddenInStackView = repo.watchers == nil
        
        let forkCount = repo.forksCount ?? 0
        self.forkLabel.text = "\(forkCount)"
        self.forkStackView.isHiddenInStackView = repo.forksCount == nil
        
        let isExpanded = repo.isExpanded ?? false
        self.bottomInfoStackView.isHiddenInStackView = !isExpanded
    }
    
}
