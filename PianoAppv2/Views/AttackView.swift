//
//  AttackView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/11/25.
//

import SwiftUI

struct AttackView: View {
    @State var userInput: String = ""
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var body: some View {
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
    }
}

#Preview {
    AttackView()
}
