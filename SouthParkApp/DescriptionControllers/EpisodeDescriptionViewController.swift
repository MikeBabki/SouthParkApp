//
//  EpisodeDescriptionViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 13.04.2023.
//

import UIKit

class EpisodeDescriptionViewController: UIViewController {
    // MARK: - Private properties
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = contentSize
        scroll.frame = view.bounds
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let viewContent = UIView()
        view.backgroundColor = .black
        viewContent.frame.size = contentSize
        return viewContent
    }()
    
    private let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var episodeMainPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var episodeAndSeasonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.backgroundColor = UIColor(white: 0.15, alpha: 0.75)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 21)
        label.backgroundColor = UIColor(white: 0.25, alpha: 0.8)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        return label
    }()
    private lazy var episodeAirDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = UIColor(white: 0.15, alpha: 0.6)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 2
        label.numberOfLines = 0
        return label
    }()
    private lazy var episodeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.15, alpha: 0.6)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 30
        label.font = .systemFont(ofSize: 23)
        label.numberOfLines = 0
        return label
    }()
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height - 5 )
        
    }
    
    static let identifier  = "episodeDescriptionId"
    var data: Data? = nil
    
    // MARK: - LifeCycle - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupText()
    }
}
// MARK: - AddSubView's - Constraints

extension EpisodeDescriptionViewController {
    
    func setupUI() {
        
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addSubview(episodeMainPhoto)
        stackView.addSubview(episodeNameLabel)
        stackView.addSubview(episodeAndSeasonLabel)
        stackView.addSubview(episodeAirDateLabel)
        stackView.addSubview(episodeDescriptionLabel)
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            episodeMainPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            episodeMainPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            episodeMainPhoto.heightAnchor.constraint(equalToConstant: 270),
            episodeMainPhoto.widthAnchor.constraint(equalToConstant: 270),
            
            episodeNameLabel.topAnchor.constraint(equalTo: episodeMainPhoto.bottomAnchor, constant: 20),
            episodeNameLabel.heightAnchor.constraint(equalToConstant: 30),
            episodeNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            episodeAndSeasonLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 20),
            episodeAndSeasonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            episodeAndSeasonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            episodeAndSeasonLabel.heightAnchor.constraint(equalToConstant: 30),
            
            episodeAirDateLabel.topAnchor.constraint(equalTo: episodeAndSeasonLabel.bottomAnchor, constant: 20),
            episodeAirDateLabel.heightAnchor.constraint(equalToConstant: 30),
            episodeAirDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            
            episodeDescriptionLabel.topAnchor.constraint(equalTo: episodeAirDateLabel.bottomAnchor, constant: 20),
            episodeDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            episodeDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
        ])
    }
}
// MARK: - Extention (setupText)

extension EpisodeDescriptionViewController {
    func setupText() {
        episodeNameLabel.text = data?.name ?? ""
        episodeAndSeasonLabel.text = "Season \(data?.season ?? 0), episode \(data?.episode ?? 0)"
        episodeAirDateLabel.text = data?.air_date ?? ""
        episodeDescriptionLabel.text = data?.description ?? ""
        episodeMainPhoto.sd_setImage(with: URL(string: data?.thumbnail_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
