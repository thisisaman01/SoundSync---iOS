//
//  Music.swift
//  SoundSync
//
//  Created by AMAN K.A on 25/11/23.
//

import Foundation

struct Music: Codable {
    let data: [Track]
}

struct Track: Codable {
    let id: Int
    let status: String
    let userCreated: String
    let dateCreated: String
    let userUpdated: String
    let dateUpdated: String
    let name: String
    let artist: String
    let accent: String
    let cover: String
    let topTrack: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, status, name, artist, accent, cover, url
        case userCreated = "user_created"
        case dateCreated = "date_created"
        case userUpdated = "user_updated"
        case dateUpdated = "date_updated"
        case topTrack = "top_track"
    }
}


