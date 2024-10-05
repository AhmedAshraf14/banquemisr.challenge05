//
//  NetworkMockTest.swift
//  banquemisr.challenge05Tests
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import XCTest
@testable import banquemisr_challenge05

final class NetworkMockTest: XCTestCase {

    var networkService: MockNetworkService!

    override func setUpWithError() throws {
        networkService = MockNetworkService()
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testFetchDataSuccess() {
        let jsonResponse = """
        {
            "results": [
                {
                    "id": 1,
                    "title": "Movie Title",
                    "poster_path": "/path/to/poster.jpg",
                    "release_date": "2024-10-05"
                }
            ]
        }
        """
        let mockData = jsonResponse.data(using: .utf8)
        networkService.mockData = mockData

        let expectation = self.expectation(description: "FetchDataSuccess")

        // When
        networkService.fetchData(url: URL(string: "http://test.com")!, model: MovieAPIResponse.self) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.results.count, 1)
                XCTAssertEqual(response.results.first?.title, "Movie Title")
                XCTAssertEqual(response.results.first?.id, 1)
                XCTAssertEqual(response.results.first?.posterPath, "/path/to/poster.jpg")
                XCTAssertEqual(response.results.first?.releaseDate, "2024-10-05")
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchDataFailure() {
        networkService.shouldReturnError = true

        let expectation = self.expectation(description: "FetchDataFailure")

        networkService.fetchData(url: URL(string: "http://test.com")!, model: MovieAPIResponse.self) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error, ErrorMessage.invalidResponse)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchMovieImageSuccess() {
        let mockImageData = Data(repeating: 0, count: 100) // Dummy image data
        networkService.mockData = mockImageData

        let expectation = self.expectation(description: "FetchMovieImageSuccess")

        networkService.fetchMovieImage(url: URL(string: "http://test.com/image")!) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 100)
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchMovieImageFailure() {
        networkService.shouldReturnError = true

        let expectation = self.expectation(description: "FetchMovieImageFailure")

        networkService.fetchMovieImage(url: URL(string: "http://test.com/image")!) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error, ErrorMessage.networkError)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
