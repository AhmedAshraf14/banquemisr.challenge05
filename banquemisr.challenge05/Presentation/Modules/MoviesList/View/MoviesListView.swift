//
//  MoviesListView.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MoviesListView: UICollectionViewController {
    
    var viewModel : MovieListViewModel!
    
    required init?(coder: NSCoder) {
        self.viewModel = MovieListViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
    }
    
    private func setupViewModel(){
        switch self.tabBarController?.tabBar.selectedItem?.tag{
        case 1:
            self.viewModel.getMoviesList(for: .nowPlaying)
            self.tabBarController?.title = "Now Playing"
        case 2:
            self.viewModel.getMoviesList(for: .popular)
            self.tabBarController?.title = "Popular"
        case 3:
            self.viewModel.getMoviesList(for: .upcoming)
            self.tabBarController?.title = "Upcoming"
        default :
            self.viewModel.getMoviesList(for: .nowPlaying)
            self.tabBarController?.title = "Now Playing"
        }
        
        viewModel.reloadCV = {
            self.collectionView.reloadData()
        }
        
        viewModel.showError = { error in
            self.presentAlert(title: "Error", message: error, buttonTitle: "OK")
        }
    }
    
    func setupFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth = (view.bounds.width - 20) / 2
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth+120)
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.viewModel.movie = viewModel.movies[indexPath.row]
        cell.setupCell()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        movieDetailVC.viewModel.movieID = viewModel.movies[indexPath.item].id
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    
}
