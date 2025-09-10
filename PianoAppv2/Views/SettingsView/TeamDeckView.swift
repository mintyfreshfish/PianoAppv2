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
    @ObservedObject var studentDeck: StudentDeck
    @State var selectedTeam: Team?
    @State var selectedStudent: Student?
    
    @State var name: String = ""
    @State var minHP: String = ""
    @State var maxHP: String = ""
    @State var studentName: String = ""
    
    var body: some View {
        Section(header: Text("Your Teams")) {
            if selectedTeam != nil {
                HStack {
                    
                    TextField("student name", text: $studentName)
                    Button("Add Student") {
                        studentDeck.addStudent(name: studentName, teamName: selectedTeam!.name)
                        studentDeck.archive()
                        studentName = ""
                    }
                    
                    TextField("minHP", text: $minHP)
                        .keyboardType(.numberPad)
                    Button("Update minHP") {
                        if let newminHP = Int(minHP), !minHP.isEmpty {
                            selectedTeam?.minHP = newminHP
                            teamDeck.archive()
                            minHP = ""
                        }
                    }
                    
                    TextField("maxHP", text: $maxHP)
                        .keyboardType(.numberPad)
                    Button("Update maxHP") {
                        if let newmaxHP = Int(maxHP), !maxHP.isEmpty {
                            selectedTeam?.maxHP = newmaxHP
                            teamDeck.archive()
                            maxHP = ""
                        }
                    }
                    
                    

                }
            }
            HStack {
                ForEach(teamDeck.teams, id: \.self) {
                    team in TeamRowView(team: team, studentList: studentDeck.retStudentsByTeam(team: team.name), isSelected: selectedTeam == team)
                    .onTapGesture {
                        selectedTeam = team
                    }
                }
            }
            if selectedTeam != nil {
                Button("Delete Team") {
                    teamDeck.remTeam(team: selectedTeam!)
                    teamDeck.archive()
                    battleDeck.remBattle(team: selectedTeam!)
                    battleDeck.archive()
                    selectedTeam = nil
                }
                Picker("Student", selection: $selectedStudent) {
                    ForEach(studentDeck.retStudentsByTeam(team: selectedTeam!.name), id: \.self) {
                        student in Text(student.name).tag(Optional(student))
                    }
                }
                Button("Remove Student") {
                    studentDeck.remStudent(name: selectedStudent!.name)
                    studentDeck.archive()
                }
                
            }
        }
    }
}

//#Preview {
//    MonsterDeckView()
//}
