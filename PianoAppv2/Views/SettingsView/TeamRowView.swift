//
//  BattleRowView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/30/25.
//

import SwiftUI

struct TeamRowView: View {
    @ObservedObject var team: Team
    var studentList: [Student]
    var isSelected: Bool

    var body: some View {
            VStack {
                Text("Name: \(team.name)")
                Text("HP: \(team.minHP)-\(team.maxHP)")
                Text("Students:")
                Text(studentList.map { $0.name }
                    .joined(separator: "\n")
                     )
            }
        .background(isSelected ? Color.yellow : Color.clear)
    }
}
