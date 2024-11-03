//
//  ActionLabelView.swift
//  SpotifyClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 3.11.2024.
//

import UIKit




struct ActionLabelViewModel {
    let text: String
    let actionTitle: String
}

protocol ActionLabelViewDelegate: AnyObject {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView)
}

class ActionLabelView: UIView {

    weak var delegate: ActionLabelViewDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        isHidden = true
        addSubview(label)
        addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapButton() {
        delegate?.actionLabelViewDidTapButton(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.frame = CGRect(x: 0, y: height-40, width: width, height: 40)
        label.frame = CGRect(x: 0 , y: 0, width: width, height: height-45)
    }
    
    func configure(with viewModel: ActionLabelViewModel) {
        label.text = viewModel.text
        actionButton.setTitle(viewModel.actionTitle, for: .normal)
    }
}
