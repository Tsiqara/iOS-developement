//
//  ContactSection.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 25.12.24.
//

final class ContactSection {
    var header: ContactHeaderModel?
    var contacts: [Contact]
    
    var title: String {header?.title ?? ""}
    
    var isExpanded: Bool {
        get {header?.isExpanded ?? true}
        set {header?.isExpanded = newValue}
    }
    
    var contactCount: Int { isExpanded ? contacts.count : 0 }
    
    init(header: ContactHeaderModel?, contacts: [Contact]) {
        self.header = header
        self.contacts = contacts
    }
}
