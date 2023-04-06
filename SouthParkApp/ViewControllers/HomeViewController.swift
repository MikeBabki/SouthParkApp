//
//  HomeViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 23.03.2023.
//

import UIKit
import SDWebImage


class HomeViewController: UIViewController {

    // MARK: - Private properties (View's)
    var networkEkz = NetworkManager()
    var massiveEpisodes: [Data] = []
    
    private lazy var mainView: UIView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var episodesView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .black
        return imageView
    }()
    
    // MARK: - Private properties First View
    private lazy var randomEpisodeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heroImage")
        image.clipsToBounds = true
//        image.backgroundColor = .black
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    private lazy var titleHeaderImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoSouth1")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var watchRandomEpisodeButton: UIButton = {
       
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        button.alpha = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Watch this!", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    // MARK: - Private properties Second View
    
    private lazy var episodesLabel: UILabel = {
        let label = UILabel()
        
        label.text = "TRENDING EPISODES"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionViewEpisodes: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
//        layout.collectionView?.isScrollEnabled = true
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.contentMode = .scaleToFill
        collection.showsHorizontalScrollIndicator = false

        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupText()
        loadData()
    }
}

// MARK: - AddSubView's

extension HomeViewController {
    
    func setupText() {
        
        collectionViewEpisodes.dataSource = self
        collectionViewEpisodes.delegate = self
        
        view.addSubview(mainView)
        view.addSubview(episodesView)
        
        mainView.addSubview(randomEpisodeImage)
        mainView.addSubview(titleHeaderImage)
        mainView.addSubview(watchRandomEpisodeButton)
        
        episodesView.addSubview(episodesLabel)
        episodesView.addSubview(collectionViewEpisodes)
        
        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -270),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            episodesView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            episodesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            episodesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            episodesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            randomEpisodeImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 35),
            randomEpisodeImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            randomEpisodeImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            randomEpisodeImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            
            titleHeaderImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            titleHeaderImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            titleHeaderImage.widthAnchor.constraint(equalToConstant: 170),
            titleHeaderImage.bottomAnchor.constraint(equalTo: randomEpisodeImage.topAnchor, constant: 0),
            
            watchRandomEpisodeButton.bottomAnchor.constraint(equalTo: randomEpisodeImage.bottomAnchor, constant: -20),
            watchRandomEpisodeButton.centerXAnchor.constraint(equalTo: randomEpisodeImage.centerXAnchor, constant: 0),
            watchRandomEpisodeButton.widthAnchor.constraint(equalToConstant: 150),
            
            episodesLabel.topAnchor.constraint(equalTo: episodesView.topAnchor, constant: 20),
            episodesLabel.leadingAnchor.constraint(equalTo: episodesView.leadingAnchor, constant: 16),
            episodesLabel.trailingAnchor.constraint(equalTo: episodesView.trailingAnchor, constant: -16),
            
            collectionViewEpisodes.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 10),
            collectionViewEpisodes.leadingAnchor.constraint(equalTo: episodesView.leadingAnchor, constant: 16),
            collectionViewEpisodes.trailingAnchor.constraint(equalTo: episodesView.trailingAnchor, constant: -16),
            collectionViewEpisodes.bottomAnchor.constraint(equalTo: episodesView.bottomAnchor, constant: 0)
        ])
    }
}


// MARK: - Extention's for datasourse and delegate

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massiveEpisodes.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
            let data = self.massiveEpisodes[indexPath.item]
            
            cell.configureCollectionCell(image: data.thumbnail_url ?? "" , label: data.name ?? "Error")
            cell.backgroundColor = .systemBackground
            return cell
        }
        fatalError("Unable to deque")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension HomeViewController {
    
    func loadData() {
        networkEkz.getAllEpisodes { Result in
            switch Result {
            
            case .success(let data):
                DispatchQueue.main.async {
                    self.massiveEpisodes = data.data ?? []
                    self.collectionViewEpisodes.reloadData()
                }
            case .failure(_):
                print("Opa")
                
            }
        }
    }
    
}
