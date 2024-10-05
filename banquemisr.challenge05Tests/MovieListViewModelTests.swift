//
//  MovieListViewModel.swift
//  banquemisr.challenge05Tests
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import XCTest
@testable import banquemisr_challenge05
final class MovieListViewModelTests: XCTestCase {

    var viewModel : MovieListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = MovieListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testGetMoviesListSuccess() {
            let expectation = self.expectation(description: "Fetching Movies List")
            let category = MoviesEndpoints.popular

            viewModel.reloadCV = {
                XCTAssertFalse(self.viewModel.movies.isEmpty)
                expectation.fulfill()
            }

            viewModel.getMoviesList(for: category)
            waitForExpectations(timeout: 10.0, handler: nil)
        }
    
    func testGetMoviesListFailure() {
            let expectation = self.expectation(description: "Fetching Movies List with Failure")
            let category = MoviesEndpoints.invalid
            
        viewModel.showError = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
            viewModel.getMoviesList(for: category)

            waitForExpectations(timeout: 10.0, handler: nil)
        }

}
