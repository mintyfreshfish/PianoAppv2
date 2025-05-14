//
//  ContentView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var monsterDeck = MonsterDeck()
    
    var body: some View {
        TabView {
            SettingsView(monsterDeck: monsterDeck)
            StandardMonsterView(monsterDeck: monsterDeck)
            
            
            
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    ContentView()
}
