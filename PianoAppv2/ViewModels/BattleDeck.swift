//
//  BattleDeck.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/19/25.
//

import Foundation

class BattleDeck: ObservableObject {
    @Published var battles: [Battle]
    
    init() {
        func decodeBattles(fromFile fileName: String) -> [Battle]? {
            let fileManager = FileManager.default

            // Get the path to the Documents folder
            guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Could not find Documents folder.")
                return nil
            }

            // Append the file name to the Documents URL
            let fileURL = documentsURL.appendingPathComponent(fileName)

            do {
                // Read the contents of the file as Data
                let jsonData = try Data(contentsOf: fileURL)

                // Decode the JSON data
                let battles = try JSONDecoder().decode([Battle].self, from: jsonData)
                return battles
            } catch {
                print("Error decoding JSON from file: \(error)")
                return nil
            }
        }
        
        let arr = decodeBattles(fromFile: "battleDeck.json") ?? []
        self.battles = arr
    }
    
    func addBattle(battle: Battle) {
        battles.append(battle)
    }
    
    func remBattle(battle: Battle) {
        self.battles.removeAll { $0.id == battle.id }
    }
    
    func archive() {
        // Step 1: Get the path to the Documents directory
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        // Step 2: Create a path for the JSON file
        let jsonFilePath = documentsDirectory.appendingPathComponent("battleDeck.json")

        // Step 3: Encode data
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted //readable format
            let jsonData = try encoder.encode(self.battles)
            
            // Step 5: Write the JSON data to the file in the Documents directory
            try jsonData.write(to: jsonFilePath)
            print("JSON data was written to the file successfully at: \(jsonFilePath)")
            
        } catch {
            print("Error while writing to file: \(error.localizedDescription)")
        }
    }
}
