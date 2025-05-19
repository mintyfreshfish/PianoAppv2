//
//  StudentClass.swift
//  PianoAppv2
//
//  Created by Rebecca Jackson on 5/13/25.
//

import Foundation

class NStudent {
    var name: String
    var lessonTime: Date
    
    init(name: String) {
        self.name = name
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2001
        components.month = 1
        components.day = 1
        components.hour = 0
        components.minute = 0
        if let date = calendar.date(from: components) {
            self.lessonTime = date
        } else {
            // fallback in case something goes wrong
            self.lessonTime = Date()
        }
    }
    
    func changeName(name: String) {
        self.name = name
    }
    
    func changelessonTime(lessonTime: Date) {
        self.lessonTime = lessonTime
    }
}
