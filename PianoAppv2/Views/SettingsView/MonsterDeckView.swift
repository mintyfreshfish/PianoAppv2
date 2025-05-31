//
//  MonsterDeckView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/29/25.
//

import SwiftUI

struct MonsterDeckView: View {
    @ObservedObject var monsterDeck: MonsterDeck
    @State var selectedMonster: StandardMonster?
    
    var body: some View {
        Section(header: Text("Your Monsters")) {
            if selectedMonster != nil {
                Button("Delete Monster") {
                    monsterDeck.remMonster(monster: selectedMonster!)
                    monsterDeck.archive()
                    selectedMonster = nil
                }
            }
            HStack {
                ForEach(monsterDeck.monsters, id: \.self) {
                    monster in VStack() {
                        if let uiImage = monster.loadImage() {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100.0)
                        } else {Text("Image Unavailable")}
                        VStack() {
                            Text("Name: \(monster.name)")
                            Text("Artist: \(monster.artist)")
                        }
                    }
                    .background(selectedMonster == monster ? Color.yellow : Color.clear)
                    .onTapGesture {
                        selectedMonster = monster
                    }
                }
            }
        }
    }
}

//#Preview {
//    MonsterDeckView()
//}
