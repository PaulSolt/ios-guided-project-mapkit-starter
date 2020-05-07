//
//  QuakeResults.swift
//  Quakes
//
//  Created by Paul Solt on 5/7/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class QuakeResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case quakes = "features"
    }

    let quakes: [Quake]
}
