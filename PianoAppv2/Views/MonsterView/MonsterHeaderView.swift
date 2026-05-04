//
//  MonsterHeaderView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/11/25.
//

import SwiftUI

struct MonsterHeaderView: View {
    @ObservedObject var battle: Battle
    @ObservedObject var studentDeck: StudentDeck
    @Binding var dmg: Int
    @Binding var selectedStudent: String
    
    @State private var showSheet = false
    
    var rankedStudents: [RankedStudent] {
        sortedStudents.ranked()
    }
    
    var podiumStudents: [RankedStudent] {
        rankedStudents.filter { $0.rank < 3 }
    }
    
    var remainingStudents: [RankedStudent] {
        rankedStudents.filter { $0.rank >= 3 }
    }
    
    var sortedStudents: [Student] {
        studentDeck.retStudentsByTeam(team: battle.team.name)
            .sorted {$0.score > $1.score}
            .map { $0 }
    }
    
    var medals = ["🥇", "🥈", "🥉"]
    var studentNames: [String] {
        studentDeck.retStudentsByTeam(team: battle.team.name)
            .map { $0.name }
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                // HEADER
                Text(battle.team.name)
                Text(battle.monster.name)
                    .font(Font.custom("PermanentMarker-Regular", size: 50))
                if let uiImage = battle.monster.loadImage() {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 740.0)
                }
                
                HStack {
                    Text((battle.monster as? StandardMonster)?.artist ?? "MiniBoss")
                        .font(Font.custom("PermanentMarker-Regular", size: 20))
                        .padding(.trailing, 100.0)
                    Text("Hit Points: \(battle.hp)")
                        .font(Font.custom("PermanentMarker-Regular", size: 20))
                }
                
                
                //  HP Bar
                HStack {
                    Rectangle()
                        .fill(.red)
                        .frame(width: battle.dmgPercent()*1000, height: 50)
                        .overlay(
                            Text(String(battle.dmg))
                        )
                    Rectangle()
                        .fill(.white)
                        .frame(width: (1-battle.dmgPercent())*1000, height: 50)
                        .overlay(
                            Text(String(battle.hp-battle.dmg))
                        )
                }
                .padding()
                
                
                VStack(spacing: 16) {
                    
                    Text("Leaderboard")
                        .font(Font.custom("PermanentMarker-Regular", size: 30))
                    
                    PodiumView(students: podiumStudents)
                    
                    Divider()
                    
                    LeaderboardListView(students: remainingStudents)
                }
                .frame(maxWidth: .infinity)
                .padding()
                
            }
            .onTapGesture {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                AttackSheetView(battle: battle, dmg: $dmg, selectedStudent: $selectedStudent, showSheet: $showSheet,  studentNames: studentNames)
            }
        }
    }
}

//#Preview {
//    struct Preview: View {
//        @State var userInput: String = ""
//        var body: some View {
//            MonsterHeaderView(monster: Monster(), userInput: $userInput)
//        }
//    }
//    return Preview()
//}
