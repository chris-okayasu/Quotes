//
//  ViewModel.swift
//  BBQuotes
//
//  Created by chris on 2024/09/18.
//

import Foundation

@Observable
class ViewModel {
    
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Character
    
    init(){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        //        if let quoteData = Bundle.main.url(forResource: "samplequote", withExtension: "json"){
        //            do{
        //                let data = try Data(contentsOf: quoteData)
        //                let decoder = JSONDecoder()
        //                decoder.keyDecodingStrategy = .convertFromSnakeCase
        //                quote = try decoder.decode(Quote.self, from: data)
        //            }catch{
        //                print("Error decoding JSON data: \(error)")
        //            }
        //        }
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
    }
    
    func getData(for show: String) async {
        status = .fetching
        do{
            quote = try await fetcher.fetchQuote(from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .success
            
        } catch {
            status = .failed(error: error)
            
            print("Fetching error \(error)")
        }
    }
}
