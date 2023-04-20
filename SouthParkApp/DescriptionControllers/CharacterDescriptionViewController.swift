//
//  CharacterDescriptionViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 05.04.2023.
//

import UIKit

class CharacterDescriptionViewController: UIViewController {
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
        //        viewContent.translatesAutoresizingMaskIntoConstraints = false
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
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height - 5 )
        
    }
    // MARK: - Public properties
    
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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroAgeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroSexLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroHairColorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    public lazy var heroOccupationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    public lazy var heroReligionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    
    var data: DataIdCharacters? = nil
    
    // MARK: - LifeCycle - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        setupText()
        
    }
    
    // MARK: - SubViews - Constraints
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addSubview(heroName)
        stackView.addSubview(heroImage)
        stackView.addSubview(heroView)
        stackView.addSubview(heroNameLabel)
        stackView.addSubview(heroAgeLabel)
        stackView.addSubview(heroSexLabel)
        stackView.addSubview(heroOccupationLabel)
        stackView.addSubview(heroReligionLabel)
        stackView.addSubview(heroHairColorLabel)
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            heroName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            heroName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            
            heroImage.topAnchor.constraint(equalTo: heroName.topAnchor, constant: 40),
            heroImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            heroImage.heightAnchor.constraint(equalToConstant: 150),
            heroImage.widthAnchor.constraint(equalToConstant: 150),
            
            
            heroView.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 16),
            heroView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            heroView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            heroView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -90),
            
            heroImage.bottomAnchor.constraint(equalTo: heroView.topAnchor, constant: -20),
            
            
            heroNameLabel.topAnchor.constraint(equalTo: heroView.topAnchor, constant: 20),
            heroNameLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroAgeLabel.topAnchor.constraint(equalTo: heroNameLabel.topAnchor, constant: 50),
            heroAgeLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroSexLabel.topAnchor.constraint(equalTo: heroAgeLabel.topAnchor, constant: 50),
            heroSexLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroHairColorLabel.topAnchor.constraint(equalTo: heroSexLabel.topAnchor, constant: 50),
            heroHairColorLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroReligionLabel.topAnchor.constraint(equalTo: heroHairColorLabel.topAnchor, constant: 50),
            heroReligionLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            
            heroOccupationLabel.topAnchor.constraint(equalTo: heroReligionLabel.topAnchor, constant: 50),
            heroOccupationLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor, constant: 0),
            heroOccupationLabel.leadingAnchor.constraint(equalTo: heroView.leadingAnchor, constant: 5),
            heroOccupationLabel.trailingAnchor.constraint(equalTo: heroView.trailingAnchor, constant: -5),
        ])
    }
}
// MARK: - Extention (setupText)

extension CharacterDescriptionViewController {
    func setupText() {
        
        heroName.text = data?.name
        heroNameLabel.text = "Name is \(data?.name)"
        heroImage.image = UIImage(named: data?.name ?? "")
        
        
        if data?.sex == nil {
            heroSexLabel.text = "Sex is unknown"
        }else {
            heroSexLabel.text = "Sex is \(data?.sex ?? "")"
        }
        
        if data?.age == nil {
            heroAgeLabel.text = "Age is unknown"
        } else {
            heroAgeLabel.text = "Age is \(data?.age ?? 2)"
        }
        
        if data?.religion == nil {
            heroReligionLabel.text = "Religion  is unknown"
        }else {
            heroReligionLabel.text = "Religion is \(data?.religion ?? "")"
        }
        
        if data?.occupation == nil {
            heroOccupationLabel.text = "Occupation is unknown"
        }else {
            heroOccupationLabel.text = "Occupation is \(data?.occupation ?? "")"
        }
        
        if data?.hair_color == nil {
            heroHairColorLabel.text = "Hair color is unknown"
        } else {
            heroHairColorLabel.text = "Hair color is \(data?.hair_color ?? "")"
        }
        heroImage.contentMode = .scaleAspectFill
    }
}
