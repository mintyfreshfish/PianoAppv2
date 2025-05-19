//
//  BattleClass.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/19/25.
//

import Foundation

class Battle: ObservableObject, Codable {
    var id = UUID()
    var monsterName: String
    var team: String
    var hp: Int
    var dmg: Int
    
    init(monsterName: String, team: String) {
        func hp() -> Int {
            switch team {
                case "Monday": return 200
                case "Tuesday": return 300
                case "Wednesday": return 500
                case "Thursday": return 500
                case "Saturday": return 400
                default: return 350
            }
        }
        
        self.monsterName = monsterName
        self.team = team
        self.hp = hp()
        self.dmg = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id, monsterName, team, hp, dmg
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        monsterName = try container.decode(String.self, forKey: .monsterName)
        team = try container.decode(String.self, forKey: .team)
        hp = try container.decode(Int.self, forKey: .hp)
        dmg = try container.decode(Int.self, forKey: .dmg)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(monsterName, forKey: .monsterName)
        try container.encode(team, forKey: .team)
        try container.encode(hp, forKey: .hp)
        try container.encode(dmg, forKey: .dmg)
    }
    
    func addDmg(dmg: Int) {
        self.dmg += dmg
    }
    
    func subDmg(dmg: Int) {
        self.dmg -= dmg
    }
}
