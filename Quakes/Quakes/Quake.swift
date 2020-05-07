//
//  Quake.swift
//  Quakes
//
//  Created by Paul Solt on 5/7/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

// Objective-C based maps require NSObject subclass
class Quake: NSObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
    }
    
    let magnitude: Double
    let place: String
    let time: Date
    let latitude: Double
    let longitude: Double
    
    required init(from decoder: Decoder) throws {
        // Containers
        
        // Set each values here
        self.magnitude = 0
        self.place = ""
        self.time = Date()
        self.latitude = 0
        self.longitude = 0
        
        super.init()
    }
}
