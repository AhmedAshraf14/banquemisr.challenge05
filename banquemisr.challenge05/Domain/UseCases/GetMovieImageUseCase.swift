//
//  GetMovieImageUseCase.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

protocol GetMovieImageUseCaseProtocol {
    func execute(imagePath: String, completion: @escaping (Result<Data, ErrorMessage>) -> Void)
}

class GetMovieImageUseCase: GetMovieImageUseCaseProtocol{
    private let movieRepository: MovieRepository
    
    init() {
        self.movieRepository = MovieRepositoryImpl()
    }
    
    func execute(imagePath: String, completion: @escaping (Result<Data, ErrorMessage>) -> Void) {
        movieRepository.getMovieImage(imagePath: imagePath) { result in
            completion(result)
        }
    }
}
