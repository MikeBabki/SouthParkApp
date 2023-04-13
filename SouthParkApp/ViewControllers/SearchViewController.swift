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
    private var pageNumber = 1
    var pagesNum = DataId()
    var massiveIdCharacters: [DataIdCharacters] = []
    var networkEkzChar = NetworkManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateTableView()
    }
   
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
        self.mainTableView.tableFooterView = UIView(frame: .zero)
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
        
        return massiveIdCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("TableView could bot deque a customcell")
        }
        let data = massiveIdCharacters[indexPath.row]
        cell.configure(label: data.name ?? "", image: data.image)
        
        return cell
    }
    private func animateTableView() {
        mainTableView.reloadData()
        let cells = mainTableView.visibleCells
        let tableViewHeight = mainTableView.bounds.height
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            
            UIView.animate(withDuration: 1.5,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                cell.transform =  CGAffineTransform.identity
            }
            delay += 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CharacterDescriptionViewController()
        let data2 = massiveIdCharacters[indexPath.row]
        vc.heroName.text = data2.name
        vc.heroNameLabel.text = "Name is \(data2.name)"
        vc.heroImage.image = UIImage(named: data2.name)

        
        if data2.sex == nil {
            vc.heroSexLabel.text = "Sex is unknown"
        }else {
            vc.heroSexLabel.text = "Sex is \(data2.sex ?? "")"
        }
        
        if data2.age == nil {
            vc.heroAgeLabel.text = "Age is unknown"
        } else {
            vc.heroAgeLabel.text = "Age is \(data2.age ?? 2)"
        }

        if data2.religion == nil {
            vc.heroReligionLabel.text = "Religion  is unknown"
        }else {
            vc.heroReligionLabel.text = "Religion is \(data2.religion ?? "")"
        }

        if data2.occupation == nil {
            vc.heroOccupationLabel.text = "Occupation is unknown"
        }else {
            vc.heroOccupationLabel.text = "Occupation is \(data2.occupation ?? "")"
        }

        if data2.hair_color == nil {
            vc.heroHairColorLabel.text = "Hair color is unknown"
        } else {
            vc.heroHairColorLabel.text = "Hair color is \(data2.hair_color ?? "")"
        }
        
        vc.heroImage.contentMode = .scaleAspectFill
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if pageNumber == pageNumber + 1 {
        } else {
            if indexPath.row == (massiveIdCharacters.count ?? 3) - 2 {
                loadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List"
    }
}

extension SearchViewController {
    func loadData() {
        networkEkzChar.getAllIdCharacters(charId: pageNumber) {  result in
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    
                    self.pageNumber += 1
                    self.massiveIdCharacters.append(contentsOf: data.data ?? [])
                    self.mainTableView.reloadData()
                    self.pagesNum = data
                }
            case .failure(let error):
                print("Opa")
            }
        }
    }
}
