//
//  MovieRepositoryImpl.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

class MovieRepositoryImpl:MovieRepository{
    
    
    
    private let networkService : NetworkServiceProtocol
    private let coreDataManager : CoreDataManagerProtocol
    
    init(networkService: NetworkServiceProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }

    init() {
        self.networkService = NetworkService()
        self.coreDataManager = CoreDataManager.shared
    }
    
    func getMoviesList(categoryEndpoint: MoviesEndpoints.RawValue, completion: @escaping (Result<[Movie], ErrorMessage>) -> Void) {
        
        Connectivity.shared.checkConnectivity { [weak self] isConnected in
            if isConnected{
                guard let url = APIUrls.getMovies(for: categoryEndpoint) else {
                    completion(.failure(ErrorMessage.invalidURL))
                    return
                }
                
                self?.networkService.fetchData(url: url, model: MovieAPIResponse.self) { result in
                    switch result{
                    case .success(let moviesList):
                        self?.coreDataManager.saveMovies(movies: moviesList.results, category: categoryEndpoint)
                        completion(.success(moviesList.results))
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            }else {
                let movies = self?.coreDataManager.fetchMovies(for: categoryEndpoint)
                if movies?.count == 0 {
                    completion(.failure(ErrorMessage.noData))
                } else {
                    completion(.success(movies ?? []))
                }
            }
        }
        
    }
    
    func getMoviesDetails(movieID: Int, completion: @escaping (Result<MovieDetails, ErrorMessage>) -> Void) {
        
        Connectivity.shared.checkConnectivity { [weak self] isConnected in
            if isConnected{
                guard let url = APIUrls.getMovieDetails(for: movieID) else {
                    completion(.failure(ErrorMessage.invalidURL))
                    return
                }
                
                self?.networkService.fetchData(url: url, model: MovieDetails.self) { result in
                    switch result{
                    case .success(let movie):
                        self?.coreDataManager.saveMovieDetails(movie: movie)
                        completion(.success(movie))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }else{
                if let movie = self?.coreDataManager.fetchMovieDetails(withId: movieID){
                    completion(.success(movie))
                }else{
                    completion(.failure(ErrorMessage.noData))
                }
            }
        }
        
    }
    
    func getMovieImage(imagePath: String, completion: @escaping (Result<Data, ErrorMessage>) -> Void) {
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
