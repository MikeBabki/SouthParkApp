//
//  URLManager.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 28.03.2023.
//

import Foundation

class URLManager {
    static let urlString = "https://spapi.dev/api"
    
    static func episodesURLCreator(episodeNumber: Int) -> String {
        return urlString + "/character/\(episodeNumber)"
    }
    static func characterURLCreator(characterID: Int) -> String {
        return urlString + "/characters?page=\(characterID)"
    }
    static func trendingEpisodesURLCreator(episodePage: Int) -> String {
        return urlString + "/episodes?page=\(episodePage)"
    }
    static func searchCharacterURL(nameChar: String) -> String {
        return urlString + "/characters?search=\(nameChar)"
    }
}

//https://spapi.dev/api/characters?search=eric
//https://spapi.dev/api/episodes?page=
