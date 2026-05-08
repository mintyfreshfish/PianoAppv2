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

    // 3x3 keypad layout
    let gridNumbers = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"]
    ]

    var body: some View {

        VStack(spacing: 25) {

            // MARK: - Student Picker

            Picker("Student", selection: $selectedStudent) {

                Text("Choose student")
                    .tag("")

                ForEach(studentNames, id: \.self) { student in
                    Text(student)
                        .tag(student)
                }
            }
            .pickerStyle(.menu)

            // MARK: - Only show keypad after student selected

            if !selectedStudent.isEmpty {

                // Display
                Text(userInput.isEmpty ? "Enter Damage" : userInput)
                    .font(Font.custom("PermanentMarker-Regular", size: 40))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(16)

                // MARK: - Number Grid

                VStack(spacing: 16) {

                    ForEach(gridNumbers, id: \.self) { row in

                        HStack(spacing: 16) {

                            ForEach(row, id: \.self) { number in
                                keypadButton(number)
                            }
                        }
                    }

                    // Bottom row
                    HStack(spacing: 16) {

                        keypadButton("0")

                        Button {
                            userInput = String(userInput.dropLast())
                        } label: {
                            Text("Undo")
                                .font(Font.custom("PermanentMarker-Regular", size: 24))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 80)
                                .background(Color.white)
                                .cornerRadius(16)
                        }
                    }
                }

                // MARK: - Attack Button

                Button("Attack!") {

                    if let damage = Int(userInput) {
                        dmg = damage
                    }

                    showSheet = false
                }
                .disabled(userInput.isEmpty)
                .padding(.horizontal)
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color(red: 1, green: 0.557, blue: 0))
                .clipShape(Capsule())
                .font(Font.custom("PermanentMarker-Regular", size: 30))
                .foregroundColor(.black)
            }
        }
        .padding()
    }

    // MARK: - Reusable Keypad Button

    @ViewBuilder
    func keypadButton(_ number: String) -> some View {

        Button {
            userInput += number
        } label: {
            Text(number)
                .font(Font.custom("PermanentMarker-Regular", size: 32))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(Color.white)
                .cornerRadius(16)
        }
    }
}

//import SwiftUI
//
//struct AttackSheetView: View {
//    @ObservedObject var battle: Battle
//    @State var userInput: String = ""
//    @Binding var dmg: Int
//    @Binding var selectedStudent: String
//    @Binding var showSheet: Bool
//    var studentNames: [String]
//    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
//    
//    var body: some View {
//        //Student Picker
//        Picker("Student", selection: $selectedStudent) {
//            
//            // Placeholder (default state)
//            Text("Choose student")
//                .tag(String?.none)
//
//            ForEach(studentNames, id: \.self) { student in
//                Text(student)
//                    .tag(Optional(student))
//            }
//        }
//        //User Input
//        Text(userInput == "" ? "Enter Damage" : userInput)
//            .font(Font.custom("PermanentMarker-Regular", size: 40))
//            .padding()
//        
//        HStack {
//            ForEach(numbers, id: \.self) { number in
//                Button(number, action: {userInput += number})
//                    .padding()
//                    .background(Color.white)
//                    .clipShape(Rectangle())
//                    .font(Font.custom("PermanentMarker-Regular", size: 20))
//                    .foregroundColor(Color.black)
//            }
//            Button("Undo", action: {userInput = String(userInput.dropLast())})
//                .padding()
//                .background(Color.white)
//                .clipShape(Rectangle())
//                .font(Font.custom("PermanentMarker-Regular", size: 20))
//                .foregroundColor(Color.black)
//        }
//        Button("Attack!") {
//            if let damage = Int(userInput) {
//                dmg = damage
//            }
//            showSheet = false
//        }
//        .padding()
//        .background(Color(red: 1, green: 0.557, blue: 0))
//        .clipShape(Capsule())
//        .font(Font.custom("PermanentMarker-Regular", size: 30))
//        .foregroundColor(Color.black)
//    }
//}

//#Preview {
//    AttackSheetView()
//}
