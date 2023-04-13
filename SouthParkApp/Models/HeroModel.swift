//
//  heroModel.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 05.04.2023.
//

import Foundation

struct DataHero: Decodable {
    let data: [DataHero1]?
}
struct DataHero1: Decodable {
    
    let id: Int?
      let name: String?
      let age: Int?
      let hair_color: String?
      let sex: String?
      let occupation: String?
      let religion: String?
  }

