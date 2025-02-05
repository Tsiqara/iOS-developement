//
//  LoginView.swift
//  LoginRF
//
//  Created by Mariam Tsikarishvili on 21.12.24.
//

import UIKit

class LoginViewController : UIViewController {
    let email = InputFieldView()
    let password = InputFieldView()
    let loginButton = UIButton()
    let forgotButton = UIButton()
    let signUpButton = UIButton()
    let dontHaveLabel = UILabel()
    let signUpView = UIStackView()
    let stack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addConstraints()
        
        title = "Login"
        view.backgroundColor = .systemBackground
    }
    
    private func setup(){
        setupEmail()
        setupPassword()
        setupLoginButton()
        setupForgotButton()
        setupSignUp()
        
        email.inputText.delegate = self
        
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        
        stack.addArrangedSubview(email)
        stack.addArrangedSubview(password)
        stack.addArrangedSubview(loginButton)
        
        view.addSubview(stack)
        view.addSubview(forgotButton)
        
        signUpView.axis = .horizontal
        signUpView.addArrangedSubview(dontHaveLabel)
        signUpView.addArrangedSubview(signUpButton)
        view.addSubview(signUpView)
    }
    
    @objc
    private func signUpTapped(){
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc
    private func forgotPasswordTapped(){
        let forgotVC = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    private func addConstraints() {
        email.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        dontHaveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 121),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            loginButton.heightAnchor.constraint(equalTo: email.textView.heightAnchor),
            forgotButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            forgotButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 24),
            
            signUpView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            signUpView.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
        ])
    }
    
}

extension LoginViewController {
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
    
    private func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 8
    }
    
    private func setupForgotButton() {
        forgotButton.setTitle("Forgot Password?", for: .normal)
        forgotButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        forgotButton.setTitleColor(.blue, for: .normal)
        forgotButton.titleLabel?.textAlignment = .center
    }
    
    private func setupSignUp() {
        dontHaveLabel.text = "You don’t have an account? "
        dontHaveLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dontHaveLabel.textColor = .black
        
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signUpButton.setTitleColor(.blue, for: .normal)
    }
}


extension LoginViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        email.isGettingInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        EmailValidator.checkEmailAddress(email)
        
        email.isGettingInput = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        EmailValidator.checkEmailAddress(email)
        
        email.isGettingInput = false
        
        return true
    }
}
