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
    
    var body: some View {
        Section(header: Text("Your Battles")) {
//            if selectedBattle != nil {
//                Button("Delete Monster") {
//                    monsterDeck.remMonster(monster: selectedBattle!)
//                    monsterDeck.archive()
//                    selectedBattle = nil
//                }
//            }
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
