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
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}
