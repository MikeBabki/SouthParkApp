//
//  CharacterDescriptionViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 05.04.2023.
//

import UIKit

class CharacterDescriptionViewController: UIViewController {
    
    public lazy var heroImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear

        image.translatesAutoresizingMaskIntoConstraints = false
     
        return image
    }()
    public lazy var heroView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    public lazy var heroName: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    // MARK: - Characters info properties
    
    public lazy var heroNameLabel: UILabel = {
       let label = UILabel()
//        label.text = "Name"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroAgeLabel: UILabel = {
       let label = UILabel()
//        label.text = "Age"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroSexLabel: UILabel = {
       let label = UILabel()
//        label.text = "Sex"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroHairColorLabel: UILabel = {
       let label = UILabel()
//        label.text = "Hair Color"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroOccupationLabel: UILabel = {
       let label = UILabel()
//        label.text = "Occupation"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    public lazy var heroReligionLabel: UILabel = {
       let label = UILabel()
//        label.text = "Religion"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
    }
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(heroName)
        self.view.addSubview(heroImage)
        view.addSubview(heroView)
        heroView.addSubview(heroNameLabel)
        heroView.addSubview(heroAgeLabel)
        heroView.addSubview(heroSexLabel)
        heroView.addSubview(heroOccupationLabel)
        heroView.addSubview(heroReligionLabel)
        heroView.addSubview(heroHairColorLabel)
        
        NSLayoutConstraint.activate([
            
            heroName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            heroName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            heroImage.topAnchor.constraint(equalTo: heroName.topAnchor, constant: 60),
            heroImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            heroImage.heightAnchor.constraint(equalToConstant: 150),
            heroImage.widthAnchor.constraint(equalToConstant: 150),
        
            
            heroView.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 16),
            heroView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            heroView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            heroView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            
            heroImage.bottomAnchor.constraint(equalTo: heroView.topAnchor, constant: -30),
            
            
            heroNameLabel.topAnchor.constraint(equalTo: heroView.topAnchor, constant: 30),
            heroNameLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroAgeLabel.topAnchor.constraint(equalTo: heroNameLabel.topAnchor, constant: 65),
            heroAgeLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),

            heroSexLabel.topAnchor.constraint(equalTo: heroAgeLabel.topAnchor, constant: 65),
            heroSexLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroHairColorLabel.topAnchor.constraint(equalTo: heroSexLabel.topAnchor, constant: 65),
            heroHairColorLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroReligionLabel.topAnchor.constraint(equalTo: heroHairColorLabel.topAnchor, constant: 65),
            heroReligionLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroOccupationLabel.topAnchor.constraint(equalTo: heroReligionLabel.topAnchor, constant: 65),
            heroOccupationLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            heroOccupationLabel.leadingAnchor.constraint(equalTo: heroView.leadingAnchor, constant: 5),
            heroOccupationLabel.trailingAnchor.constraint(equalTo: heroView.trailingAnchor, constant: -5)
//            heroOccupationLabel.bottomAnchor.constraint(equalTo: heroView.bottomAnchor, constant: -40)

            
            
            
        
        ])
    }
}

