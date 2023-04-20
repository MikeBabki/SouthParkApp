//
//  HomeViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 23.03.2023.
//

import UIKit
import SDWebImage


class HomeViewController: UIViewController {
    
    // MARK: - Private properties
    
    var networkEkz = NetworkManager()
    var massiveEpisodes: [Data] = []
    var pagesNum = DataPark()
    
    private var numberEpisode: Int = 0
    private var pageNum = 1
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var episodesView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Private properties First View
    
    private lazy var randomEpisodeImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
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
        button.addTarget(self, action: #selector(watchThisButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private properties Second View
    
    private lazy var episodesLabel: UILabel = {
        let label = UILabel()
        label.text = "TRENDING EPISODES"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionViewEpisodes: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        if view.bounds.height <= 700 {
            layout.itemSize = CGSize(width: 120, height: 150)
            print("for little screem")
        } else {
            layout.itemSize = CGSize(width: 140, height: 200)
            print("for hight screen")
        }
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.contentMode = .scaleToFill
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - LifeCycle - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupText()
        loadData()
    }
    // MARK: - Action
    
    @objc func watchThisButton() {
        let vc = EpisodeDescriptionViewController()
        vc.data = massiveEpisodes[self.numberEpisode]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - AddSubView's - Constraints

extension HomeViewController {
    
    func setupText() {
        
        collectionViewEpisodes.dataSource = self
        collectionViewEpisodes.delegate = self
        
        view.addSubview(mainView)
        view.addSubview(episodesView)
        
        mainView.addSubview(titleHeaderImage)
        mainView.addSubview(randomEpisodeImage)
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
            
            titleHeaderImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            titleHeaderImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            titleHeaderImage.widthAnchor.constraint(equalToConstant: 170),
            titleHeaderImage.bottomAnchor.constraint(equalTo: randomEpisodeImage.topAnchor, constant: 0),
            
            watchRandomEpisodeButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            watchRandomEpisodeButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0),
            watchRandomEpisodeButton.widthAnchor.constraint(equalToConstant: 140),
            
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


// MARK: - Extention's for colelction view datasourse, delegate, animation

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massiveEpisodes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
            let data = self.massiveEpisodes[indexPath.item]
            UIView.animate(withDuration: 0.5,
                           animations: {
                //Fade-out
                cell.alpha = 0.5
            }) { (completed) in
                UIView.animate(withDuration: 0.3,
                               animations: {
                    //Fade-out
                    cell.alpha = 1
                })
            }
            cell.configureCollectionCell(image: data.thumbnail_url ?? "" , label: data.name ?? "Error")
            cell.backgroundColor = .systemBackground
            return cell
        }
        fatalError("Unable to deque")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pageNum == pageNum + 1 {
        } else {
            if indexPath.row == (massiveEpisodes.count ?? 3) - 2 {
                loadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = EpisodeDescriptionViewController()
        vc.data = self.massiveEpisodes[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeViewController {
    
    func loadData() {
        networkEkz.getAllEpisodes(pageId: pageNum) { Result in
            switch Result {
                
            case .success(let data):
                
                DispatchQueue.main.async {
                    var number = [0,1,2,3,4,5,6,7,8,9]
                    self.numberEpisode = number.randomElement() ?? 2
                    self.pageNum += 1
                    self.massiveEpisodes.append(contentsOf: data.data ?? [])
                    self.randomEpisodeImage.sd_setImage(with: URL(string: self.massiveEpisodes[self.numberEpisode].thumbnail_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
                    self.collectionViewEpisodes.reloadData()
                }
            case .failure(_):
                print("Opa")
                
            }
        }
    }
}
