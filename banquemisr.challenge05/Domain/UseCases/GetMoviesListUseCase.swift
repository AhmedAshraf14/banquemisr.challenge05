//
//  getMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

protocol GetMoviesListUseCaseProtocol {
    func execute(categoryEndpoint: MoviesEndpoints, completion: @escaping (Result<MovieAPIResponse, Error>) -> Void)
}

class GetMoviesListUseCase: GetMoviesListUseCaseProtocol{
    private let movieRepository: MovieRepository
        
    init() {
        self.movieRepository = MovieRepositoryImpl()
    }
    
    func execute(categoryEndpoint: MoviesEndpoints, completion: @escaping (Result<MovieAPIResponse, Error>) -> Void) {
        movieRepository.getMoviesList(categoryEndpoint: categoryEndpoint) { result in
            completion(result)
        }
    }
}
