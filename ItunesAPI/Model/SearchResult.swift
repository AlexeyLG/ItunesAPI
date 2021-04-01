//
//  SearchResult.swift
//  ItunesAPI
//
//  Created by Alexey on 29.03.21.
//

import Foundation

struct SearchResults: Decodable {
    let count: Int?
    let track: [Track]
    
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case track = "results"
    }
}
