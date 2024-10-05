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
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var noDataView: UIView!
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var viewModel : MovieDetailsViewModel!
    
    required init?(coder: NSCoder) {
        self.viewModel = MovieDetailsViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    private func setupUI(){
        self.activityIndicator.setup(in: view)
        self.activityIndicator.show()
        rateView.layer.cornerRadius = 12
        rateView.backgroundColor = rateView.backgroundColor?.withAlphaComponent(0.8)
        websiteButton.layer.cornerRadius = 12
        backdropImageView.layer.cornerRadius = 10
        posterImageView.layer.cornerRadius = 20
        posterImageView.layer.borderWidth = 1
        posterImageView.layer.borderColor = UIColor.shapesGrey.cgColor
    }
    
    private func setupViewModel(){
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
                        if let imageData = imageData {
                            self.backdropImageView.image = UIImage(data: imageData)
                        }else{
                            self.backdropImageView.image = UIImage(named: "no-pictures")
                        }
                    }
                }
            }
            
            if let posterPath = self.viewModel.movie.posterPath {
                self.viewModel.downloadImage(path: posterPath) { imageData in
                    DispatchQueue.main.async {
                        if let imageData = imageData {
                            self.posterImageView.image = UIImage(data: imageData)
                        }else{
                            self.posterImageView.image = UIImage(named: "no-pictures")
                        }
                    }
                }
            }
            self.activityIndicator.hide()
        }
        
        viewModel.showError = { [weak self] error in
            self?.noDataView.isHidden = false
            self?.presentAlert(title: "Check Network", message: error, buttonTitle: "OK")
            self?.activityIndicator.hide()
        }
    }
    
    
    @IBAction func websiteButtonTapped(_ sender: UIButton) {
        navigateToSafari()
    }
    
    private func navigateToSafari() {
        if let url = self.viewModel.getWebsiteUrl(){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else {
            self.presentAlert(title: "Warning", message: "Sorry no website for this movie", buttonTitle: "OK")
        }
    }
    
    
}
