//
//  SearchViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 23.03.2023.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    // MARK: - Private properties (View's)
    
    var massiveCharacters: [DataHero] = []
    var networkEkzChar = NetworkManager()
//    var fullNameList = SouthParkCharacter.getFullName()
   
    // MARK: - UI Components
    private lazy var mainTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var charactersLabel: UILabel = {
       let label = UILabel()
        label.text = "South Park Characters"
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var headerView: UIView = {
       
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.setupUI()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        loadData()
    }
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(mainTableView)
        self.view.addSubview(headerView)
        headerView.addSubview(charactersLabel)
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerView.bottomAnchor.constraint(equalTo: mainTableView.topAnchor, constant: 0),
            
            charactersLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            charactersLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0),
        
            mainTableView.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor, constant: 16),
            mainTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        ])
    }
}

// MARK: - Extentions


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massiveCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("TableView could bot deque a customcell")
        }
//        let track = fullNameList[indexPath.row]
        let data = self.massiveCharacters[indexPath.row]
   
        cell.configure(label: data.name ?? "")
//        cell.textLabel?.text = data.name
//        cell.configure(image: data.)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CharacterDescriptionViewController()
//        vc.heroImage.image = UIImage(named: fullNameList[indexPath.row].fullName)
//        vc.heroName.text = fullNameList[indexPath.row].fullName
        vc.heroImage.contentMode = .scaleAspectFill
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List"
    }
}

extension SearchViewController {
    
    func loadData() {
        networkEkzChar.getAllCharacters {  Result in
            switch Result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    self.massiveCharacters = [data] ?? []
                    self.mainTableView.reloadData()
                }
            case .failure(_):
                print("Opa")
                
            }
        }
    }
}
    
