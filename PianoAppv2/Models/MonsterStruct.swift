//
//  File.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/10/25.
//

import Foundation

class Monster: Codable {
    var name: String
    var img: String
    var hp: Int
    var damage: Int
    
    init(name: String, img: String, hp: Int) {
        self.name = name
        self.img = img
        self.hp = hp
        self.damage = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case name, img, hp, damage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.img = try container.decode(String.self, forKey: .img)
        self.hp = try container.decode(Int.self, forKey: .hp)
        self.damage = try container.decode(Int.self, forKey: .damage)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(img, forKey: .img)
        try container.encode(hp, forKey: .hp)
        try container.encode(damage, forKey: .damage)
    }
    
    func addDmg(dmg: Int) {
        self.damage += dmg
        if self.damage > self.hp {
            self.damage = self.hp
        }
    }
    
    func subDmg(dmg: Int) {
        self.damage -= dmg
        if self.damage < 0 {
            self.damage = 0
        }
    }
    
    func dmgPercent() -> Double {
        return Double(self.damage) / Double(self.hp)
    }
}

class StandardMonster: Monster {
    var artist: String
    
    init(name: String, img: String, hp: Int, artist: String) {
        self.artist = artist
        super.init(name: name, img: img, hp: hp)
    }
    
    enum CodingKeys: String, CodingKey {
        case artist
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artist = try container.decode(String.self, forKey: .artist)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(artist, forKey: .artist)
        try super.encode(to: encoder)
    }
    
    override init(name: String, img: String, hp: Int) {
        self.artist = ""
        super.init(name: name, img: img, hp: hp)
    }
}

class MiniBoss: Monster {
    func archive() {
        // Step 1: Get the path to the Documents directory
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        // Step 2: Create a path for the JSON file
        let jsonFilePath = documentsDirectory.appendingPathComponent("MiniBoss.json")

        // Step 3: Encode data
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted //readable format
            let jsonData = try encoder.encode(self)
            
            // Step 5: Write the JSON data to the file in the Documents directory
            try jsonData.write(to: jsonFilePath)
            print("JSON data was written to the file successfully at: \(jsonFilePath)")
            
        } catch {
            print("Error while writing to file: \(error.localizedDescription)")
        }
    }
}
