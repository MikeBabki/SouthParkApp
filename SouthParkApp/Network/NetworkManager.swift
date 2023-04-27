//
//  NetworkManager.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 28.03.2023.
//

import Foundation

class NetworkManager {
    
    enum APIError: Error {
        case failedToGetData
    }
    
    static let shared = NetworkManager()
    
    func getAllEpisodes(pageId: Int, completion: @escaping (Result< DataPark, Error>) -> Void) {
        
        let url = URL(string: URLManager.trendingEpisodesURLCreator(episodePage: pageId))
        URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(DataPark.self, from: data)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getAllIdCharacters(charId: Int, completion: @escaping (Result< DataId, Error>) -> Void) {
        let url = URL(string: URLManager.characterURLCreator(characterID: charId))
        print(url)
        URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(DataId.self, from: data)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getFilteredHeroes(arrayAllChar: Int, completion: @escaping (Result< DataIdCharacters, Error>) -> Void) {
        let url = URL(string: URLManager.characterURLCreator(characterID: arrayAllChar))
        print(url)
        URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(DataIdCharacters.self, from: data)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
