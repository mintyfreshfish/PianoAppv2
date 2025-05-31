//
//  MonsterHeaderView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/11/25.
//

import SwiftUI

struct MonsterHeaderView: View {
    var battle: Battle
    @Binding var userInput: String
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    
    var body: some View {
        VStack {
            // HEADER
            Text(battle.monster.name)
                    .font(Font.custom("PermanentMarker-Regular", size: 50))
            if let uiImage = battle.monster.loadImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 800.0)
            }
            
            HStack {
                Text((battle.monster as? StandardMonster)?.artist ?? "MiniBoss")
                    .font(Font.custom("PermanentMarker-Regular", size: 20))
                    .padding(.trailing, 100.0)
                Text("Hit Points: \(battle.monster.hp)")
                    .font(Font.custom("PermanentMarker-Regular", size: 20))
            }
            
            
            //  HP Bar
            HStack {
                Rectangle()
                    .fill(.red)
                    .frame(width: battle.dmgPercent()*1000, height: 50)
                Rectangle()
                    .fill(.white)
                    .frame(width: (1-battle.dmgPercent())*1000, height: 50)
            }
            .padding()
            
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
