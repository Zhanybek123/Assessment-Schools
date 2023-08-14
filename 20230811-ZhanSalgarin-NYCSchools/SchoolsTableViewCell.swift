//
//  SchoolsTableViewCell.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    static let id = "SchoolTableViewCell"
    
    var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Washington"
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    func setLayouts() {
        contentView.addSubview(schoolNameLabel)
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            schoolNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            schoolNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            schoolNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
//            schoolNameLabel.widthAnchor.constraint(equalToConstant: bounds.width / 3),
//            schoolNameLabel.heightAnchor.constraint(equalToConstant: bounds.height / 2)
        ])
        
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        schoolNameLabel.font = fontMetrics.scaledFont(for: UIFont.preferredFont(forTextStyle: .headline))
    }
    
    func configure(with model: SchoolNameDataModel) {
        self.schoolNameLabel.text = model.school_name
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
        //        configureProperties(with: CountryModelToPopulate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
