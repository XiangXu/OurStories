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
    let imageName: String
    /// Position of the story in the deck.
    let order: Int
    
    init(title: String, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, imageName: String, order: Int) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.imageName = imageName
        self.order = order
        super.init()
    }
}
