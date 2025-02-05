//
//  ContactCellView.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 26.12.24.
//

import UIKit

final class ContactCellView: UIView {
    private let nameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    let labelStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(contact: Contact) {
        nameLabel.text = contact.name
        phoneNumberLabel.text = contact.phoneNumber
    }
    
    func setup() {
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        phoneNumberLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        labelStack.axis = .vertical
        labelStack.spacing = 1
        labelStack.distribution = .fillEqually
        
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(phoneNumberLabel)
        
        self.addSubview(labelStack)
    }
    
    func addConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelStack.topAnchor.constraint(equalTo: self.topAnchor),
            labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
