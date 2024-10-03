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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    private func configureCell(){
        movieImage.layer.cornerRadius = 30
    }
    
    func setupCell(){
        viewModel.putImage = { imageData in
            self.movieImage.image = UIImage(data: imageData)
        }
        movieTitleLabel.text = viewModel.movie?.title
        if let movieReleaseDate = viewModel.movie?.releaseDate{
            movieReleaseDateLabel.text = String(movieReleaseDate.prefix(4))
        }
        viewModel.downloadImage()
        
    }

}
