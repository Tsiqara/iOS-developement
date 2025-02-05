//
//  ForgotPasswordViewController.swift
//  LoginRF
//
//  Created by Mariam Tsikarishvili on 21.12.24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    let forgotPasswordView = UIView()
    let forgotPasswordImage = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let labelStack = UIStackView()
    let email = InputFieldView()
    let sendButton = UIButton()
    let inputStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        addConstraints()
        
        title = "Forgot Password"
        view.backgroundColor = .systemBackground
    }
    
    private func setup() {
        forgotPasswordImage.image = UIImage(named: "forgot password")
        
        setupTitleLabel()
        setupDescriptionLabel()
        
        labelStack.axis = .vertical
        labelStack.spacing = 12
        
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(descriptionLabel)
        
        forgotPasswordView.addSubview(forgotPasswordImage)
        forgotPasswordView.addSubview(labelStack)
        
        view.addSubview(forgotPasswordView)

        setupEmail()
        setupSendButton()
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        inputStack.axis = .vertical
        inputStack.spacing = 8
        
        inputStack.addArrangedSubview(email)
        inputStack.addArrangedSubview(sendButton)
        
        view.addSubview(inputStack)
    }
    
    @objc
    private func sendButtonTapped() {
        if(EmailValidator.isValidEmail(email)) {
            let successVC = SuccessViewController()
            successVC.titleText = "We have sent a password recover intructions to your email"
            successVC.descriptionText = "Did not recive the email? check you spam filter or resend"
            successVC.navigationTitle = "Forgot Password"
            navigationController?.pushViewController(successVC, animated: true)
        }else{
            EmailValidator.checkEmailAddress(email)
        }
    }
    
    private func addConstraints() {
        forgotPasswordView.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordImage.widthAnchor.constraint(equalToConstant: 64),
            forgotPasswordImage.heightAnchor.constraint(equalTo: forgotPasswordImage.widthAnchor),
            forgotPasswordImage.centerXAnchor.constraint(equalTo: forgotPasswordView.centerXAnchor),
            forgotPasswordImage.topAnchor.constraint(equalTo: forgotPasswordView.topAnchor),
            labelStack.topAnchor.constraint(equalTo: forgotPasswordImage.bottomAnchor, constant: 36),
            labelStack.widthAnchor.constraint(equalTo: forgotPasswordView.widthAnchor),
            forgotPasswordView.topAnchor.constraint(equalTo: view.topAnchor, constant: 121),
            forgotPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forgotPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forgotPasswordView.bottomAnchor.constraint(equalTo: labelStack.bottomAnchor),
            
            sendButton.heightAnchor.constraint(equalTo: email.textView.heightAnchor),
            inputStack.topAnchor.constraint(equalTo: forgotPasswordView.bottomAnchor, constant: 36),
            inputStack.leadingAnchor.constraint(equalTo: forgotPasswordView.leadingAnchor),
            inputStack.trailingAnchor.constraint(equalTo: forgotPasswordView.trailingAnchor),
        ])
    }
    
    private func setupEmail() {
        email.title.text = "Email Address"
        email.inputText.placeholder = "Input email address"
        email.inputCanBePrivate = false
        
        email.inputText.delegate = self
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Forgot your password?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.text = "Enter your registered email below to receive password reset instruction"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor(red: 143/255, green: 143/255, blue: 143/255, alpha: 1)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupSendButton() {
        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = .blue
        sendButton.layer.cornerRadius = 8
    }

}

extension ForgotPasswordViewController: UITextFieldDelegate{
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

