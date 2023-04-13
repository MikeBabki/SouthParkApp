//
//  CharacterIdModel.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 10.04.2023.
//

import Foundation
import UIKit

struct DataId: Decodable {
    var data: [DataIdCharacters]?
}
struct DataIdCharacters: Decodable {
    
    let id: Int?
    let name: String
    let age: Int?
    let hair_color: String?
    let sex: String?
    let occupation: String?
    let religion: String?
    var image: String {
        return name
    }
}




