//
//  DataManager.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 26.12.24.
//

import Foundation


final class DataManager {
    static let shared = DataManager()
    var data : [ContactSection] = []
    var handleExpand: ((String) -> Void)?
    
    private init() {
        data = [
            ContactSection(
                header: ContactHeaderModel(
                    title: "A",
                    onExpand: { [unowned self] in
                        handleExpand?("A")
                    }
                ),
                contacts: [
                    Contact(name: "Ana", phoneNumber: "599112233"),
                    Contact(name: "Anita", phoneNumber: "599111222")
                ]
            ),
            ContactSection(
                header: ContactHeaderModel(
                    title: "K",
                    onExpand: { [unowned self] in
                        handleExpand?("K")
                    }
                ),
                contacts: [
                    Contact(name: "Kote", phoneNumber: "595111333"),
                ]
            ),
            ContactSection(
                header: ContactHeaderModel(
                    title: "M",
                    onExpand: { [unowned self] in
                        handleExpand?("M")
                    }
                ),
                contacts: [
                    Contact(name: "Mariami", phoneNumber: "555444333"),
                    Contact(name: "Marita", phoneNumber: "555445533"),
                ]
            ),
        ]
        data.sort { $0.title < $1.title }
    }
    
    
    func addNewContact(contact: Contact, at sectionIndex: Int) -> Int?{
        data[sectionIndex].contacts.append(contact)
        data[sectionIndex].contacts.sort { $0.name < $1.name}
        let newIndex = data[sectionIndex].contacts.firstIndex { $0.name == contact.name }
        return newIndex
    }
    
    func addNewSection(title: String, contact: Contact) -> Int? {
        let section = ContactSection(
            header: ContactHeaderModel(
                title: title,
                onExpand: { [unowned self] in
                    handleExpand?(title)
                }
            ),
            contacts: [contact]
        )
        data.append(section)
        data.sort { $0.title < $1.title }
        
        let newIndex = data.firstIndex { $0.title == title }
        return newIndex
    }
    
    func deleteContact(at indexPath: IndexPath) -> Int {
        let count = data[indexPath.section].contacts.count
        if count == 1 {
            data.remove(at: indexPath.section)
        } else {
            data[indexPath.section].contacts.remove(at: indexPath.row)
        }
        return count
    }
    
    func getSectionIndex(title: String) -> Int? {
        return data.firstIndex(where: {$0.title == title})
    }
    
    
    func headerModel(for section: Int) -> ContactHeaderModel? {
        return data[section].header
    }
    
    func contact(at indexPath: IndexPath) -> Contact {
        return data[indexPath.section].contacts[indexPath.row]
    }
    
}
