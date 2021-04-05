//
//  Generations.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation

struct Generations: Decodable {
    var count: Int?
    var results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case results = "results"
    }
}

struct Result: Codable {
    let name: String
    let url: String
}
