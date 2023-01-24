//
//  GameDetailModel.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 24.01.2023.
//

import Foundation

struct GameDetailModel: Decodable {
    let id: Int?
    let tba: Bool?
    let name: String?
    let released: String?
    let description: String?
    let metacritic: Int?
    let rating: EsrbRating?
    let parentPlatforms: [ParentPlatform]?
    let developers: [Developer]?
    let publishers: [Publisher]?
    let genres: [Genre]?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case tba
        case name
        case released
        case description = "description_raw"
        case metacritic
        case developers
        case publishers
        case genres
        case rating = "esrb_rating"
        case parentPlatforms = "parent_platforms"
        case imageWide = "background_image"
    }
    
    init(id: Int) {
        self.id = id
        self.tba = nil
        self.name = nil
        self.released = nil
        self.description = nil
        self.metacritic = nil
        self.rating = nil
        self.parentPlatforms = nil
        self.developers = nil
        self.publishers = nil
        self.genres = nil
        self.imageWide = nil
    }
}

struct EsrbRating: Decodable{
    let id: Int?
    let name: String?
    let slug: String?
}


struct ParentPlatform: Decodable{
    let platform: Platform?
}

struct Platform: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct Developer: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gameCount: Int?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gameCount = "games_count"
        case imageWide = "background_image"
    }
}

struct Publisher: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gameCount: Int?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gameCount = "games_count"
        case imageWide = "background_image"
    }
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gameCount: Int?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gameCount = "games_count"
        case imageWide = "background_image"
    }
}
