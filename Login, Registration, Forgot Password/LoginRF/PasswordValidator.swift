//
//  PasswordValidator.swift
//  LoginRF
//
//  Created by Mariam Tsikarishvili on 22.12.24.
//

import UIKit

class PasswordValidator {
    
    static func passwordsMatch(password: InputFieldView, confirmPassword: InputFieldView) -> Bool {
        return password.inputText.text == confirmPassword.inputText.text
    }
    
    static func checkPasswordMatch(password: InputFieldView, confirmPassword: InputFieldView) {
        let match = passwordsMatch(password: password, confirmPassword: confirmPassword)
        
        if !match {
            confirmPassword.errorLabel.text = "The passwords you entered do not match."
            confirmPassword.errorOccured = true
        } else {
            confirmPassword.errorOccured = false
           
        }
    }
}
