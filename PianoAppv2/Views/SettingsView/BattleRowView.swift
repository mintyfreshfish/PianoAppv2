//
//  BattleRowView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/30/25.
//

import SwiftUI

struct BattleRowView: View {
    @ObservedObject var battle: Battle
    var isSelected: Bool

    var body: some View {
        HStack {
            if let uiImage = battle.monster.loadImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            } else {
                Text("Image Unavailable")
            }
            VStack {
                Text("Team: \(battle.team.name)")
                Text("\(battle.dmg)/\(battle.hp)")
            }
        }
        .background(isSelected ? Color.yellow : Color.clear)
    }
}
