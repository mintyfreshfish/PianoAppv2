//
//  StandardMonsterView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/11/25.
//

import SwiftUI

struct StandardMonsterView: View {
    @ObservedObject var battleDeck: BattleDeck
    @ObservedObject var studentDeck: StudentDeck
    @Binding var selectedBattle: Battle?
    var monsterDeck: MonsterDeck
    
    @State private var dmg: Int = 0
    @State private var selectedStudent: String = ""
    
    func attack(attackDmg: Int) {
        let i = battleDeck.battles.firstIndex(where: { $0.id == selectedBattle!.id })!

        var battle = selectedBattle!
        var damage = attackDmg
        
        func nextMonster() {
            let team = battle.team
            let monster = battle.monster
            battleDeck.remBattle(team: team)
            
            let nextMonster = monsterDeck.nextMonster(monster: monster)
            let newBattle = Battle(monster: nextMonster, team: team)
            battleDeck.addBattle(battle: newBattle)
            
            selectedBattle = battleDeck.battles.last
            battle = battleDeck.battles.last!
            
            studentDeck.resetScores(teamName: battle.team.name)
        }
        
            if battle.leftoverDmg(damage: damage) >= 0 {
                damage = battle.leftoverDmg(damage: damage)
                nextMonster()
        }
        
        battleDeck.battles[i].addDmg(dmg: damage)
        studentDeck.students[studentDeck.indexOf(name: selectedStudent)!].updateScore(num: damage)
        battleDeck.archive()
    }
    
    var body: some View {
        VStack {
            if let battle = selectedBattle {
                MonsterHeaderView(battle: battle, studentDeck: studentDeck, dmg: $dmg, selectedStudent: $selectedStudent)
                    .onChange(of: dmg) { newValue in
                        if newValue != 0 {
                            attack(attackDmg: newValue)
                            dmg = 0
                        }
                    }
            } else {
                Text("Loading monster...")
            }
        }
    }
}


//#Preview {
//    StandardMonsterView(monsterDeck: MonsterDeck())
//}
