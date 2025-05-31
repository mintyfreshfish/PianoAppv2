//
//  BattleDeckView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/29/25.
//

import SwiftUI

struct BattleDeckView: View {
    @ObservedObject var monsterDeck: MonsterDeck
    @ObservedObject var battleDeck: BattleDeck
    @Binding var selectedBattle: Battle?
    @State var hp: String = ""
    @State var dmg: String = ""
    
    var body: some View {
        Section(header: Text("Your Battles")) {
            if selectedBattle != nil {
                HStack {
                    TextField("HP", text: $hp)
                        .keyboardType(.numberPad)
                    Button("Update HP") {
                        if let newHP = Int(hp), !hp.isEmpty {
                            selectedBattle?.hp = newHP
                            battleDeck.archive()
                            hp = ""
                        }
                    }
                    TextField("DMG", text: $dmg)
                        .keyboardType(.numberPad)
                    Button("Update DMG") {
                        if let newDMG = Int(dmg), !dmg.isEmpty {
                            selectedBattle?.dmg = newDMG
                            battleDeck.archive()
                            dmg = ""
                        }
                    }
                }
            }
            VStack {
                ForEach(battleDeck.battles, id: \.self) { battle in
                    BattleRowView(battle: battle, isSelected: selectedBattle == battle)
                        .onTapGesture {
                            selectedBattle = battle
                        }
                }

            }
        }
    }
}

//#Preview {
//    BattleDeckView()
//}
