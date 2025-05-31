//
//  MonsterDeckView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/29/25.
//

import SwiftUI

struct TeamDeckView: View {
    @ObservedObject var teamDeck: TeamDeck
    @ObservedObject var battleDeck: BattleDeck
    @State var selectedTeam: Team?
    
    var body: some View {
        Section(header: Text("Your Teams")) {
            if selectedTeam != nil {
                Button("Delete Team") {
                    teamDeck.remTeam(team: selectedTeam!)
                    teamDeck.archive()
                    battleDeck.remBattle(team: selectedTeam!)
                    battleDeck.archive()
                    selectedTeam = nil
                }
            }
            HStack {
                ForEach(teamDeck.teams, id: \.self) {
                    team in VStack() {
                        Text("Name: \(team.name)")
                    }
                    .background(selectedTeam == team ? Color.yellow : Color.clear)
                    .onTapGesture {
                        selectedTeam = team
                    }
                }
            }
        }
    }
}

//#Preview {
//    MonsterDeckView()
//}
