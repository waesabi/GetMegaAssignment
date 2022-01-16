//
//  LoadingStateView.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import UIKit

class LoadingStateView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messagelabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {        
        Bundle(for: Self.self).loadNibNamed("LoadingStateView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.fillSuperview()
    }
    
    public func updateUIElement(loadingIndicatorColor: UIColor = .gray, message: String, messageColor: UIColor = .gray) {
        self.loadingIndicator.color = loadingIndicatorColor
        self.messagelabel.text = message
        self.messagelabel.textColor = messageColor
    }

}
