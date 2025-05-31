//
//  BattleClass.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/19/25.
//

import Foundation

class Codable_Battle: Codable {
    var id: UUID
    var monsterName: String
    var teamName: String
    var hp: Int
    var dmg: Int
    
    init(id: UUID, monsterName: String, teamName: String, hp: Int, dmg: Int) {
        self.id = id
        self.monsterName = monsterName
        self.teamName = teamName
        self.hp = hp
        self.dmg = dmg
    }
    
    enum CodingKeys: String, CodingKey {
        case id, monsterName, teamName, hp, dmg
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        monsterName = try container.decode(String.self, forKey: .monsterName)
        teamName = try container.decode(String.self, forKey: .teamName)
        hp = try container.decode(Int.self, forKey: .hp)
        dmg = try container.decode(Int.self, forKey: .dmg)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(monsterName, forKey: .monsterName)
        try container.encode(teamName, forKey: .teamName)
        try container.encode(hp, forKey: .hp)
        try container.encode(dmg, forKey: .dmg)
    }
    
}
