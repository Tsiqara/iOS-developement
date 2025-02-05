//
//  LessonView.swift
//  OnlineLearningPlatform
//
//  Created by Mariam Tsikarishvili on 15.11.24.
//

import UIKit

class LessonView: UIView {
    
    let image = UIImageView()
    let playIcon = UIImageView()
    let details = UIView()
    let durationLabel = UILabel()
    let name = UILabel()
    let progress = UIProgressView()
    let infoStack = UIStackView()
    let lock = UIButton()
    var progressProcent: Float = 0.5
    
    var isStarted = true {
        didSet {
            setState()
        }
    }
    
    var isCompleted = false {
        didSet {
            setState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setState() {
        durationLabel.textColor = isStarted ? .black : .gray
        name.textColor = isStarted ? .black : .gray
        lock.isHidden = isCompleted
        lock.tintColor = isStarted ? .black : .gray
        progress.progress = isStarted ? (isCompleted ? 1 : progressProcent) : 0
        image.alpha = isStarted ? 1 : 0.25
    }
    
    func setup() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
        image.image = UIImage(named: "Saly-10 1")
        image.backgroundColor = UIColor(red: 83/255, green: 82/255, blue: 237/255, alpha: 1)
        image.clipsToBounds = true
        
        playIcon.image = UIImage(systemName: "play.circle.fill")
        playIcon.tintColor = .white
        playIcon.alpha = 0.75
        
        durationLabel.text = "1:10min"
        durationLabel.font = UIFont.systemFont(ofSize: 12)
        durationLabel.alpha = 0.5
        
        name.text = "0 - Swift"
        name.font = UIFont.systemFont(ofSize: 16)
        progress.progressViewStyle = .bar
        progress.trackTintColor = .lightGray.withAlphaComponent(0.25)
        progress.progressTintColor = .systemGreen
        
        infoStack.axis = .vertical
        infoStack.distribution = .fillProportionally
        infoStack.spacing = 3
        
        lock.setImage(UIImage(systemName: "lock"), for: .normal)
        lock.imageView?.contentMode = .scaleToFill
        
        image.translatesAutoresizingMaskIntoConstraints = false
        playIcon.translatesAutoresizingMaskIntoConstraints  = false
        details.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        lock.translatesAutoresizingMaskIntoConstraints = false
        lock.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(image)
        image.addSubview(playIcon)
        
        infoStack.addArrangedSubview(durationLabel)
        infoStack.addArrangedSubview(name)
        infoStack.addArrangedSubview(progress)
        
        details.addSubview(infoStack)
        details.addSubview(progress)
        details.addSubview(lock)
        addSubview(details)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            
            playIcon.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            playIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.32),
            playIcon.widthAnchor.constraint(equalTo: playIcon.heightAnchor),
            
            details.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            details.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            details.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            details.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21),
            infoStack.topAnchor.constraint(equalTo: details.topAnchor),
            infoStack.leadingAnchor.constraint(equalTo: details.leadingAnchor),
            name.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            name.widthAnchor.constraint(equalTo: details.widthAnchor, multiplier: 0.75),
            
            progress.heightAnchor.constraint(equalToConstant: 5),
            progress.widthAnchor.constraint(equalTo: details.widthAnchor),
            progress.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 15),
            progress.leadingAnchor.constraint(equalTo: details.leadingAnchor),
            
            lock.trailingAnchor.constraint(equalTo: details.trailingAnchor),
            lock.centerYAnchor.constraint(equalTo: infoStack.centerYAnchor),
            lock.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.24),
            lock.widthAnchor.constraint(equalTo: lock.heightAnchor),
            lock.imageView!.heightAnchor.constraint(equalTo: lock.heightAnchor),
            lock.imageView!.widthAnchor.constraint(equalTo: lock.widthAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.cornerRadius = 16
        self.layer.cornerRadius = 24
        progress.layer.cornerRadius = 2.5
        progress.layer.masksToBounds = true
    }
}
