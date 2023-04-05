//
//  SearchViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 23.03.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    // MARK: - Private properties (View's)
    var massiveNetwork = NetworkManager()
    var massiveStrings: [String]? = []
    var massiveName: [String?]? = []
    var fullNameList = SouthParkCharacter.getFullName()
   
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

        getEpisode()
        print(massiveName as Any)
        
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
//    func getEpisode() {
//        massiveNetwork.getAllEpisodes { (response) in
//            switch response {
//            case .success(let data):
//
//                self.massiveStrings = data.data
////                self.massiveStrings = data.data.map({$0.map {
////                    ($0.name ?? "")
////                }})
//
////                    self.ekzHeroHeader.configure(model: data)
//
//            case .failure(let error):
//                print(error)
//
//            }
//        }
//    }
    func getEpisode() {
        massiveNetwork.getAllEpisodes { (response) in
            switch response {
            case .success(let data):
                    self.massiveName =  data.data.map({$0.map({$0.name})})
                
            case .failure(_):
                print("sasat")
            }
        }
    }
    
}

// MARK: - Extentions


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullNameList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("TableView could bot deque a customcell")
        }
        let track = fullNameList[indexPath.row]
        
        cell.configure(with: UIImage(named: (fullNameList[indexPath.row].fullName))!, and: fullNameList[indexPath.row].fullName)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CharacterDescriptionViewController()
        vc.heroImage.image = UIImage(named: fullNameList[indexPath.row].fullName)
        vc.heroName.text = fullNameList[indexPath.row].fullName
//        vc.heroImage.image = UIImage(systemName: "person")
        vc.heroImage.contentMode = .scaleAspectFill
        self.navigationController?.pushViewController(vc, animated: true)
//        print("Salamm \(indexPath.row)")
//        let vc = CharacterDescriptionViewController()
//        navigationItem.backButtonTitle = "Bacckk"
//        vc.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List"
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.text = "Characters"
//    }
}
