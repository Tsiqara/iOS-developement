//
//  OnlineLearningViewController.swift
//  OnlineLearningPlatform
//
//  Created by Mariam Tsikarishvili on 15.11.24.
//

import UIKit

class OnlineLearningViewController: UIViewController {

    let course = CourseContentView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        course.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(course)
        
        NSLayoutConstraint.activate([
            course.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            course.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            course.topAnchor.constraint(equalTo: view.topAnchor),
            course.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

