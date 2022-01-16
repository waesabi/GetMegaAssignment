//
//  TrandingRepoCell.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import UIKit

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
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
