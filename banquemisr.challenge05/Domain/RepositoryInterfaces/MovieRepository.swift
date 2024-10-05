//
//  MovieRepository.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

protocol MovieRepository {
    func getMoviesList(categoryEndpoint: MoviesEndpoints.RawValue, completion: @escaping (Result<[Movie],ErrorMessage>)->Void)
    func getMoviesDetails(movieID: Int, completion: @escaping (Result<MovieDetails,ErrorMessage>)->Void)
    func getMovieImage(imagePath: String, completion: @escaping (Result<Data,ErrorMessage>)->Void)
}
