//
//  VisitPlaces.swift
//  OurStories
//
//  Created by Xiang Xu on 30/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import MapKit

class VisitPlace: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
}
