//
//  APIUrls.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

struct APIUrls{
    static let apiKey = "95a89943de5af0ccb83f6a10a3c30c21"
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/"
    static let posterSize = "w500"
        
    static func getMovies(for categoryEndpoint: MoviesEndpoints.RawValue) -> URL? {
        return URL(string: "\(baseURL)\(categoryEndpoint)?api_key=\(apiKey)")
    }
        
    static func getMovieDetails(for movieId: Int) -> URL? {
        return URL(string: "\(baseURL)\(movieId)?api_key=\(apiKey)")
    }
    
    static func getImage(imagePath: String) -> URL? {
        return URL(string: "\(imageBaseUrl)\(posterSize)\(imagePath)")
    }
}
