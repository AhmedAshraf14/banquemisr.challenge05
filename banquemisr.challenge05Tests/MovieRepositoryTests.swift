//
//  MovieRepositoryTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import XCTest
@testable import banquemisr_challenge05
final class MovieRepositoryTests: XCTestCase {
//    var networkService : NetworkServiceProtocol!
//    var coreDataManager : CoreDataManagerProtocol!
    
    var repository : MovieRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        self.networkService = NetworkService()
//        self.coreDataManager = CoreDataManager.shared
        repository = MovieRepositoryImpl(networkService: NetworkService(), coreDataManager: CoreDataManager.shared)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        self.networkService = nil
//        self.coreDataManager = nil
        repository = nil
    }
    
    func testGetMoviesListWithNetworkSuccess() {
            // Given
            let expectation = self.expectation(description: "Fetching Movies List")
            
            // When
            repository.getMoviesList(categoryEndpoint: "popular") { result in
                // Then
                switch result {
                case .success(let movies):
                    XCTAssertTrue(!movies.isEmpty) // Check that movies are returned
                    XCTAssertNotNil(movies[0].title) // Ensure the title is not nil
                case .failure(let error):
                    XCTFail("Expected success, but got failure: \(error)")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10.0, handler: nil)
        }


}
