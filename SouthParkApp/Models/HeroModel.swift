//
//  heroModel.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 05.04.2023.
//

import Foundation

struct HeroData: Decodable {
    var dataHero: [DataHero]?
}
struct DataHero: Decodable {
    
    var name: String?
    var age: Int?
    var sex: String
    var hair_color: String?
    var occupation: String?
    var religion: String?
}
