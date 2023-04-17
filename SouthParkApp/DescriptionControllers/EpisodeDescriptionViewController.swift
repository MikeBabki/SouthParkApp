//
//  EpisodeDescriptionViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 13.04.2023.
//

import UIKit

class EpisodeDescriptionViewController: UIViewController {

    public lazy var episodeMainPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var episodeDesciprionView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    public lazy var episodeAndSeasonLabel: UILabel = {
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
    
    public lazy var episodeNameLabel: UILabel = {
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
    public lazy var episodeAirDateLabel: UILabel = {
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
    public lazy var episodeDescriptionLabel: UILabel = {
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
    
    static let identifier  = "episodeDescriptionId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setupText()
    }

}
// MARK: - AddSubView's

extension EpisodeDescriptionViewController {
    
    func setupText() {
        
        view.addSubview(episodeMainPhoto)
        view.addSubview(episodeDesciprionView)
        episodeDesciprionView.addSubview(episodeNameLabel)
        episodeDesciprionView.addSubview(episodeAndSeasonLabel)
        episodeDesciprionView.addSubview(episodeAirDateLabel)
        episodeDesciprionView.addSubview(episodeDescriptionLabel)
        
        
        
        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            episodeMainPhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            episodeMainPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            episodeMainPhoto.heightAnchor.constraint(equalToConstant: 270),
            episodeMainPhoto.widthAnchor.constraint(equalToConstant: 270),
            
            episodeDesciprionView.topAnchor.constraint(equalTo: episodeMainPhoto.bottomAnchor, constant: 20),
            episodeDesciprionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            episodeDesciprionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            episodeDesciprionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            episodeNameLabel.topAnchor.constraint(equalTo: episodeDesciprionView.topAnchor, constant: 30),
            episodeNameLabel.leadingAnchor.constraint(equalTo: episodeDesciprionView.leadingAnchor, constant: 20),
            episodeNameLabel.trailingAnchor.constraint(equalTo: episodeDesciprionView.trailingAnchor, constant: -20),
            
            episodeAndSeasonLabel.topAnchor.constraint(equalTo: episodeNameLabel.topAnchor, constant: 30),
            episodeAndSeasonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            episodeAndSeasonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            episodeAirDateLabel.topAnchor.constraint(equalTo: episodeAndSeasonLabel.topAnchor, constant: 25),
            episodeAirDateLabel.centerXAnchor.constraint(equalTo: episodeDesciprionView.centerXAnchor, constant: 0),
//            episodeAirDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            episodeAirDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            episodeDescriptionLabel.topAnchor.constraint(equalTo: episodeAirDateLabel.topAnchor, constant: 30),
            episodeDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            episodeDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            episodeDescriptionLabel.bottomAnchor.constraint(equalTo: episodeDesciprionView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            

    ])
        
    }
}

