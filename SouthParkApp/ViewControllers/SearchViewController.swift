//
//  SearchViewController.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 23.03.2023.
//

import UIKit
import SDWebImage
import MBProgressHUD

class SearchViewController: UIViewController {
    
    // MARK: - Private properties (View's)
    private var pageNumber = 1
    var pagesNum = DataId()
    var massiveIdCharacters: [DataIdCharacters] = []
    var networkEkzChar = NetworkManager()
    
    var filteredString = ""
    private var searchDataCharacters = [DataIdCharacters]()
    private var searchCharactersArray = [DataIdCharacters]()
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
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
    private lazy var searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        loadData()
        allChars()
 
    }
    func allChars() {
        for i in 1...20 {
            networkEkzChar.getAllIdCharacters(charId: i) { result in
                switch result {
                     
                case .success(let dataChars):
                    DispatchQueue.main.async {
                        self.searchCharactersArray.append(contentsOf: dataChars.data ?? [])
                        self.mainTableView.reloadData()
                    }
                case .failure(_):
                    print("Llel")
                }
            }
        }
    }
    
    private func setupUI() {
        
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(mainTableView)
        self.view.addSubview(headerView)
        headerView.addSubview(charactersLabel)
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
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
        navigationItem.searchController = searchController
    }
}

// MARK: - Extentions for tableview datasource, delegate and animation

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchController.isActive ? searchDataCharacters : searchCharactersArray ).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("TableView could bot deque a customcell")
        }
        if searchController.isActive && searchController.searchBar.text?.count ?? 0 >= 3 {
            let data = searchDataCharacters[indexPath.row]
            cell.configure(label: data.name ?? "", image: data.image)

        } else {
            let data = searchCharactersArray[indexPath.row]
            cell.configure(label: data.name, image: data.name)
        }
        return cell
        
    }
    private func animateTableView() {
        
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
        //поправить нажатие
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CharacterDescriptionViewController()
        if searchController.isActive {
            vc.data = self.searchDataCharacters[indexPath.row]
        } else {
            vc.data = self.searchCharactersArray[indexPath.row]
        }
//        vc.data = self.searchCharactersArray[indexPath.row]
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
        for pages in 1...20 {
//        MBProgressHUD.showAdded(to: self.view, animated: true)
            networkEkzChar.getAllIdCharacters(charId: pageNumber) {  result in
                switch result {
                    
                case .success(let data):
                    DispatchQueue.main.async {
//                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.pageNumber += 1
                        self.massiveIdCharacters.append(contentsOf: data.data ?? [])
                        self.mainTableView.reloadData()
                        self.pagesNum = data
                        self.animateTableView()
                        print(self.searchCharactersArray.count)
                    }
                case .failure(let error):
                    print("Opa")
                }
            }
        }
    }
}
extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        let text = searchController.searchBar.text ?? ""
        if text.count >= 3 {
            var filtered = self.searchCharactersArray.filter({$0.name.contains(text)})
            if !filtered.isEmpty {
                searchDataCharacters = filtered
                self.mainTableView.reloadData()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        searchDataCharacters = []
        self.mainTableView.reloadData()
    }
}
