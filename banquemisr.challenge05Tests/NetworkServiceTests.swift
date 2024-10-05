//
//  NetworkServiceTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import XCTest
@testable import banquemisr_challenge05

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkServiceProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.networkService = NetworkService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.networkService = nil
    }
    
    func testFetchDataSuccess() {
        guard let url = APIUrls.getMovies(for: "now_playing") else {
            XCTFail("Invalid URL")
            return
        }
        
        let expectation = self.expectation(description: "FetchData")
        
        networkService.fetchData(url: url, model: MovieAPIResponse.self) { result in
            switch result {
            case .success(let movies):
                XCTAssertGreaterThan(movies.results.count, 0)
                XCTAssertNotNil(movies.results.first?.title)
                XCTAssertNotNil(movies.results.first?.posterPath)
                XCTAssertNotNil(movies.results.first?.releaseDate)
            case .failure(_):
                XCTFail(ErrorMessage.noData.rawValue)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchDataFailure() {
        guard let url = APIUrls.getMovies(for: "invalidEndpoint") else {
            XCTFail("Invalid URL")
            return
        }
        
        let expectation = self.expectation(description: "FetchDataFailure")
        
        networkService.fetchData(url: url, model: MovieAPIResponse.self) { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error, ErrorMessage.invalidResponse)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    
    func testFetchMovieImageSuccess() {
        guard let url = APIUrls.getImage(imagePath: "/aciP8Km0waTLXEYf5ybFK5CSUxl.jpg") else {
                XCTFail("Invalid URL")
                return
            }

            let expectation = self.expectation(description: "FetchImage")

            networkService.fetchMovieImage(url: url) { result in
                switch result {
                case .success(let data):
                    XCTAssertGreaterThan(data.count, 0)
                case .failure(let error):
                    XCTFail("Failed with error: \(error)")
                }
                expectation.fulfill()
            }

            waitForExpectations(timeout: 5.0, handler: nil)
        }

}
