//
//  SettingsView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/13/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var monsterDeck: MonsterDeck
    @ObservedObject var teamDeck: TeamDeck
    @ObservedObject var battleDeck: BattleDeck
    @Binding var selectedBattle: Battle?
    
    var body: some View {
        Form {
            AddTeamView(teamDeck: teamDeck, monsterDeck: monsterDeck, battleDeck: battleDeck)
            ImagePickerView(monsterDeck: monsterDeck)
            MonsterDeckView(monsterDeck: monsterDeck)
            BattleDeckView(monsterDeck: monsterDeck, battleDeck: battleDeck, selectedBattle: $selectedBattle)
        }
    }
}

//#Preview {
//    SettingsView(monsterDeck: MonsterDeck())
//}
