//
//  MovieListViewModel.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

class MovieListViewModel{
    private var movieListUseCase : GetMoviesListUseCaseProtocol
    
    var movies: [Movie] = []
    var reloadCV : (()->Void) = {}
    var showError : ((String)->Void) = {error in}
    init() {
        self.movieListUseCase = GetMoviesListUseCase()
    }
    
    func getMoviesList(for category: MoviesEndpoints){
        movieListUseCase.execute(categoryEndpoint: category.rawValue) { result in
            switch result{
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.reloadCV()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error.localizedDescription)
                }
            }
        }
    }
}
