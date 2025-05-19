//
//  SettingsView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/13/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var monsterDeck: MonsterDeck
    @Binding var selectedMonster: StandardMonster?
    
    var body: some View {
        ImagePickerView(monsterDeck: monsterDeck, selectedMonster: $selectedMonster)
    }
}

//#Preview {
//    SettingsView(monsterDeck: MonsterDeck())
//}
