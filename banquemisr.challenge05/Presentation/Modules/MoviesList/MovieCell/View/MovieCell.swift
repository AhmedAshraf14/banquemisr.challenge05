//
//  MovieCell.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    var viewModel = MovieCellViewModel()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
        activityIndicator.setup(in: self)
        activityIndicator.show()
    }
    
    private func configureCell(){
        movieImage.layer.cornerRadius = 30
        movieImage.layer.borderWidth = 1
        movieImage.layer.borderColor = UIColor.shapesGrey.cgColor
    }
    
    func setupCell(){
        viewModel.putImage = { imageData in
            if let imageData = imageData {
                self.movieImage.image = UIImage(data: imageData)
            }else{
                self.movieImage.image = UIImage(named: "no-pictures")
            }
            self.activityIndicator.hide()
        }
        movieTitleLabel.text = viewModel.movie?.title
        if let movieReleaseDate = viewModel.movie?.releaseDate{
            movieReleaseDateLabel.text = String(movieReleaseDate.prefix(4))
        }
        viewModel.downloadImage()
        
    }

}
