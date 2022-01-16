//
//  ErrorStateView.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import UIKit

protocol ErrorStateViewDelegate: AnyObject {
    func handleErrorCtaClick()
}

class ErrorStateView: UIView {
    
    @IBOutlet var contentView: ErrorStateView!
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var cta: UIButton!
    
    weak var delegate: ErrorStateViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle(for: Self.self).loadNibNamed("ErrorStateView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.fillSuperview()
        self.cta.layer.borderWidth = 1
        self.cta.layer.borderColor = UIColor.systemGreen.cgColor
        self.cta.layer.cornerRadius = 4
        self.cta.clipsToBounds = true
    }
    
    public func updateUIElement(titleColor: UIColor = .black, message: String, messageColor: UIColor = .gray) {
        self.errorTitleLabel.textColor = titleColor
        self.errorMessage.text = message
        self.errorMessage.textColor = messageColor
    }
    
    
    @IBAction func handleCtaClick(_ sender: UIButton) {
        self.delegate?.handleErrorCtaClick()
    }
}
