//
//  CollectionViewCell.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 23.03.2023.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    // MARK: - UI Components
    private let mainView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let episodeNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 5
        label.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
        label.alpha = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textColor = .white
        return label
        
    }()
    private lazy var randomEpisodeImage: UIImageView = {
        let image = UIImageView()
        
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    // MARK: - Configure a cell and constraints
    
    public func configureCollectionCell(image: String, label: String) {
        episodeNameLabel.text = label
        randomEpisodeImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
    }
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.addSubview(mainView)
        mainView.addSubview(randomEpisodeImage)
        mainView.addSubview(episodeNameLabel)
        
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mainView.widthAnchor.constraint(equalToConstant: 140),
            mainView.heightAnchor.constraint(equalToConstant: 200),
            
            randomEpisodeImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            randomEpisodeImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            randomEpisodeImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            randomEpisodeImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            
            episodeNameLabel.leadingAnchor.constraint(equalTo: randomEpisodeImage.leadingAnchor, constant: 3),
            episodeNameLabel.trailingAnchor.constraint(equalTo: randomEpisodeImage.trailingAnchor, constant: -3),
            episodeNameLabel.topAnchor.constraint(equalTo: randomEpisodeImage.topAnchor, constant: 10)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
