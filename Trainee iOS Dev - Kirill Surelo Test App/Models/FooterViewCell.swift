//
//  FooterViewCell.swift
//  test-app
//
//  Created by Кирилл Сурело on 04.08.2021.
//

import UIKit

class FooterViewCell: UITableViewCell {
    
    var likesImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "awesome-heart")
        return imageView
    }()
    
    var likesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
        label.text = "Likes"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.text = "Date"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(likesImageView)
        self.addSubview(likesLabel)
        self.addSubview(dateLabel)

        likesImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        likesImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        likesImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.0).isActive = true
        likesImageView.trailingAnchor.constraint(equalTo: likesLabel.leadingAnchor, constant: -8.0).isActive = true
        likesImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0).isActive = true
        likesImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
        
        likesLabel.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor).isActive = true

        dateLabel.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
