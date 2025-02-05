//
//  ContactHeaderView.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 26.12.24.
//

import UIKit

class ContactHeaderView: UIView {
    private let headerLabel = UILabel()
    private let button = UIButton()
    private var model: ContactHeaderModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .lightGray.withAlphaComponent(0.3)
        headerLabel.font = UIFont.systemFont(ofSize: 18)
        headerLabel.alpha = 0.75
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        self.addSubview(headerLabel)
        self.addSubview(button)
    }
    
    @objc
    private func didTapButton() {
        model.onExpand()
    }
    
    func configure(with model: ContactHeaderModel) {
        
        self.model = model
        headerLabel.text = model.title
        let title = model.isExpanded ? "Collapse" : "Expand"
        button.setTitle(title, for: .normal)
    }
    
    private func addConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
