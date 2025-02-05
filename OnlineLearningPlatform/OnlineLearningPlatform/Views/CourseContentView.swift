//
//  CourseContentView.swift
//  OnlineLearningPlatform
//
//  Created by Mariam Tsikarishvili on 17.11.24.
//

import UIKit

class CourseContentView: UIView {
    let introduction = UIView()
    let background = UIImageView()
    let university = UILabel()
    let saveButton = UIButton()
    let courseName = UILabel()
    let author = UILabel()
    
    let detail = UIView()
    let info = UIView()
    let lessonNumber = UILabel()
    let duration = UILabel()
    let timeIcon = UIButton()
    let descriptionLabel = UILabel()
    let lessonStack = UIStackView()
    let lesson1 = LessonView()
    let lesson2 = LessonView()
    let lesson3 = LessonView()
    let lesson4 = LessonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIntro()
        setupDetails()
        setupLessons()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIntro() {
        background.image = UIImage(named: "Background")
//        background.contentMode = .scaleAspectFill
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        saveButton.tintColor = .white
        
        university.text = "FreeUni"
        university.font = UIFont.systemFont(ofSize: 18)
        university.textColor = .white
        
        courseName.text = "Mobile Development on iOS"
        courseName.font = UIFont.systemFont(ofSize: 26)
        courseName.textColor = .white
        
        author.text = "by Mariam Tsikarishvili"
        author.textColor = .white
        author.font = UIFont.systemFont(ofSize: 14)
        
        introduction.addSubview(background)
        introduction.addSubview(saveButton)
        introduction.addSubview(university)
        introduction.addSubview(courseName)
        introduction.addSubview(author)
        
        self.addSubview(introduction)
    }
    
    func setupDetails() {
        lessonNumber.text = "16 Lessons"
        lessonNumber.font = UIFont.boldSystemFont(ofSize: 18)
        
        duration.text = "3hr 20min"
        duration.font = UIFont.systemFont(ofSize: 14)
        duration.alpha = 0.5
        timeIcon.setImage(UIImage(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90"), for: .normal)
        timeIcon.alpha = 0.5
        timeIcon.tintColor = .black
        
        descriptionLabel.text = "This course will be teach the basic how to start your mobile development career on iOS."
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.alpha = 0.5
        descriptionLabel.numberOfLines = 0
        
        detail.backgroundColor = .white
        
        info.addSubview(lessonNumber)
        info.addSubview(timeIcon)
        info.addSubview(duration)
        
        detail.addSubview(info)
        detail.addSubview(descriptionLabel)
        detail.addSubview(lessonStack)
        
        self.addSubview(detail)
    }
    
    func addConstraints() {
        info.translatesAutoresizingMaskIntoConstraints = false
        detail.translatesAutoresizingMaskIntoConstraints = false
        lessonNumber.translatesAutoresizingMaskIntoConstraints = false
        duration.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        lessonStack.translatesAutoresizingMaskIntoConstraints = false
        lesson1.translatesAutoresizingMaskIntoConstraints = false
        lesson2.translatesAutoresizingMaskIntoConstraints = false
        lesson3.translatesAutoresizingMaskIntoConstraints = false
        lesson4.translatesAutoresizingMaskIntoConstraints = false
        introduction.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        university.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        courseName.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            introduction.topAnchor.constraint(equalTo: self.topAnchor),
            introduction.bottomAnchor.constraint(equalTo: detail.topAnchor, constant: 30),
            introduction.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            introduction.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            background.topAnchor.constraint(equalTo: introduction.topAnchor),
            background.bottomAnchor.constraint(equalTo: introduction.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: introduction.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: introduction.trailingAnchor),
            
            university.topAnchor.constraint(equalTo: introduction.topAnchor, constant: 100),
            university.leadingAnchor.constraint(equalTo: introduction.leadingAnchor, constant: 30),
            
            saveButton.centerYAnchor.constraint(equalTo: university.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: introduction.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalTo: lesson1.lock.heightAnchor),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor),
            
            courseName.topAnchor.constraint(equalTo: university.bottomAnchor, constant: 30),
            courseName.leadingAnchor.constraint(equalTo: university.leadingAnchor),
            
            author.leadingAnchor.constraint(equalTo: courseName.leadingAnchor),
            author.topAnchor.constraint(equalTo: courseName.bottomAnchor, constant: 5),
            
            detail.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detail.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            detail.topAnchor.constraint(equalTo: self.topAnchor, constant: 240),
            detail.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            
            info.leadingAnchor.constraint(equalTo: detail.leadingAnchor, constant: 30),
            info.topAnchor.constraint(equalTo: detail.topAnchor, constant: 30),
            info.heightAnchor.constraint(equalTo: lessonNumber.heightAnchor),
            info.trailingAnchor.constraint(equalTo: detail.trailingAnchor, constant: -30),
            
            lessonNumber.leadingAnchor.constraint(equalTo: info.leadingAnchor),
            lessonNumber.topAnchor.constraint(equalTo: info.topAnchor),
            duration.trailingAnchor.constraint(equalTo: info.trailingAnchor),
            duration.centerYAnchor.constraint(equalTo: lessonNumber.centerYAnchor),
            timeIcon.trailingAnchor.constraint(equalTo: duration.leadingAnchor, constant: -8),
            timeIcon.heightAnchor.constraint(equalTo: duration.heightAnchor),
            timeIcon.widthAnchor.constraint(equalTo: timeIcon.heightAnchor),
            timeIcon.topAnchor.constraint(equalTo: duration.topAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: info.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: info.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: info.trailingAnchor),
            
            lessonStack.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: 16),
            
            lesson1.heightAnchor.constraint(equalToConstant: 100),
            lesson1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            lesson1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            lesson1.topAnchor.constraint(equalTo: lessonStack.topAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        detail.layer.cornerRadius = 32
    }
    
    func setupLessons() {
        lesson1.durationLabel.text = "1:10min"
        lesson1.name.text = "0 - Swift"
        lesson1.isStarted = true
        lesson1.isCompleted = true
        lesson1.image.image = UIImage(named: "Saly-10 1")
        lesson1.image.backgroundColor = UIColor(red: 83/255, green: 82/255, blue: 237/255, alpha: 1)
        
        lesson2.durationLabel.text = "15:10min"
        lesson2.name.text = "1 - Advanced Swift"
        lesson2.isStarted = true
        lesson2.isCompleted = false
        lesson2.progressProcent = 0.5
        lesson2.image.image = UIImage(named: "Frame 42")
        lesson2.image.backgroundColor = UIColor(red: 204/255, green: 180/255, blue: 255/255, alpha: 0.5)
        
        lesson3.durationLabel.text = "22:56min"
        lesson3.name.text = "2 - UIViews"
        lesson3.isStarted = false
        lesson3.isCompleted = false
        lesson3.image.image = UIImage(named: "Saly-23 1")
        lesson3.image.backgroundColor = UIColor(red: 255/255, green: 123/255, blue: 2/255, alpha: 0.5)
        
        lesson4.durationLabel.text = "22:45min"
        lesson4.name.text = "3 - Constraints"
        lesson4.isStarted = false
        lesson4.isCompleted = false
        lesson4.image.image = UIImage(named: "Frame 43")
        lesson4.image.backgroundColor = UIColor(red: 204/255, green: 180/255, blue: 255/255, alpha: 0.5)
        
        lessonStack.spacing = 16
        lessonStack.axis = .vertical
        lessonStack.addArrangedSubview(lesson1)
        lessonStack.addArrangedSubview(lesson2)
        lessonStack.addArrangedSubview(lesson3)
        lessonStack.addArrangedSubview(lesson4)
        
//        detail.addSubview(lessonStack)
//        self.addSubview(lessonStack)
    }
}
