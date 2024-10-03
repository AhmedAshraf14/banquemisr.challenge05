//
//  MovieRepository.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

protocol MovieRepository {
    func getMoviesList(categoryEndpoint: MoviesEndpoints, completion: @escaping (Result<MovieAPIResponse,Error>)->Void)
    func getMoviesDetails(movieID: Int, completion: @escaping (Result<MovieDetails,Error>)->Void)
    func getMovieImage(imagePath: String, completion: @escaping (Result<Data,Error>)->Void)
}
