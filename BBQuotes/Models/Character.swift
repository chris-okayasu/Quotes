//
//  Character.swift
//  BBQuotes
//
//  Created by chris on 2024/09/16.
//

import Foundation

struct Character: Decodable{
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL] // is an array of url as string but swift can convert
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death?
    
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        death = try deathDecoder.decode(Death.self, from: deathData)
    }
}
