//
//  SuccessViewController.swift
//  LoginRF
//
//  Created by Mariam Tsikarishvili on 22.12.24.
//

import UIKit

class SuccessViewController: UIViewController {
    var navigationTitle = "Success"
    let approvedImage = UIImageView()
    var titleText: String = "Success Title"
    let titleLabel = UILabel()
    var descriptionText: String = "Success Description"
    let descriptionLabel = UILabel()
    
    lazy var popToRootButton: UIBarButtonItem = {
        let item = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(handlePopToRoot)
        )
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        addConstraints()
        
        title = navigationTitle
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = popToRootButton
    }
    
    private func setup() {
        approvedImage.image = UIImage(named: "approved")
        
        titleLabel.text = titleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        descriptionLabel.text = descriptionText
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor(red: 143/255, green: 143/255, blue: 143/255, alpha: 1)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        
        view.addSubview(approvedImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    @objc
    private func handlePopToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func addConstraints() {
        approvedImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            approvedImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 225),
            approvedImage.widthAnchor.constraint(equalToConstant: 64),
            approvedImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            approvedImage.heightAnchor.constraint(equalTo: approvedImage.widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: approvedImage.bottomAnchor, constant: 36),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
        ])
    }
}
