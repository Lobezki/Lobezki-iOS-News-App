//
//  ImageViewCell.swift
//  test-app
//
//  Created by Кирилл Сурело on 04.08.2021.
//

import UIKit

class TextViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        label.text = "Title"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let mainTextLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.text = "Text"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLabel)
        self.addSubview(mainTextLabel)

        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: mainTextLabel.topAnchor, constant: -15.0).isActive = true
        
        mainTextLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        mainTextLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        mainTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
