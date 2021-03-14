//
//  SecretTableViewCell.swift
//  SecretList
//
//  Created by first on 2021/03/14.
//

import UIKit

class SecretTableViewCell: UITableViewCell {
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(formIdLabel)
        formIdLabel.tag = 1
        passwordLabel.tag = 2

        //heightを設定するとセルが可変にならない
        formIdLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 1).isActive = true
        formIdLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        formIdLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: formIdLabel.bottomAnchor).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
/*
    var serviceNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.backgroundColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.clipsToBounds = true
        label.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
*/
    
    var passwordLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor =  .systemBackground
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    var formIdLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor =  .systemBackground
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
}
