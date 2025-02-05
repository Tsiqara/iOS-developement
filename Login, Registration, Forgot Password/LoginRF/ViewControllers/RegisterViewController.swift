//
//  RegisterViewController.swift
//  LoginRF
//
//  Created by Mariam Tsikarishvili on 22.12.24.
//

import UIKit

class RegisterViewController: UIViewController {
    let name = InputFieldView()
    let email = InputFieldView()
    let password = InputFieldView()
    let confirmPassword = InputFieldView()
    let signUpButton = UIButton()
    let spaceView = UIView()
    let stack = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        addConstraints()
        
        title = "Register"
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        setupName()
        
        setupEmail()
        email.inputText.tag = 1
        email.inputText.delegate = self
        
        setupPassword()
        
        setupConfirmPassword()
        confirmPassword.inputText.tag = 2
        confirmPassword.inputText.delegate = self
        
        setupSignUpButton()
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        stack.axis = .vertical
        stack.spacing = 4
        
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(email)
        stack.addArrangedSubview(password)
        stack.addArrangedSubview(confirmPassword)
        stack.addArrangedSubview(spaceView)
        stack.addArrangedSubview(signUpButton)
        
        view.addSubview(stack)
    }
    
    @objc
    private func signUpTapped() {
        if(allInputsValid()) {
            let successVC = SuccessViewController()
            successVC.titleText = "Registration Success!"
            successVC.descriptionText = "Now you can use your email and password to Sign In"
            successVC.navigationTitle = "Register"
            navigationController?.pushViewController(successVC, animated: true)
        }else{
            EmailValidator.checkEmailAddress(email)
            PasswordValidator.checkPasswordMatch(password: password, confirmPassword: confirmPassword)
        }
    }
    
    private func addConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 121),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            spaceView.heightAnchor.constraint(equalToConstant: 16),
            
            signUpButton.heightAnchor.constraint(equalTo: email.textView.heightAnchor),
        ])
    }
    
    private func allInputsValid() -> Bool{
        return !name.inputText.text!.isEmpty
            && EmailValidator.isValidEmail(email)
            && !password.inputText.text!.isEmpty
            && PasswordValidator.passwordsMatch(password: password, confirmPassword: confirmPassword)
    }
}

extension RegisterViewController {
    private func setupName() {
        name.title.text = "Your name"
        name.inputText.placeholder = "Input your first name"
        name.inputCanBePrivate = false
    }
    
    private func setupEmail() {
        email.title.text = "Email Address"
        email.inputText.placeholder = "Input email address"
        email.inputCanBePrivate = false
    }
    
    private func setupPassword() {
        password.title.text = "Password"
        password.inputText.placeholder = "Input your password"
        password.inputCanBePrivate = true
        password.inputIsPrivate = true
    }
    
    private func setupConfirmPassword() {
        confirmPassword.title.text = "Confirm Password"
        confirmPassword.inputText.placeholder = "Input confirm password"
        confirmPassword.inputCanBePrivate = true
        confirmPassword.inputIsPrivate = true
    }
    
    private func setupSignUpButton() {
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.backgroundColor = .blue
        signUpButton.layer.cornerRadius = 8
    }
}

extension RegisterViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            // Email
            email.isGettingInput = true
        case 2:
            //Confirm Password
            confirmPassword.isGettingInput = true
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            // Email
            EmailValidator.checkEmailAddress(email)
            
            email.isGettingInput = false
        case 2:
            //Confirm Password
            PasswordValidator.checkPasswordMatch(password: password, confirmPassword: confirmPassword)
            confirmPassword.isGettingInput = false
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            // Email
            EmailValidator.checkEmailAddress(email)
            
            email.isGettingInput = false
        case 2:
            //Confirm Password
            PasswordValidator.checkPasswordMatch(password: password, confirmPassword: confirmPassword)
            
            confirmPassword.isGettingInput = false
        default:
            break
        }
        
        return true
    }
}
