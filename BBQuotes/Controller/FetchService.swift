//
//  FetchService.swift
//  BBQuotes
//
//  Created by chris on 2024/09/18.
//

import Foundation

struct FetchService{
    
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    // https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show: String) async throws -> Quote {
        
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(
            name: "production", value: show
        )])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        
        // Build fetch url
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(
            name: "name", value: name
        )])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        // Return response
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        
        // Build fetch url
        let fetchURL = baseURL.appending(path: "deaths")
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character{
                return death
            }
        }
        // Return nil if nothing
        return nil
    }
    
}
