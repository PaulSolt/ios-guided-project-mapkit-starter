//
//  Quake+MKAnnotation.swift
//  Quakes
//
//  Created by Paul Solt on 6/4/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import MapKit

extension Quake: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        place
    }
    
    var subtitle: String? {
        "Magnitude: \(magnitude)"
    }
}
