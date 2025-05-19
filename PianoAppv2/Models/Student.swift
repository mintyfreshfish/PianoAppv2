//
//  Student.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/19/25.
//

import Foundation

class Student: Identifiable, Codable {
    var id = UUID()
    var index: Int
    var name: String
    var teamName: String
    var scoreInfo: (total: Int, num: Int)
    
    init(name: String) {
        self.index = 0
        self.name = name
        self.teamName = "team"
        self.scoreInfo = (total: 0, num: 0)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, index, name, teamName, scoreInfo
    }
    
    enum ScoreInfoKeys: String, CodingKey {
        case total, num
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        index = try container.decode(Int.self, forKey: .index)
        name = try container.decode(String.self, forKey: .name)
        teamName = try container.decode(String.self, forKey: .teamName)
        let scoreInfoContainer = try container.nestedContainer(keyedBy: ScoreInfoKeys.self, forKey: .scoreInfo)
        let total = try scoreInfoContainer.decode(Int.self, forKey: .total)
        let num = try scoreInfoContainer.decode(Int.self, forKey: .num)
        scoreInfo = (total, num)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(index, forKey: .index)
        try container.encode(name, forKey: .name)
        try container.encode(teamName, forKey: .teamName)
        
        var scoreInfoContainer = container.nestedContainer(keyedBy: ScoreInfoKeys.self, forKey: .scoreInfo)
        try scoreInfoContainer.encode(scoreInfo.total, forKey: .total)
        try scoreInfoContainer.encode(scoreInfo.num, forKey: .num)
    }
    
    func updateScore(num: Int) {
        scoreInfo.total += num
    }
    
    func updateNum() {
        scoreInfo.num += 1
    }
    
    func avgScore() -> Int {
        return Int(scoreInfo.total / scoreInfo.num)
    }
    
    func resetAvg() {
        self.scoreInfo = (total: 0, num: 0)
    }
}
