//
//  testMethod.swift
//  SouthParkApp
//
//  Created by Макар Тюрморезов on 28.03.2023.
//

import Foundation

struct SouthParkCharacter {
    var name: String
    var subName: String
    
    var fullName: String {
        "\(name) \(subName)"
    }
}

extension SouthParkCharacter {
    static func getFullName() -> [SouthParkCharacter] {
        return [
            SouthParkCharacter(name: "Kyle", subName: "Broflovski"),
            SouthParkCharacter(name: "Kennie", subName: "McCormick"),
            SouthParkCharacter(name: "Eric", subName: "Cartman"),
            SouthParkCharacter(name: "Stan", subName: "Marsh"),
            SouthParkCharacter(name: "Butters", subName: "Stotch")
        ]
    }
}
