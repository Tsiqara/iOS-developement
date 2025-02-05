//
//  CollectionViewController.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 26.12.24.
//

import UIKit

final class CollectionViewController: UIViewController {
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
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
    
    lazy var contactListButton: UIBarButtonItem = {
        let item = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(handleDisplayAsList)
        )
        return item
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        view.addSubview(collectionView)
        
        addConstraints()
        navigationItem.leftBarButtonItem = addContactButton
        navigationItem.rightBarButtonItem = contactListButton
        
        DataManager.shared.handleExpand = { [weak self] title in
            self?.handleExpand(for: title)
        }
        
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(
            UINib(nibName: "ContactCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "ContactCollectionViewCell"
        )
        
        collectionView.register(
            UINib(nibName: "ContactCollectionViewHeader", bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ContactCollectionViewHeader"
        )
        
        collectionView.addGestureRecognizer(
            UILongPressGestureRecognizer(
                target: self,
                action: #selector(handleLongPress)
            )
        )
    }
    

    @objc
    private func handleDisplayAsList(){
        navigationController?.popViewController(animated: false)
    }
}


extension CollectionViewController {
    
    @objc
    private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: location) {
            deleteItem(at: indexPath)
        }
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "Delete?",
            message: "Are you sure you want to delete \(DataManager.shared.contact(at: indexPath).name) from your contacts?",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { [unowned self] _ in
                    if DataManager.shared.deleteContact(at: indexPath) == 1{
                        let section = IndexSet(integer: indexPath.section)
                        collectionView.deleteSections(section)
                    } else {
                        collectionView.deleteItems(at: [indexPath])
                    }
                }
            )
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DataManager.shared.data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return DataManager.shared.data[section].contactCount
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ContactCollectionViewCell",
            for: indexPath
        )
        if let contactCell = cell as? ContactCollectionViewCell {
            let contact = DataManager.shared.contact(at: indexPath)
            contactCell.configure(contact: contact)
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "ContactCollectionViewHeader",
            for: indexPath
        )
        
        if let contactHeader = header as? ContactCollectionViewHeader,
           let model = DataManager.shared.headerModel(for: indexPath.section){
            contactHeader.configure(with: model)
        }
        return header
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.cornerRadius = 8
    }
    
}

extension CollectionViewController {
    private func handleExpand(for title: String){
        let sectionIndex = DataManager.shared.getSectionIndex(title: title)
        if let sectionIndex {
            DataManager.shared.data[sectionIndex].isExpanded.toggle()
            let indexSet = IndexSet(integer: sectionIndex)
            collectionView.reloadSections(indexSet)
        }
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing_sum = (2 * spacing) + spacing * (CGFloat)(itemsInRow - 1)
        let spareWidth = collectionView.frame.width - spacing_sum
        let itemSize = spareWidth / CGFloat(itemsInRow)
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: 0, height: 40)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if DataManager.shared.data[section].isExpanded {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
}

extension CollectionViewController {
    
    private var spacing: CGFloat { 20 }
    private var itemsInRow: Int { 3 }
    
}


extension CollectionViewController {
    
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


extension CollectionViewController {
    
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
        let newIndex = DataManager.shared.addNewContact(contact: contact, at: sectionIndex)
        if let newIndex {
            let newRow = IndexPath(row: newIndex, section: sectionIndex)
            collectionView.insertItems(at: [newRow])
        }
    }
    
    private func addNewSection(title: String, contact: Contact) {
        let newIndex = DataManager.shared.addNewSection(title: title, contact: contact)
        if let newIndex {
            let newSection = IndexSet(integer: newIndex)
            collectionView.insertSections(newSection)
        }
    }
}

extension CollectionViewController {
    
    private func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}
