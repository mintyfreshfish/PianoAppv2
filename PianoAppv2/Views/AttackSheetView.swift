//
//  AttackSheetView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 9/9/25.
//

import SwiftUI

struct AttackSheetView: View {
    @ObservedObject var battle: Battle
    @State var userInput: String = ""
    @Binding var dmg: Int
    @Binding var selectedStudent: String
    @Binding var showSheet: Bool
    var studentNames: [String]
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var body: some View {
        //Student Picker
        Picker("Student", selection: $selectedStudent)
        {
            ForEach(studentNames, id: \.self) {
                student in
                Text(student).tag(Optional(student))
            }
        }
        
        //User Input
        Text(userInput == "" ? "Enter Damage" : userInput)
            .font(Font.custom("PermanentMarker-Regular", size: 40))
            .padding()
        
        HStack {
            ForEach(numbers, id: \.self) { number in
                Button(number, action: {userInput += number})
                    .padding()
                    .background(Color.white)
                    .clipShape(Rectangle())
                    .font(Font.custom("PermanentMarker-Regular", size: 20))
                    .foregroundColor(Color.black)
            }
            Button("Undo", action: {userInput = String(userInput.dropLast())})
                .padding()
                .background(Color.white)
                .clipShape(Rectangle())
                .font(Font.custom("PermanentMarker-Regular", size: 20))
                .foregroundColor(Color.black)
        }
        Button("Attack!") {
            if let damage = Int(userInput) {
                dmg = damage
            }
            showSheet = false
        }
        .padding()
        .background(Color(red: 1, green: 0.557, blue: 0))
        .clipShape(Capsule())
        .font(Font.custom("PermanentMarker-Regular", size: 30))
        .foregroundColor(Color.black)
    }
}

//#Preview {
//    AttackSheetView()
//}
