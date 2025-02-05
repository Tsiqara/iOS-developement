//
//  ContactHeaderModel.swift
//  MyContacts
//
//  Created by Mariam Tsikarishvili on 25.12.24.
//

final class ContactHeaderModel {
    var title: String
    var isExpanded: Bool = true
    var onExpand: () -> Void
    
    init(title: String, isExpanded: Bool = true,  onExpand: @escaping () -> Void) {
        self.title = title
        self.isExpanded = isExpanded
        self.onExpand = onExpand
    }
    
}
