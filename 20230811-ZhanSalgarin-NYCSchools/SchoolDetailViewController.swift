//
//  SchoolDetailViewController.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    private var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemCyan
        label.textColor = .white
        label.text = "Something for now"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private var mathScore: UILabel = {
        let label = UILabel()
        label.text = "Something for now"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let readingScore: UILabel = {
        let label = UILabel()
        label.text = "Here is going to be a description"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    private let writingScore: UILabel = {
        let label = UILabel()
        label.text = "Here is going to be a description"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayouts()
    }
    
    func configureLayouts() {
        view.backgroundColor = .systemBackground
        [schoolNameLabel, mathScore, readingScore, writingScore].forEach { property in
            view.addSubview(property)
            property.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            
            schoolNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            schoolNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            schoolNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            mathScore.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 16),
            mathScore.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mathScore.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            readingScore.topAnchor.constraint(equalTo: mathScore.bottomAnchor, constant: 20),
            readingScore.centerXAnchor.constraint(equalTo: mathScore.centerXAnchor),
            readingScore.leftAnchor.constraint(equalTo: mathScore.leftAnchor),
            readingScore.rightAnchor.constraint(equalTo: mathScore.rightAnchor),
            
            writingScore.topAnchor.constraint(equalTo: readingScore.bottomAnchor,constant: 16),
            writingScore.leadingAnchor.constraint(equalTo: readingScore.leadingAnchor),
            writingScore.trailingAnchor.constraint(equalTo: readingScore.trailingAnchor),
            writingScore.centerXAnchor.constraint(equalTo: readingScore.centerXAnchor),
        ])
    }
    func configure(with model: SchoolScoresDataModel) {
        self.schoolNameLabel.text = model.schoolName
        self.mathScore.text = "<SAT>  Math average score: \(model.mathScore)"
        self.readingScore.text = "<SAT>  Critical reading average score: \(model.readingScore)"
        self.writingScore.text = "<SAT>  Writing average score: \(model.writingScore)"
    }
}

