//
//  Student.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/19/25.
//

import Foundation

class Student: ObservableObject, Codable {
    var id = UUID()
    var name: String
    var teamName: String
    var score: Int
    
    init(name: String, teamName: String) {
        self.name = name
        self.teamName = teamName
        self.score = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, teamName, score
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        teamName = try container.decode(String.self, forKey: .teamName)
        score = try container.decode(Int.self, forKey: .score)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(teamName, forKey: .teamName)
        try container.encode(score, forKey: .score)
    }
    
    func updateScore(num: Int) {
        score += num
    }
}

extension Student: Hashable {
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
