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
    
    func getAllEpisodes(completion: @escaping (Result< DataPark, Error>) -> Void) {
        
        var allEpisodes = "https://spapi.dev/api/episodes"
        var url = URL(string: allEpisodes)
        
        URLSession.shared.dataTask(with: url!) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(DataPark.self, from: data)
                completion(.success(result))
//                                print(result)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    func getAllCharacters(completion: @escaping (Result< DataHero, Error>) -> Void) {
        
        var allCharacters = "https://spapi.dev/api/characters"
        var url = URL(string: allCharacters)
        
        URLSession.shared.dataTask(with: url!) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(DataHero.self, from: data)
                completion(.success(result))
                                print(result)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
