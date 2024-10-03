//
//  Movie.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

struct MovieAPIResponse: Codable{
    let results : [Movie]
}

struct Movie: Codable{
    let id : Int
    let title, posterPath, releaseDate : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
