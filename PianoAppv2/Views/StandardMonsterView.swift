//
//  StandardMonsterView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/11/25.
//

import SwiftUI

struct StandardMonsterView: View {
    @ObservedObject var battleDeck: BattleDeck
    @Binding var selectedBattle: Battle?
    var monsterDeck: MonsterDeck
    
    @State private var userInput: String = ""
    
    var body: some View {
        VStack {
            if var battle = selectedBattle {
                MonsterHeaderView(battle: battle, userInput: $userInput)

                Button("ATTACK!") {
                    func nextMonster() {
                        let team = battle.team
                        let monster = battle.monster
                        battleDeck.remBattle(team: team)
                        
                        let nextMonster = monsterDeck.nextMonster(monster: monster)
                        let newBattle = Battle(monster: nextMonster, team: team)
                        battleDeck.addBattle(battle: newBattle)
                        
                        selectedBattle = battleDeck.battles.last
                        battle = battleDeck.battles.last!
                    }
                    
                    if var damage = Int(userInput) {
                        if battle.leftoverDmg(damage: damage) >= 0 {
                            damage = battle.leftoverDmg(damage: damage)
                            nextMonster()
                        }
                        
                        withAnimation {
                            battle.addDmg(dmg: damage)
                        }
                        userInput = ""
                    }
                    battleDeck.archive()
                }
                .padding()
                .background(Color(red: 1, green: 0.557, blue: 0))
                .clipShape(Capsule())
                .font(Font.custom("PermanentMarker-Regular", size: 30))
                .foregroundColor(Color.black)
            } else {
                Text("Loading monster...")
            }
        }
    }
}


//#Preview {
//    StandardMonsterView(monsterDeck: MonsterDeck())
//}
