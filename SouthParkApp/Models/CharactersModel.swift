//
//  CharactersModel.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 28.03.2023.
//

import Foundation

struct DataPark: Decodable {
    var data: [Data]?
}

struct Data: Decodable {
    
    var id: Int?
    var name: String?
    var season: Int?
    var episode: Int?
    var air_date: String?
    var thumbnail_url: String?
    var description: String?
    var characters: [String?]
}
