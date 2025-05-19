//
//  ContentView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var monsterDeck = MonsterDeck()
    @State var selectedMonster: StandardMonster? = nil
    
    var body: some View {
        TabView {
            SettingsView(monsterDeck: monsterDeck, selectedMonster: $selectedMonster)
            StandardMonsterView(monsterDeck: monsterDeck, selectedMonster: $selectedMonster)
            
            
            
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

//#Preview {
//    ContentView()
//}
