//
//  NetworkService.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(url: URL, model: T.Type, completion: @escaping (Result<T, ErrorMessage>) -> Void)
    func fetchMovieImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol{
    
    func fetchData<T: Codable>(url: URL, model: T.Type, completion: @escaping (Result<T, ErrorMessage>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(ErrorMessage.invalidURL))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(ErrorMessage.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(ErrorMessage.noData))
                return
            }
            
            if let resultData = DataDecoder.parsingData(data: data, model: T.self){
                completion(.success(resultData))
            }else {
                completion(.failure(ErrorMessage.serializationError))
            }
        }.resume()
    }
    
    func fetchMovieImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{ return }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
    
}

enum ErrorMessage: String, Error{
    
//    case invalidURL = "There seems to be an issue with the connection. Please try again later."
//    case noData = "No information is available at the moment. Please try again shortly."
//    case decodingError = "We encountered an error while processing the information. Please try again later."
//    case networkError = "Please check your internet connection and try again."
//    case unknownError = "An unexpected error occurred. Please try again."
    
    case invalidResponse
        case invalidURL
        case apiError
        case noData
        case serializationError
        case noConnection
        var localizedDescription: String {
            switch self {
            case .invalidResponse: return "Invalid response code"
            case .noData: return "there is No data (Empty data)"
            case .serializationError: return "Failed in decoding data"
            case .invalidURL: return "Not a valid End Point"
            case .apiError: return "Problem in connecting with API"
            case .noConnection: return "the internet connection maybe lost or weak"
            }
        }
}
