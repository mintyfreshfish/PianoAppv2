//
//  StandardMonsterView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/11/25.
//

import SwiftUI

struct StandardMonsterView: View {
    @ObservedObject var battleDeck: BattleDeck
    @Binding var selectedBattle: Battle?
    
    @State private var userInput: String = ""
    
    var body: some View {
        VStack {
            if let battle = selectedBattle {
                MonsterHeaderView(battle: battle, userInput: $userInput)

                Button("ATTACK!") {
                    if let damage = Int(userInput) {
                        withAnimation {
                            battle.addDmg(dmg: damage)
                        }
                        userInput = ""
                    }
                    battleDeck.archive()
                }
                .padding()
                .background(Color(red: 1, green: 0.557, blue: 0))
                .clipShape(Capsule())
                .font(Font.custom("PermanentMarker-Regular", size: 30))
                .foregroundColor(Color.black)
            } else {
                Text("Loading monster...")
            }
        }
    }
}


//#Preview {
//    StandardMonsterView(monsterDeck: MonsterDeck())
//}
