//
//  CoreDataManagerTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import XCTest
@testable import banquemisr_challenge05

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager : CoreDataManagerProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataManager = CoreDataManager.shared
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        coreDataManager = nil
    }
    
    func testSaveMovies() {
        let movies = [
            Movie(id: 1, title: "Movie 1", posterPath: "path1", releaseDate: "2024-01-01"),
        ]
        
        coreDataManager.saveMovies(movies: movies, category: "popular")
        
        let fetchedMovies = coreDataManager.fetchMovies(for: "popular")
        XCTAssertEqual(fetchedMovies.count, 1)
        XCTAssertEqual(fetchedMovies[0].title, "Movie 1")
    }
    
    func testDeleteMovies() {
        let movies = [
            Movie(id: 1, title: "Movie 1", posterPath: "path1", releaseDate: "2024-01-01"),
        ]
        
        coreDataManager.saveMovies(movies: movies, category: "popular")
        coreDataManager.deleteMovies(in: "popular")
        
        let fetchedMovies = coreDataManager.fetchMovies(for: "popular")
        XCTAssertEqual(fetchedMovies.count, 0)
    }
    
    func testFetchMovieDetails() {
        let movieDetails = MovieDetails(
            id: 1,
            title: "Movie 1",
            releaseDate: "2024-01-01",
            overview: "Overview",
            genres: [],
            runtime: 120,
            posterPath: "path1",
            backdropPath: "backdropPath",
            rate: 8.0,
            homepage: "homepage"
        )
        
        coreDataManager.saveMovieDetails(movie: movieDetails)
        
        let fetchedMovieDetails = coreDataManager.fetchMovieDetails(withId: 1)
        XCTAssertNotNil(fetchedMovieDetails)
        XCTAssertEqual(fetchedMovieDetails?.title, "Movie 1")
    }
    
    func testSaveMovieDetails() {
        let movieDetails = MovieDetails(
            id: 1,
            title: "Movie 1",
            releaseDate: "2024-01-01",
            overview: "Overview",
            genres: [],
            runtime: 120,
            posterPath: "path1",
            backdropPath: "backdropPath",
            rate: 8.0,
            homepage: "homepage"
        )
        
        coreDataManager.saveMovieDetails(movie: movieDetails)
        
        let fetchedMovieDetails = coreDataManager.fetchMovieDetails(withId: movieDetails.id)
        
        XCTAssertNotNil(fetchedMovieDetails)
        XCTAssertEqual(fetchedMovieDetails?.title, movieDetails.title)
        XCTAssertEqual(fetchedMovieDetails?.releaseDate, movieDetails.releaseDate)
        XCTAssertEqual(fetchedMovieDetails?.overview, movieDetails.overview)
        XCTAssertEqual(fetchedMovieDetails?.runtime, movieDetails.runtime)
        XCTAssertEqual(fetchedMovieDetails?.rate, movieDetails.rate)
    }
    
}
