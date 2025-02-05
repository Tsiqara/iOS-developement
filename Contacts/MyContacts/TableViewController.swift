//
//  TableViewController.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 25.12.24.
//

import UIKit

final class TableViewController: UIViewController {
    private let tableView = UITableView()
    private var addAction: UIAlertAction?
    
    lazy var addContactButton: UIBarButtonItem = {
        let item = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(handleAdd)
        )
        return item
    }()
    
    lazy var contactGridButton: UIBarButtonItem = {
        let item = UIBarButtonItem(
            image: UIImage(systemName: "square.grid.3x3.fill"),
            style: .plain,
            target: self,
            action: #selector(handleDisplayAsGrid)
        )
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        view.addSubview(tableView)
        
        addConstraints()
        navigationItem.leftBarButtonItem = addContactButton
        navigationItem.rightBarButtonItem = contactGridButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        DataManager.shared.handleExpand = { [weak self] title in
            self?.handleExpand(for: title)
        }
    }
    
    private func configureTableView() {
        tableView.sectionHeaderTopPadding = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.register(ContactHeader.self, forHeaderFooterViewReuseIdentifier: "ContactHeader")
    }
    
    @objc
    private func handleDisplayAsGrid(){
        let collectionVC = CollectionViewController()
        collectionVC.title = "Contacts"
        navigationController?.pushViewController(collectionVC, animated: false)
    }

}

extension TableViewController {
    
    @objc
    private func handleAdd() {
       let alert = UIAlertController(
            title: "Add Contact",
            message: nil,
            preferredStyle: .alert
        )
        var nameField: UITextField?
        var numberField: UITextField?
        
        alert.addTextField { textField in
            nameField = textField
            textField.placeholder = "Name"
        }
        
        alert.addTextField { [unowned self] textField in
            numberField = textField
            textField.placeholder = "Phone Number"
            textField.addTarget(
                self,
                action: #selector(handleContactEnter),
                for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel
        ))
        addAction = UIAlertAction(
            title: "Add",
            style: .default,
            handler: { [unowned self] _ in
                if let name = nameField?.text,
                    let number = numberField?.text {
                    addContact(name: name, phoneNumber: number)
                }
            }
        )
        addAction?.isEnabled = false
        alert.addAction(addAction!)
        present(alert, animated: true)
    }
    
    @objc
    private func handleContactEnter(_ sender: UITextField){
        let isEnabled = sender.text?.isEmpty == false
        addAction?.isEnabled = isEnabled
    }
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.shared.data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return DataManager.shared.data[section].contactCount
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactHeader")
        if let contactHeader = header as? ContactHeader,
           let model = DataManager.shared.headerModel(for: section)
        {
            contactHeader.configure(with: model)
        }
        return header
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        if let contactCell = cell as? ContactCell {
            let contact = DataManager.shared.contact(at: indexPath)
            contactCell.configure(contact: contact)
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 40
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 70
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive,
            title: "Delete",
            handler: { [unowned self] _, _, _ in
                deleteContact(at: indexPath)
            }
        )
        let actions: [UIContextualAction] = [
            delete
        ]
        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}

extension TableViewController {
    
    private func handleExpand(for title: String){
        let sectionIndex = DataManager.shared.getSectionIndex(title: title)
        if let sectionIndex {
            DataManager.shared.data[sectionIndex].isExpanded.toggle()
            let indexSet = IndexSet(integer: sectionIndex)
            tableView.reloadSections(indexSet, with: .automatic)
        }
    }
    
    private func addContact(name: String, phoneNumber: String) {
        guard let title = name.first?.uppercased() else { return }
        let contact = Contact(name: name, phoneNumber: phoneNumber)
        let sectionIndex = DataManager.shared.getSectionIndex(title: title)
        if let sectionIndex {
            addNewContact(contact: contact, at: sectionIndex)
        } else {
            addNewSection(title: title, contact: contact)
        }
    }
    
    private func addNewContact(contact: Contact, at sectionIndex: Int) {
        if let newIndex = DataManager.shared.addNewContact(contact: contact, at: sectionIndex){
            let newRow = IndexPath(row: newIndex, section: sectionIndex)
            tableView.insertRows(at: [newRow], with: .automatic)
        }
    }
    
    private func addNewSection(title: String, contact: Contact) {
        if let newIndex = DataManager.shared.addNewSection(title: title, contact: contact) {
            let newSection = IndexSet(integer: newIndex)
            tableView.insertSections(newSection, with: .automatic)
        }
    }
    
    private func deleteContact(at indexPath: IndexPath) {
        if DataManager.shared.deleteContact(at: indexPath) == 1{
            let section = IndexSet(integer: indexPath.section)
            tableView.deleteSections(section, with: .automatic)
        } else {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TableViewController {
    
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

