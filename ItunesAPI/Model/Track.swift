//
//  Track.swift
//  ItunesAPI
//
//  Created by Alexey on 29.03.21.
//

import Foundation

struct Track: Decodable {
    let artistName: String?
    let trackName: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case image = "artworkUrl100"
    }
}
