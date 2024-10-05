//
//  MockURLSession.swift
//  banquemisr.challenge05Tests
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import Foundation
@testable import banquemisr_challenge05

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError: Bool = false
    var mockData: Data?

    func fetchData<T: Codable>(url: URL, model: T.Type, completion: @escaping (Result<T, ErrorMessage>) -> Void) {
        if shouldReturnError {
            completion(.failure(ErrorMessage.invalidResponse))
        } else if let data = mockData, let resultData = DataDecoder.parsingData(data: data, model: T.self) {
            completion(.success(resultData))
        } else {
            completion(.failure(ErrorMessage.decodingError))
        }
    }

    func fetchMovieImage(url: URL, completion: @escaping (Result<Data, ErrorMessage>) -> Void) {
        if shouldReturnError {
            completion(.failure(ErrorMessage.networkError))
        } else if let data = mockData {
            completion(.success(data))
        } else {
            completion(.failure(ErrorMessage.noData))
        }
    }
}


