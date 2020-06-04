//
//  EarthquakesViewController.swift
//  Quakes
//
//  Created by Paul Solt on 10/3/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import MapKit

class EarthquakesViewController: UIViewController {
	
    var quakeFetcher = QuakeFetcher()
    
	// NOTE: You need to import MapKit to link to MKMapView
	@IBOutlet var mapView: MKMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "QuakeView")
		
        quakeFetcher.fetchQuakes { (quakes, error) in
            if let error = error {
                print("Error fetching quakes: \(error)")
                return
            }
            
            guard let quakes = quakes else {
                print("NO quakes returned?")
                return
            }
            
            print(quakes.count)
            
            self.mapView.addAnnotations(quakes)
            
            // Zoom to an earthquake (assume in the future ... sorted by mag)
            guard let quake = quakes.first else { return }

            let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            let region = MKCoordinateRegion(center: quake.coordinate, span: coordinateSpan)

            self.mapView.setRegion(region, animated: true)
        }
	}
}

// Like a table view delegate
extension EarthquakesViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let quake = annotation as? Quake else {
            fatalError("Only Quake objects are supported right now")
        }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "QuakeView", for: quake) as? MKMarkerAnnotationView else {
            fatalError("Missing a registered map annotation view") // Programmer error, fail early, fix it right away
        }
        
        annotationView.glyphImage = UIImage(named: "QuakeIcon")
        
        if quake.magnitude >= 5 {
            annotationView.markerTintColor = .systemRed
        } else if quake.magnitude >= 3 && quake.magnitude < 5 {
            annotationView.markerTintColor = .systemOrange
        } else {
            annotationView.markerTintColor = .systemYellow
        }
        
        annotationView.canShowCallout = true
        let detailView = QuakeDetailView()
        detailView.quake = quake
        annotationView.detailCalloutAccessoryView = detailView
        
        return annotationView
    }
}
