//
//  NetworkService.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(url: URL, model: T.Type, completion: @escaping (Result<T, ErrorMessage>) -> Void)
    func fetchMovieImage(url: URL, completion: @escaping (Result<Data, ErrorMessage>) -> Void)
}

class NetworkService: NetworkServiceProtocol{
    
    func fetchData<T: Codable>(url: URL, model: T.Type, completion: @escaping (Result<T, ErrorMessage>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(ErrorMessage.networkError))
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
                completion(.failure(ErrorMessage.decodingError))
            }
        }.resume()
    }
    
    func fetchMovieImage(url: URL, completion: @escaping (Result<Data, ErrorMessage>) -> Void) {
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
