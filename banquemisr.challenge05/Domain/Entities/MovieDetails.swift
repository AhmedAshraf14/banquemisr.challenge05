//
//  MovieDetails.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

struct MovieDetails: Codable{
    let id: Int
    let title, releaseDate, overview: String
    let genres: [Genre]
    let runtime: Int
    let posterPath, backdropPath: String?
    let productionCompanies : [ProductionCompany]?
    let budget : UInt64
    let rate : Double
    let homepage : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case genres
        case runtime
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case productionCompanies = "production_companies"
        case budget
        case rate = "vote_average"
        case homepage 
    }
}
