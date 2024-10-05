//
//  ErrorMessage.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import Foundation

enum ErrorMessage: String, Error{
    case invalidURL
    case invalidResponse
    case networkError
    case noData
    case decodingError
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "There seems to be an issue with the connection. Please try again later."
        case .invalidResponse: return "There seems to be an issue with the connection. Please try again later."
        case .noData: return "No information is available at the moment. Please try again shortly."
        case .decodingError: return "We encountered an error while processing the information. Please try again later."
        case .networkError: return "Please check your internet connection and try again."
        }
    }
}
