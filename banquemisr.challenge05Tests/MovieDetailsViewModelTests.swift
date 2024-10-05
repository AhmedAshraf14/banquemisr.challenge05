//
//  MovieDetailsViewModelTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import XCTest
@testable import banquemisr_challenge05
final class MovieDetailsViewModelTests: XCTestCase {
    
    var viewModel : MovieDetailsViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = MovieDetailsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testGetMovieDetailsSuccess() {
        let expectation = self.expectation(description: "Fetching Movie Details")
        let movieID = 889737
        viewModel.movieID = movieID
        
        viewModel.renderPage = {
            XCTAssertNotNil(self.viewModel.movie)
            XCTAssertEqual(self.viewModel.movie.id, movieID)
            expectation.fulfill()
        }
        viewModel.getMovieDetails()
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetMovieDetailsFailure() {
            let expectation = self.expectation(description: "Fetching Movie Details with Failure")
            let invalidMovieID = -1

            viewModel.movieID = invalidMovieID
            
            viewModel.showError = { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            viewModel.getMovieDetails()

            waitForExpectations(timeout: 10.0, handler: nil)
        }
    
    func testDownloadImageSuccess() {
           let expectation = self.expectation(description: "Downloading Image")
           let imagePath = "/aciP8Km0waTLXEYf5ybFK5CSUxl.jpg"

           viewModel.downloadImage(path: imagePath) { imageData in
               XCTAssertNotNil(imageData)
               expectation.fulfill()
           }
           
           waitForExpectations(timeout: 10.0, handler: nil)
       }
    
    func testSetGenres() {
            let expectedGenres = ["Action", "Adventure"]
        viewModel.movie = MovieDetails(id: 1, title: "MovieTitle", releaseDate: "2024-08-27", overview: "overview", genres: expectedGenres.map { Genre(id: 1, name: $0) }, runtime: 120, posterPath: "path.jpg", backdropPath: "path.jpg", rate: 5.8, homepage: "")

            let result = viewModel.setGenres()

            XCTAssertEqual(result, "Action, Adventure")
        }

        func testGetWebsiteUrl() {
            let websiteUrl = "https://www.example.com"
            viewModel.movie = MovieDetails(id: 1, title: "MovieTitle", releaseDate: "2024-08-27", overview: "overview", genres: [], runtime: 120, posterPath: "path.jpg", backdropPath: "path.jpg", rate: 5.8, homepage: websiteUrl)

            let url = viewModel.getWebsiteUrl()

            XCTAssertNotNil(url)
            XCTAssertEqual(url?.absoluteString, websiteUrl)
        }

        func testGetWebsiteUrlNil() {
            viewModel.movie = MovieDetails(id: 1, title: "MovieTitle", releaseDate: "2024-08-27", overview: "overview", genres: [], runtime: 120, posterPath: "path.jpg", backdropPath: "path.jpg", rate: 5.8, homepage: "")

            let url = viewModel.getWebsiteUrl()

            XCTAssertNil(url)
        }


}
