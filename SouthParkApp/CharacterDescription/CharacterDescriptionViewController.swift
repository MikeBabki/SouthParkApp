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
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear

        image.translatesAutoresizingMaskIntoConstraints = false
     
        return image
    }()
    public lazy var heroView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    public lazy var descriptionTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    public lazy var heroName: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTableView.dataSource = self
        descriptionTableView.delegate = self
        self.setupUI()
        
    }
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(heroName)
        self.view.addSubview(heroImage)
        view.addSubview(heroView)
        heroView.addSubview(descriptionTableView)
        
        NSLayoutConstraint.activate([
            
            heroName.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            heroName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            heroImage.topAnchor.constraint(equalTo: heroName.topAnchor, constant: 60),
            heroImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            heroImage.widthAnchor.constraint(equalToConstant: 220),
            heroImage.heightAnchor.constraint(equalToConstant: 220),
            
            heroView.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 16),
            heroView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            heroView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            heroView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            
            descriptionTableView.topAnchor.constraint(equalTo: heroView.topAnchor, constant: 5),
            descriptionTableView.leadingAnchor.constraint(equalTo: heroView.leadingAnchor, constant: 5),
            descriptionTableView.trailingAnchor.constraint(equalTo: heroView.trailingAnchor, constant: -5),
            descriptionTableView.bottomAnchor.constraint(equalTo: heroView.bottomAnchor, constant: -5)
        
        ])
    }
}

extension CharacterDescriptionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = descriptionTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("TableView could bot deque a customcell")
        }
        cell.textLabel?.text = "\(indexPath.row)"
//        indexPath.row.description
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
