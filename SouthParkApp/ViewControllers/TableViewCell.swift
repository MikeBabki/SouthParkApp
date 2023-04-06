//
//  TableViewCell.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 28.03.2023.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    static let identifier  = "TableViewCell"
  lazy var charNameLabel: UILabel = {
        let label = UILabel()
      label.textColor = .label
      label.textAlignment = .left
      label.font = .systemFont(ofSize: 24, weight: .medium)
        
        return label
    }()
    
   lazy var charImage: UIImageView = {
        
        let image = UIImageView()
       image.image = UIImage(systemName: "pencil")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(label: String) {
        charNameLabel.text = label
//        charImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
    }
    private func setupUI() {
        self.contentView.addSubview(charImage)
        self.contentView.addSubview(charNameLabel)
        
        charImage.translatesAutoresizingMaskIntoConstraints = false
        charNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            charImage.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            charImage.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            charImage.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            charImage.heightAnchor.constraint(equalToConstant: 90),
            charImage.widthAnchor.constraint(equalToConstant: 90),
            
            charNameLabel.leadingAnchor.constraint(equalTo: self.charImage.trailingAnchor, constant: 16),
            charNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            charNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            charNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
