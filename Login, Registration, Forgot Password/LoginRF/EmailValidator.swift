//
//  EmailValidator.swift
//  LoginRF
//
//  Created by Mariam Tsikarishvili on 22.12.24.
//

import UIKit

class EmailValidator {
    
    static func isValidEmail(_ email: InputFieldView) -> Bool {
        return email.inputText.text!.contains("@")
    }
    
    static func checkEmailAddress(_ email: InputFieldView) {
        let isValid = isValidEmail(email)
        
        if !isValid {
            email.errorLabel.text = "Please provide a valid email address."
            email.errorOccured = true
        } else {
            email.errorOccured = false
        }
    }
}
