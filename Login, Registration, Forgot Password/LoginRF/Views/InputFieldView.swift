//
//  InputFieldView.swift
//  LoginRF
//
//  Created by Mariam Tsikarishvili on 18.12.24.
//

import UIKit

class InputFieldView : UIView {
    let title = UILabel()
    let textView = UIView()
    let inputText = UITextField()
    let privacyButton = UIButton()
    let error = UIView()
    let errorLabel = UILabel()
    let errorSymbol = UIButton()
    
    var inputIsPrivate: Bool = true {
        didSet {
            setState()
        }
    }
    
    var inputCanBePrivate: Bool = true {
        didSet {
            setState()
        }
    }
    
    var errorOccured: Bool = false {
        didSet {
            setState()
        }
    }
    
    var isGettingInput: Bool = false{
        didSet {
            setState()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setState()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setState(){
        privacyButton.setImage(UIImage(systemName: inputIsPrivate ? "eye.slash" :"eye"), for: .normal)
        inputText.isSecureTextEntry = inputCanBePrivate && inputIsPrivate
        privacyButton.isHidden = !inputCanBePrivate
        error.isHidden = !errorOccured
        
        textView.layer.borderColor = errorOccured ? UIColor(.red).cgColor : UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1.0).cgColor
        textView.backgroundColor = .white
        if(isGettingInput){
            textView.backgroundColor = UIColor(red: 232/255, green: 237/255, blue: 251/255, alpha: 1)
            textView.layer.borderColor = UIColor(red: 24/255, green: 73/255, blue: 214/255, alpha: 1.0).cgColor
        }
    }
    
    private func setup(){
        title.text = "Text"
        title.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(title)
        
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        
        inputText.placeholder = "Input text"
        inputText.font = UIFont.systemFont(ofSize: 16)
        inputText.isUserInteractionEnabled = true
        inputText.isEnabled = true
        inputText.delegate = self
   
        privacyButton.tintColor = .black
        privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        
        textView.addSubview(inputText)
        textView.addSubview(privacyButton)
        self.addSubview(textView)
        
        errorSymbol.setImage(UIImage(systemName: "exclamationmark.circle.fill"), for: .normal)
        errorSymbol.tintColor = .red
        
        errorLabel.text = "Error message"
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        
        error.addSubview(errorSymbol)
        error.addSubview(errorLabel)
        self.addSubview(error)
    }
    
    @objc
    private func privacyButtonTapped(){
        inputIsPrivate.toggle()
    }
    
    private func addConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        inputText.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.translatesAutoresizingMaskIntoConstraints = false
        error.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorSymbol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor),
            
            textView.topAnchor.constraint(equalTo: title.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            privacyButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -12),
            privacyButton.widthAnchor.constraint(equalToConstant: 22),
            privacyButton.heightAnchor.constraint(equalTo: privacyButton.widthAnchor),
            privacyButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            
            inputText.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 12),
            inputText.trailingAnchor.constraint(equalTo: privacyButton.leadingAnchor, constant: -6),
            inputText.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            inputText.topAnchor.constraint(equalTo: textView.topAnchor, constant: 16),
            inputText.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -16),
            
            error.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            error.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            error.topAnchor.constraint(equalTo: textView.bottomAnchor),
            error.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            error.heightAnchor.constraint(equalTo: errorSymbol.heightAnchor),
            
            errorSymbol.leadingAnchor.constraint(equalTo: error.leadingAnchor),
            errorSymbol.widthAnchor.constraint(equalToConstant: 16),
            errorSymbol.heightAnchor.constraint(equalTo: errorSymbol.widthAnchor),
            errorSymbol.topAnchor.constraint(equalTo: error.topAnchor),
            
            errorLabel.leadingAnchor.constraint(equalTo: errorSymbol.trailingAnchor, constant: 6),
            errorLabel.centerYAnchor.constraint(equalTo: error.centerYAnchor),

        ])
    }
}

extension InputFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isGettingInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isGettingInput = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isGettingInput = false
        return true
    }
}

