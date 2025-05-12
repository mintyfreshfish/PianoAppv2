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
        ImagePickerView(monsterDeck: monsterDeck)
    }
}

#Preview {
    ContentView()
}
