//
//  ContactCell.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 25.12.24.
//

import UIKit

class ContactCell: UITableViewCell {
    private let contactView = ContactCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setup()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(contact: Contact) {
        contactView.configure(contact:  contact)
    }
    
    private func setup() {
        contactView.setup()
        
        self.addSubview(contactView)
    }
    
    private func addConstraints() {
        contactView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contactView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contactView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            contactView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}
