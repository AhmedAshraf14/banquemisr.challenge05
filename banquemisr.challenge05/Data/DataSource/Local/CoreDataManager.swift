//
//  CoreDataManager.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol{
    func saveMovies(movies: [Movie], category: MoviesEndpoints.RawValue)
    func fetchMovies(for category: MoviesEndpoints.RawValue) -> [Movie]
    func deleteMovies(in category: MoviesEndpoints.RawValue)
    func saveMovieDetails(movie: MovieDetails)
    func fetchMovieDetails(withId id: Int) -> MovieDetails?
}

class CoreDataManager: CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    
    let appDelegate: AppDelegate
    let managedContext: NSManagedObjectContext
    
    private init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    private func saveContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func saveMovies(movies: [Movie], category: MoviesEndpoints.RawValue) {
        deleteMovies(in: category)
        for movie in movies {
            let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext)
            let movieObject = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            movieObject.setValue(movie.id, forKey: "id")
            movieObject.setValue(movie.title, forKey: "title")
            movieObject.setValue(movie.posterPath, forKey: "posterPath")
            movieObject.setValue(movie.releaseDate, forKey: "releaseDate")
            movieObject.setValue(category, forKey: "category")
        }
        saveContext()
    }
    
    
    func fetchMovies(for category: MoviesEndpoints.RawValue) -> [Movie] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        var movies: [Movie] = []
        do {
            let movieObjects = try managedContext.fetch(fetchRequest)
            for movieObject in movieObjects {
                let movie = Movie(
                    id: movieObject.value(forKey: "id") as! Int,
                    title: movieObject.value(forKey: "title") as! String,
                    posterPath: movieObject.value(forKey: "posterPath") as! String,
                    releaseDate: movieObject.value(forKey: "releaseDate") as! String
                )
                movies.append(movie)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return movies
    }
    
    func deleteMovies(in category: MoviesEndpoints.RawValue) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(batchDeleteRequest)
            saveContext()
        } catch let error as NSError {
            print("Error deleting movies: \(error.localizedDescription)")
        }
    }

    
    
//    func deleteMovies(in category: MoviesEndpoints.RawValue) {
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
//        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
//        
//        do {
//            let moviesToDelete = try managedContext.fetch(fetchRequest) as! [MovieEntity]
//            
//            for movie in moviesToDelete {
//                managedContext.delete(movie)
//            }
//            
//            saveContext()
//        } catch let error as NSError {
//            print("Error deleting movies: \(error.localizedDescription)")
//        }
//    }
    
    func saveMovieDetails(movie: MovieDetails) {
        if let _ = fetchMovieDetails(withId: movie.id){
            return
        }
        let entity = NSEntityDescription.entity(forEntityName: "MovieDetailsEntity", in: managedContext)
        let movieDetailsEntity = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        movieDetailsEntity.setValue(movie.id, forKey: "id")
        movieDetailsEntity.setValue(movie.title, forKey: "title")
        movieDetailsEntity.setValue(movie.releaseDate, forKey: "releaseDate")
        movieDetailsEntity.setValue(movie.overview, forKey: "overview")
        movieDetailsEntity.setValue(movie.runtime, forKey: "runtime")
        movieDetailsEntity.setValue(movie.posterPath, forKey: "posterPath")
        movieDetailsEntity.setValue(movie.backdropPath, forKey: "backdropPath")
        movieDetailsEntity.setValue(movie.budget, forKey: "budget")
        movieDetailsEntity.setValue(movie.rate, forKey: "rate")
        movieDetailsEntity.setValue(movie.homepage, forKey: "homepage")
        
        let genreEntities = movie.genres.map { genre -> NSManagedObject in
            let genreEntity = NSEntityDescription.insertNewObject(forEntityName: "GenreEntity", into: managedContext)
            genreEntity.setValue(Int64(genre.id), forKey: "id")
            genreEntity.setValue(genre.name, forKey: "name")
            return genreEntity
        }
        let genreSet = NSSet(array: genreEntities)
        movieDetailsEntity.setValue(genreSet, forKey: "genres")
        
        saveContext()
    }
    
    func fetchMovieDetails(withId id: Int) -> MovieDetails? {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieDetailsEntity")
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                let fetchedResults = try managedContext.fetch(fetchRequest)
                if let movieEntity = fetchedResults.first {
                    return convertToMovieDetails(movieDetailsEntity: movieEntity)
                }
            } catch let error as NSError {
                print("Failed to fetch movie details: \(error), \(error.userInfo)")
            }
            
            return nil
        }
    
    private func convertToMovieDetails(movieDetailsEntity: NSManagedObject) -> MovieDetails {
        let id = movieDetailsEntity.value(forKey: "id") as! Int
        let title = movieDetailsEntity.value(forKey: "title") as! String
        let releaseDate = movieDetailsEntity.value(forKey: "releaseDate") as! String
        let overview = movieDetailsEntity.value(forKey: "overview") as! String
        let runtime = movieDetailsEntity.value(forKey: "runtime") as! Int
        let posterPath = movieDetailsEntity.value(forKey: "posterPath") as? String
        let backdropPath = movieDetailsEntity.value(forKey: "backdropPath") as? String
        let budget = movieDetailsEntity.value(forKey: "budget") as! UInt64
        let rate = movieDetailsEntity.value(forKey: "rate") as! Double
        let homepage = movieDetailsEntity.value(forKey: "homepage") as? String
        
        let genreEntities = movieDetailsEntity.value(forKey: "genres") as! Set<NSManagedObject>
        let genres = genreEntities.map { genreEntity -> Genre in
            let genreId = genreEntity.value(forKey: "id") as! Int
            let genreName = genreEntity.value(forKey: "name") as! String
            return Genre(id: genreId, name: genreName)
        }
        
        return MovieDetails(
            id: id,
            title: title,
            releaseDate: releaseDate,
            overview: overview,
            genres: genres,
            runtime: runtime,
            posterPath: posterPath,
            backdropPath: backdropPath,
            budget: budget,
            rate: rate,
            homepage: homepage
        )
    }

    
    
    
}
