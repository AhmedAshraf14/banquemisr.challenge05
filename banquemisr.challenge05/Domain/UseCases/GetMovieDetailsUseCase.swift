//
//  getMovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

protocol GetMovieDetailsUseCaseProtocol {
    func execute(movieID: Int, completion: @escaping (Result<MovieDetails, ErrorMessage>) -> Void)
}

class GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol{
    private let movieRepository: MovieRepository
        
    init() {
        self.movieRepository = MovieRepositoryImpl()
    }
    
    func execute(movieID: Int, completion: @escaping (Result<MovieDetails, ErrorMessage>) -> Void) {
        movieRepository.getMoviesDetails(movieID: movieID) { result in
            completion(result)
        }
    }
}
