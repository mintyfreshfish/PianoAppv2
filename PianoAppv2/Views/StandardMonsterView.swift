//
//  StandardMonsterView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/11/25.
//

import SwiftUI

struct StandardMonsterView: View {
    @ObservedObject var monsterDeck: MonsterDeck
    @State var monster: StandardMonster? = nil
    @State private var userInput: String = ""
    
    
    var body: some View {
        VStack {
            if let monster = monster {
                MonsterHeaderView(monster: monster, userInput: $userInput)
                
                Button("ATTACK!") {
                    if let damage = Int(userInput) {
                        withAnimation {
                            monster.addDmg(dmg: damage)
                        }
                        userInput = ""
                    }
                    monsterDeck.archive()
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
        .onAppear {
            monster = monsterDeck.monsters.first
        }
        
    }
}

#Preview {
    StandardMonsterView(monsterDeck: MonsterDeck())
}
