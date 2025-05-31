//
//  ContentView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var monsterDeck: MonsterDeck
    @StateObject private var teamDeck: TeamDeck
    @StateObject private var battleDeck: BattleDeck
    @State var selectedBattle: Battle? = nil
    
    init() {
            let monsterDeck = MonsterDeck()
            let teamDeck = TeamDeck()
            let battleDeck = BattleDeck(monsterDeck: monsterDeck, teamDeck: teamDeck)

            _monsterDeck = StateObject(wrappedValue: monsterDeck)
            _teamDeck = StateObject(wrappedValue: teamDeck)
            _battleDeck = StateObject(wrappedValue: battleDeck)
        }
    
    var body: some View {
        TabView {
            SettingsView(monsterDeck: monsterDeck, teamDeck: teamDeck, battleDeck: battleDeck, selectedBattle: $selectedBattle)
            StandardMonsterView(battleDeck: battleDeck, selectedBattle: $selectedBattle)
            
            
            
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

//#Preview {
//    ContentView()
//}
