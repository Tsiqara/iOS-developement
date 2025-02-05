//
//  ContactCollectionViewCell.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 26.12.24.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    
    private let contactView = ContactCellView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        addConstraints()
    }
    
    func configure(contact: Contact) {
        contactView.configure(contact:  contact)
    }
    
    private func setup() {
        contactView.setup()
        contactView.labelStack.alignment = .center
        
        self.addSubview(contactView)
    }
    
    private func addConstraints() {
        contactView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contactView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
