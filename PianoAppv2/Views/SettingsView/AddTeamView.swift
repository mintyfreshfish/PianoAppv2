//
//  AddTeamView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/29/25.
//

import SwiftUI

struct AddTeamView: View {
    @ObservedObject var teamDeck: TeamDeck
    @ObservedObject var monsterDeck: MonsterDeck
    @ObservedObject var battleDeck: BattleDeck
    
    @State private var name: String = ""
    
    var body: some View {
        Section(header: Text("Add Team")) {
            TextField("Name", text: $name)
            
            Button("Save Team") {
                func checkData() -> Bool {
                    if name == "" {
                        return false
                    }
                    if monsterDeck.monsters.count == 0 {
                        return false
                    }
                    return true
                }
                
                if checkData() {
                    let newTeam = Team(name: name)
                    teamDeck.addTeam(team: newTeam)
                    teamDeck.archive()
                    
                    let newBattle = Battle(monster: monsterDeck.monsters.first ?? StandardMonster(), team: newTeam)
                    battleDeck.addBattle(battle: newBattle)
                    battleDeck.archive()
                    
                    
                    name = ""
                }
            }
        }
    }
}

//#Preview {
//    AddTeamView()
//}
