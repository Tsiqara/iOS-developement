//
//  ContactCollectionViewHeader.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 26.12.24.
//

import UIKit

class ContactCollectionViewHeader: UICollectionReusableView {

    private let contactHeaderView = ContactHeaderView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contactHeaderView.setup()
        self.addSubview(contactHeaderView)
        addConstraints()
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
