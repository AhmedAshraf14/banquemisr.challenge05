//
//  MovieRepositoryImpl.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

class MovieRepositoryImpl:MovieRepository{
    
    private let networkService : NetworkServiceProtocol
    
    init() {
        self.networkService = NetworkService()
    }
    
    func getMoviesList(categoryEndpoint: MoviesEndpoints, completion: @escaping (Result<MovieAPIResponse, Error>) -> Void) {
        guard let url = APIUrls.getMovies(for: categoryEndpoint) else {
            completion(.failure(ErrorMessage.invalidURL))
            return
        }
        
        networkService.fetchData(url: url, model: MovieAPIResponse.self) { result in
            switch result{
            case .success(let moviesList):
                completion(.success(moviesList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getMoviesDetails(movieID: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        guard let url = APIUrls.getMovieDetails(for: movieID) else {
            completion(.failure(ErrorMessage.invalidURL))
            return
        }
        
        networkService.fetchData(url: url, model: MovieDetails.self) { result in
            switch result{
            case .success(let movie):
                completion(.success(movie))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieImage(imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = APIUrls.getImage(imagePath: imagePath) else {
            completion(.failure(ErrorMessage.invalidURL))
            return
        }
        
        networkService.fetchMovieImage(url: url) { result in
            switch result{
            case .success(let imageData):
                completion(.success(imageData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
