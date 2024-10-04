//
//  MovieDetailsVC.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 04/10/2024.
//

import UIKit

class MovieDetailsVC: UIViewController {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UITextView!
    @IBOutlet weak var movieRateLabel: UILabel!
    
    var viewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backdropImageView.layer.cornerRadius = 10
        posterImageView.layer.cornerRadius = 20
        posterImageView.layer.borderWidth = 1
        posterImageView.layer.borderColor = UIColor.shapesGrey.cgColor
        viewModel.getMovieDetails()
        viewModel.renderPage = {
            self.movieTitleLabel.text = self.viewModel.movie.title
            let movieReleaseYear = self.viewModel.movie.releaseDate
            self.movieReleaseDateLabel.text = String(movieReleaseYear.prefix(4))
            self.movieRuntimeLabel.text = String(self.viewModel.movie.runtime) + " Minutes"
            self.movieGenresLabel.text = self.viewModel.setGenres()
            self.movieOverviewLabel.text = self.viewModel.movie.overview
            self.movieRateLabel.text = String(format: "%.1f", self.viewModel.movie.rate)
            
            if let backdropPath = self.viewModel.movie.backdropPath {
                self.viewModel.downloadImage(path: backdropPath) { imageData in
                    DispatchQueue.main.async {
                        self.backdropImageView.image = UIImage(data: imageData)
                    }
                }
            }
            
            if let posterPath = self.viewModel.movie.posterPath {
                self.viewModel.downloadImage(path: posterPath) { imageData in
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
    }
    
    
}
