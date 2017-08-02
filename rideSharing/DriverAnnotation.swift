//
//  DriverAnotation.swift
//  rideSharing
//
//  Created by Aivars Meijers on 30.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import Foundation
import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, withKey key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
    
    func update(anotationPosition annotation: DriverAnnotation, withCoordinate coordinate: CLLocationCoordinate2D) {
        var location = self.coordinate
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        //Ainimate coordinate
        UIView.animate(withDuration: 0.2) { 
            self.coordinate = location
        }
        
    }
}
