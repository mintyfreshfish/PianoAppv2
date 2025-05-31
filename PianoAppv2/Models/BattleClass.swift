//
//  BattleClass.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/19/25.
//

import Foundation

class Battle: ObservableObject {
    var id = UUID()
    var monster: StandardMonster
    var team: Team
    @Published var hp: Int
    @Published var dmg: Int
    
    init(monster: StandardMonster, team: Team) {
        self.monster = monster
        self.team = team
        self.hp = 200
        self.dmg = 0
    }
    
    init(archivedBattle: Codable_Battle, monsterDeck: MonsterDeck, teamDeck: TeamDeck) {
        
        self.monster = monsterDeck.monsters.first(where: {$0.name == archivedBattle.monsterName}) ?? StandardMonster()
        self.team = teamDeck.teams.first(where: {$0.name == archivedBattle.teamName}) ?? Team()
        self.hp = archivedBattle.hp
        self.dmg = archivedBattle.dmg
    }
    
    init() {
        self.monster = StandardMonster()
        self.team = Team()
        self.hp = 0
        self.dmg = 0
    }
    
    func addDmg(dmg: Int) {
        self.dmg += dmg
    }
    
    func subDmg(dmg: Int) {
        self.dmg -= dmg
    }
    
    func toCodable() -> Codable_Battle {
        return Codable_Battle(id: id, monsterName: monster.name, teamName: team.name, hp: hp, dmg: dmg)
    }
    
    func dmgPercent() -> Double {
        return Double(self.dmg) / Double(self.hp)
    }
    
    
    
}

extension Battle: Hashable {
    static func == (lhs: Battle, rhs: Battle) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
