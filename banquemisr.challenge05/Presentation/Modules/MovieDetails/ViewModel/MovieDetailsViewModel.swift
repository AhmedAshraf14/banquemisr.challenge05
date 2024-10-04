//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 04/10/2024.
//

import Foundation

class MovieDetailsViewModel{
    private var movieDetailsUseCase : GetMovieDetailsUseCaseProtocol
    private var movieImageUseCase : GetMovieImageUseCaseProtocol
    var movieID : Int?
    var movie : MovieDetails!
    var renderPage : (()->Void) = {}
    var putImage : ((Data)->Void) = {imageData in}
    var showError : ((String)->Void) = {error in}
    init() {
        self.movieDetailsUseCase = GetMovieDetailsUseCase()
        self.movieImageUseCase = GetMovieImageUseCase()
    }
    
    func getMovieDetails(){
        guard let movieID = movieID else {return}
        movieDetailsUseCase.execute(movieID: movieID) { result in
            switch result{
            case .success(let movie):
                self.movie = movie
                DispatchQueue.main.async{
                    self.renderPage()
                }
            case .failure(let error):
                DispatchQueue.main.async{
                    self.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func downloadImage(path: String, completion: @escaping (Data) -> Void){
        movieImageUseCase.execute(imagePath: path) { result in
            switch result{
            case .success(let imageData):
                completion(imageData)
            case .failure(_):
                break
            }
        }
    }
    
    func setGenres() -> String {
        let genreNames = movie.genres.map { $0.name }
        let concatenatedNames = genreNames.joined(separator: ", ")
        return concatenatedNames
    }
    
    func getWebsiteUrl()->URL?{
        if let urlString = movie.homepage{
            return URL(string: urlString)
        }else{
            return nil
        }
    }
}
