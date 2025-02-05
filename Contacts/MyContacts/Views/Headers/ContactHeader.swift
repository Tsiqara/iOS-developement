//
//  ContactHeader.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 25.12.24.
//

import UIKit

final class ContactHeader: UITableViewHeaderFooterView {
    private let contactHeaderView = ContactHeaderView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contactHeaderView.setup()
        self.addSubview(contactHeaderView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ContactHeaderModel) {
        contactHeaderView.configure(with: model)
    }
    
    private func addConstraints() {
        contactHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contactHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contactHeaderView.topAnchor.constraint(equalTo: self.topAnchor),
            contactHeaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
