//
//  Record.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 27.08.23.
//

import Foundation

class Record: Codable {
    var name: String?
    var score: Int?
    
    init(name: String?, score: Int?) {
        self.name = name
        self.score = score
    }
    
    private enum CodingKeys: String, CodingKey {
        case nameKey
        case scoreKey
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .nameKey)
        score = try container.decodeIfPresent(Int.self, forKey: .scoreKey)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .nameKey)
        try container.encode(self.score, forKey: .scoreKey)
    }
}

