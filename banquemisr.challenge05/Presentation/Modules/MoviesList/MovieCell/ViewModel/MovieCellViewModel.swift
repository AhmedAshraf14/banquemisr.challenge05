//
//  MovieCellViewModel.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

class MovieCellViewModel{
    var movie : Movie?
    var putImage : ((Data)->Void) = {imageData in}
    private var movieImageUseCase : GetMovieImageUseCaseProtocol
    
    init() {
        self.movieImageUseCase = GetMovieImageUseCase()
    }
    
    func downloadImage(){
        guard let movie = movie else {
            return
        }
        movieImageUseCase.execute(imagePath: movie.posterPath) { result in
            
            switch result{
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.putImage(imageData)
                }
            case .failure(_):
                break
            }
        }
    }
    
}
