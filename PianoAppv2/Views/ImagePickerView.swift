//
//  ImagePickerView.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/10/25.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @ObservedObject var monsterDeck: MonsterDeck
    @Binding var selectedMonster: StandardMonster?
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var name: String = ""
    @State private var hp: String = ""
    @State private var artist: String = ""
    @State private var miniboss: Bool = false
    
    
    var body: some View {
        Form {
            Section(header: Text("Monster Info")) {
                TextField("Name", text: $name)
                TextField("HP", text: $hp)
                    .keyboardType(.numberPad)
                if (!miniboss) {
                    TextField("Artist", text: $artist)
                }
                Toggle(isOn: $miniboss) { Text("Miniboss?")
                }
                //image picker
                if let data = selectedImageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                
                PhotosPicker("Select a Photo", selection: $selectedItem)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                
                Button("Save Monster") {
                    func checkData() -> Bool {
                        if name != "" && hp != "" && selectedImageData != nil {
                            return true
                        }
                        return false
                    }
                    
                    if checkData() {
                        //change imageData into string filename and save to docs folder
                        let filename = UUID().uuidString + ".png"
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
                        do {
                            try selectedImageData?.write(to: url)
                        } catch {
                            print ("Could not save imageData")
                        }
                        
                        //create monster and save
                        if miniboss {
                            let newMonster = MiniBoss(name: name, img: filename, hp: Int(hp)!)
                            newMonster.archive()
                        } else {
                            let newMonster = StandardMonster(name: name, img: filename, hp: Int(hp)!, artist: artist)
                            monsterDeck.addMonster(monster: newMonster)
                            monsterDeck.archive()
                        }
                        
                        //reset values
                        name = ""
                        hp = ""
                        artist = ""
                        selectedImageData = nil
                        selectedItem = nil
                        miniboss = false
                    } else {
                        print("invalid data")
                    }
                }
            }
                
                Section(header: Text("Your Monsters")) {
                    if selectedMonster != nil {
                        Button("Delete Monster") {
                            monsterDeck.remMonster(monster: selectedMonster!)
                            monsterDeck.archive()
                            selectedMonster = nil
                        }
                    }
                    ForEach(monsterDeck.monsters, id: \.self) {
                        monster in HStack() {
                            if let uiImage = monster.loadImage() {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100.0)
                            } else {Text("Image Unavailable")}
                            VStack() {
                                Text(monster.name)
                                Text(String(monster.hp))
                                Text(monster.artist)
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
