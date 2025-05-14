//
//  SettingsView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/13/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var monsterDeck: MonsterDeck
    
    var body: some View {
        ImagePickerView(monsterDeck: monsterDeck)
    }
}

#Preview {
    SettingsView(monsterDeck: MonsterDeck())
}
